%{
    (* required helper *)
    open Expression
%}

(* datatypes *)
%token <int> BILANGAN
%token <float> DESIMAL
%token <string> LARIK_KARAKTER
%token <bool> BENAR
%token <bool> SALAH

(* reserved keywords *)
%token DIKETAHUI
%token TAMPILKAN
%token JIKA MAKA
%token FUNGSI ADALAH

(* operations *)
%token TAMBAH KURANG KALI BAGI MODULO
%token DAN ATAU BUKAN
%token SAMA_DENGAN LEBIH_KECIL LEBIH_BESAR
%token LPAREN RPAREN MINUS

(* file token *)
%token EOL EOF_TOKEN INVALID_TOKEN

(* precedences *)
%left TAMBAH KURANG
%left KALI BAGI MODULO
%nonassoc UNIVERSAL_MINUS

%start <Expression.expr> main

%%
main:
    | be = bilangan_expr; EOL { be }
    | de = desimal_expr; EOL { de }
    | boe = boolean_expr; EOL { boe }
    | iao = invalid_arithmatic_expr; EOL { iao }
    | ibe = invalid_boolean_expr; EOL { ibe }
    | error EOL { ErrorExpression "error-00" }
;

bilangan_expr:
    | b = BILANGAN { Bilangan b }
    (* parantheses *)
    | LPAREN; be = bilangan_expr; RPAREN { be }
    (* arithmatic operations for integer *)
    | be1 = bilangan_expr; TAMBAH; be2 = bilangan_expr { BilanganExpression (TambahBilangan, be1, be2) }
    | be1 = bilangan_expr; KURANG; be2 = bilangan_expr { BilanganExpression (KurangBilangan, be1, be2) }
    | be1 = bilangan_expr; KALI; be2 = bilangan_expr { BilanganExpression (KaliBilangan, be1, be2) }
    | be1 = bilangan_expr; BAGI; be2 = bilangan_expr { BilanganExpression (BagiBilangan, be1, be2) }
    | be1 = bilangan_expr; MODULO; be2 = bilangan_expr { BilanganExpression (ModuloBilangan, be1, be2) }
;

desimal_expr:
    | d = DESIMAL { Desimal d }
    | LPAREN; de = desimal_expr; RPAREN { de }
    (* arithmatic operations for floating point *)
    | de1 = desimal_expr; TAMBAH; de2 = desimal_expr { DesimalExpression (TambahDesimal, de1, de2) }
    | de1 = desimal_expr; KURANG; de2 = desimal_expr { DesimalExpression (KurangDesimal, de1, de2) }
    | de1 = desimal_expr; KALI; de2 = desimal_expr { DesimalExpression (KaliDesimal, de1, de2) }
    | de1 = desimal_expr; BAGI; de2 = desimal_expr { DesimalExpression (BagiDesimal, de1, de2) }
;

boolean_expr:
    | bo = BENAR { Bool bo }
    | bo = SALAH { Bool bo }
    | LPAREN; boe = boolean_expr; RPAREN { boe }
    (* boolean operators *)
    | boe1 = boolean_expr; DAN; boe2 = boolean_expr { BooleanExpression (BooleanDan, boe1, boe2) }
    | boe1 = boolean_expr; ATAU; boe2 = boolean_expr { BooleanExpression (BooleanAtau, boe1, boe2) }
    (* additional operations that boolean support *)
    | boe1 = boolean_expr; SAMA_DENGAN; boe2 = boolean_expr { BooleanExpression (BooleanSamaDengan, boe1, boe2) }
    | be1 = bilangan_expr; SAMA_DENGAN; be2 = bilangan_expr { BooleanExpression (BooleanSamaDengan, be1, be2) }
    | de1 = desimal_expr; SAMA_DENGAN; de2 = desimal_expr { BooleanExpression (BooleanSamaDengan, de1, de2) }
    | be1 = bilangan_expr; LEBIH_KECIL; be2 = bilangan_expr { BooleanExpression (BooleanLebihKecil, be1, be2)}
    | de1 = desimal_expr; LEBIH_KECIL; de2 = desimal_expr { BooleanExpression (BooleanLebihKecil, de1, de2) }
    | be1 = bilangan_expr; LEBIH_BESAR; be2 = bilangan_expr { BooleanExpression (BooleanLebihBesar, be1, be2) }
    | de1 = desimal_expr; LEBIH_BESAR; de2 = desimal_expr { BooleanExpression (BooleanLebihBesar, de1, de2) }
;

invalid_arithmatic_expr:
    | bilangan_expr TAMBAH desimal_expr { ErrorExpression "error-01" }
    | desimal_expr TAMBAH bilangan_expr { ErrorExpression "error-01" }
    | bilangan_expr KURANG desimal_expr { ErrorExpression "error-01" }
    | desimal_expr KURANG bilangan_expr { ErrorExpression "error-01" }
    | bilangan_expr KALI desimal_expr { ErrorExpression "error-01" }
    | desimal_expr KALI bilangan_expr { ErrorExpression "error-01" }
    | bilangan_expr BAGI desimal_expr { ErrorExpression "error-01" }
    | desimal_expr BAGI bilangan_expr { ErrorExpression "error-01" }
    | bilangan_expr MODULO desimal_expr { ErrorExpression "error-01" }
    | desimal_expr MODULO bilangan_expr { ErrorExpression "error-01" }
;

invalid_boolean_expr:
    | boolean_expr DAN desimal_expr { ErrorExpression "error-02" }
    | boolean_expr DAN bilangan_expr { ErrorExpression "error-02" }
    | desimal_expr DAN boolean_expr { ErrorExpression "error-02" }
    | bilangan_expr DAN boolean_expr { ErrorExpression "error-02" }
    | boolean_expr ATAU desimal_expr { ErrorExpression "error-02" }
    | boolean_expr ATAU bilangan_expr { ErrorExpression "error-02" }
    | desimal_expr ATAU boolean_expr { ErrorExpression "error-02" }
    | bilangan_expr ATAU boolean_expr { ErrorExpression "error-02" }
    | boolean_expr SAMA_DENGAN desimal_expr { ErrorExpression "error-02" }
    | boolean_expr SAMA_DENGAN bilangan_expr { ErrorExpression "error-02" }
    | desimal_expr SAMA_DENGAN boolean_expr { ErrorExpression "error-02" }
    | bilangan_expr SAMA_DENGAN boolean_expr { ErrorExpression "error-02" }
    | boolean_expr LEBIH_KECIL desimal_expr { ErrorExpression "error-02" }
    | boolean_expr LEBIH_KECIL bilangan_expr { ErrorExpression "error-02" }
    | desimal_expr LEBIH_KECIL boolean_expr { ErrorExpression "error-02" }
    | bilangan_expr LEBIH_KECIL boolean_expr { ErrorExpression "error-02" }
    | boolean_expr LEBIH_BESAR desimal_expr { ErrorExpression "error-02" }
    | boolean_expr LEBIH_BESAR bilangan_expr { ErrorExpression "error-02" }
    | desimal_expr LEBIH_BESAR boolean_expr { ErrorExpression "error-02" }
    | bilangan_expr LEBIH_BESAR boolean_expr { ErrorExpression "error-02" }
;