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
%token VARIABEL
%token TAMPILKAN
%token JIKA MAKA
%token FUNGSI ADALAH

(* operations *)
%token TAMBAH KURANG KALI BAGI MODULO
%token DAN ATAU BUKAN
%token SAMA_DENGAN LEBIH_KECIL LEBIH_BESAR
%token LPAREN RPAREN MINUS

(* file token *)
%token EO_TOKEN INVALID_TOKEN

(* precedences *)
%left TAMBAH KURANG
%left KALI BAGI MODULO
%nonassoc UNIVERSAL_MINUS

%start <Expression.expr> main

%%
main:
    | be = bilangan_expr; EO_TOKEN { be }
    | de = desimal_expr; EO_TOKEN { de }
    | boe = boolean_expr; EO_TOKEN { boe }
    | iao = invalid_arithmatic_expr; EO_TOKEN { iao }
    | ibe = invalid_boolean_expr; EO_TOKEN { ibe }
    | ds = diketahui_stmn; EO_TOKEN { ds }
    | ts = tampilkan_stmn; EO_TOKEN { ts }
    | js = jika_stmn; EO_TOKEN { js }
    | ijs = invalid_jika_stmn; EO_TOKEN { ijs }
    | error EO_TOKEN { ErrorExpression "error-00" }
;

variabel_expr:
    | VARIABEL; s = LARIK_KARAKTER { Variabel (s) }

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
    (* arithmatic operations including variable *)
    | var = variabel_expr; TAMBAH; be = bilangan_expr { BilanganExpression (TambahBilangan, var, be) }
    | var = variabel_expr; KURANG; be = bilangan_expr { BilanganExpression (KurangBilangan, var, be) }
    | var = variabel_expr; KALI; be = bilangan_expr { BilanganExpression (KaliBilangan, var, be) }
    | var = variabel_expr; BAGI; be = bilangan_expr { BilanganExpression (BagiBilangan, var, be) }
    | var = variabel_expr; MODULO; be = bilangan_expr { BilanganExpression (ModuloBilangan, var, be) }
    | be = bilangan_expr; TAMBAH; var = variabel_expr { BilanganExpression (TambahBilangan, be, var) }
    | be = bilangan_expr; KURANG; var = variabel_expr { BilanganExpression (KurangBilangan, be, var) }
    | be = bilangan_expr; KALI; var = variabel_expr { BilanganExpression (KaliBilangan, be, var) }
    | be = bilangan_expr; BAGI; var = variabel_expr { BilanganExpression (BagiBilangan, be, var) }
    | be = bilangan_expr; MODULO; var = variabel_expr { BilanganExpression (ModuloBilangan, be, var) }
;

desimal_expr:
    | d = DESIMAL { Desimal d }
    | LPAREN; de = desimal_expr; RPAREN { de }
    (* arithmatic operations for floating point *)
    | de1 = desimal_expr; TAMBAH; de2 = desimal_expr { DesimalExpression (TambahDesimal, de1, de2) }
    | de1 = desimal_expr; KURANG; de2 = desimal_expr { DesimalExpression (KurangDesimal, de1, de2) }
    | de1 = desimal_expr; KALI; de2 = desimal_expr { DesimalExpression (KaliDesimal, de1, de2) }
    | de1 = desimal_expr; BAGI; de2 = desimal_expr { DesimalExpression (BagiDesimal, de1, de2) }
    (* arithmatic operations including variable *)
    | var = variabel_expr; TAMBAH; de = desimal_expr { DesimalExpression (TambahDesimal, var, de) }
    | var = variabel_expr; KURANG; de = desimal_expr { DesimalExpression (KurangDesimal, var, de) }
    | var = variabel_expr; KALI; de = desimal_expr { DesimalExpression (KaliDesimal, var, de) }
    | var = variabel_expr; BAGI; de = desimal_expr { DesimalExpression (BagiDesimal, var, de) }
    | de = desimal_expr; TAMBAH; var = variabel_expr { DesimalExpression (TambahDesimal, de, var) }
    | de = desimal_expr; KURANG; var = variabel_expr { DesimalExpression (KurangDesimal, de, var) }
    | de = desimal_expr; KALI; var = variabel_expr { DesimalExpression (KaliDesimal, de, var) }
    | de = desimal_expr; BAGI; var = variabel_expr { DesimalExpression (BagiDesimal, de, var) }
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
    (* additionaloperations including variable *)
    | var = variabel_expr; DAN; boe = boolean_expr { BooleanExpression (BooleanDan, var, boe) }
    | boe = boolean_expr; DAN; var = variabel_expr { BooleanExpression (BooleanDan, boe, var) }
    | var = variabel_expr; ATAU; boe = boolean_expr { BooleanExpression (BooleanAtau, var, boe) }
    | boe = boolean_expr; ATAU; var = variabel_expr { BooleanExpression (BooleanAtau, boe, var) }
    | boe = boolean_expr; SAMA_DENGAN; var = variabel_expr { BooleanExpression (BooleanSamaDengan, boe, var) }
    | var = variabel_expr; SAMA_DENGAN; boe = boolean_expr { BooleanExpression (BooleanSamaDengan, var, boe) }
    | be = bilangan_expr; SAMA_DENGAN; var = variabel_expr { BooleanExpression (BooleanSamaDengan, be, var) }
    | var = variabel_expr; SAMA_DENGAN; be = bilangan_expr { BooleanExpression (BooleanSamaDengan, var, be) }
    | de = bilangan_expr; SAMA_DENGAN; var = variabel_expr { BooleanExpression (BooleanSamaDengan, de, var) }
    | var = variabel_expr; SAMA_DENGAN; de = bilangan_expr { BooleanExpression (BooleanSamaDengan, var, de) }
    | boe = boolean_expr; LEBIH_KECIL; var = variabel_expr { BooleanExpression (BooleanLebihKecil, boe, var) }
    | var = variabel_expr; LEBIH_KECIL; boe = boolean_expr { BooleanExpression (BooleanLebihKecil, var, boe) }
    | be = bilangan_expr; LEBIH_KECIL; var = variabel_expr { BooleanExpression (BooleanLebihKecil, be, var) }
    | var = variabel_expr; LEBIH_KECIL; be = bilangan_expr { BooleanExpression (BooleanLebihKecil, var, be) }
    | de = bilangan_expr; LEBIH_KECIL; var = variabel_expr { BooleanExpression (BooleanLebihKecil, de, var) }
    | var = variabel_expr; LEBIH_KECIL; de = bilangan_expr { BooleanExpression (BooleanLebihKecil, var, de) }
    | boe = boolean_expr; LEBIH_BESAR; var = variabel_expr { BooleanExpression (BooleanLebihBesar, boe, var) }
    | var = variabel_expr; LEBIH_BESAR; boe = boolean_expr { BooleanExpression (BooleanLebihBesar, var, boe) }
    | be = bilangan_expr; LEBIH_BESAR; var = variabel_expr { BooleanExpression (BooleanLebihBesar, be, var) }
    | var = variabel_expr; LEBIH_BESAR; be = bilangan_expr { BooleanExpression (BooleanLebihBesar, var, be) }
    | de = bilangan_expr; LEBIH_BESAR; var = variabel_expr { BooleanExpression (BooleanLebihBesar, de, var) }
    | var = variabel_expr; LEBIH_BESAR; de = bilangan_expr { BooleanExpression (BooleanLebihBesar, var, de) }
;

diketahui_stmn:
    | DIKETAHUI; s = LARIK_KARAKTER; ADALAH; be = bilangan_expr { Diketahui (LarikKarakter (s), be) }
    | DIKETAHUI; s = LARIK_KARAKTER; ADALAH; de = desimal_expr { Diketahui (LarikKarakter (s), de) }
    | DIKETAHUI; s = LARIK_KARAKTER; ADALAH; boe = boolean_expr { Diketahui (LarikKarakter (s), boe) }
    | DIKETAHUI; s = LARIK_KARAKTER; ADALAH; ss = LARIK_KARAKTER { Diketahui (LarikKarakter (s), LarikKarakter (ss)) }
;

tampilkan_stmn:
    | TAMPILKAN; be = bilangan_expr { Tampilkan (be) }
    | TAMPILKAN; de = desimal_expr { Tampilkan (de) }
    | TAMPILKAN; boe = boolean_expr { Tampilkan (boe) }
    | TAMPILKAN; s = LARIK_KARAKTER { Tampilkan (LarikKarakter (s)) }
    | TAMPILKAN; var = variabel_expr; { Tampilkan (var) }
;

jika_stmn:
    | JIKA; boe = boolean_expr; MAKA; exec = tampilkan_stmn { Jika (boe, exec) }
;

(* invalid statements / expressions *)

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

invalid_jika_stmn:
    | JIKA bilangan_expr MAKA tampilkan_stmn { ErrorExpression "error-03" }
    | JIKA desimal_expr MAKA tampilkan_stmn { ErrorExpression "error-03" }
    | JIKA bilangan_expr MAKA bilangan_expr { ErrorExpression "error-03" }
    | JIKA bilangan_expr MAKA desimal_expr { ErrorExpression "error-03" }
    | JIKA bilangan_expr MAKA boolean_expr { ErrorExpression "error-03" }
    | JIKA desimal_expr MAKA bilangan_expr { ErrorExpression "error-03" }
    | JIKA desimal_expr MAKA desimal_expr { ErrorExpression "error-03" }
    | JIKA desimal_expr MAKA boolean_expr { ErrorExpression "error-03" }
    | JIKA boolean_expr MAKA bilangan_expr { ErrorExpression "error-04" }
    | JIKA boolean_expr MAKA desimal_expr { ErrorExpression "error-04" }
    | JIKA boolean_expr MAKA boolean_expr { ErrorExpression "error-04" }
;