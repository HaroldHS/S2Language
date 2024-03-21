%{
    (* required helper *)
    open Expression

    (* required modules *)
    open Comparison
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
(* expressions for list of operations, for error handling *)
arith_ops:
    TAMBAH { "tambah" }
    | KURANG { "kurang" }
    | KALI { "kali" }
    | BAGI { "bagi" }
    | MODULO { "modulo" }
;
;

bool_ops:
    DAN { $1 }
    | ATAU { $1 }
    | BUKAN { $1 }
    | SAMA_DENGAN { $1 }
    | LEBIH_KECIL { $1 }
    | LEBIH_BESAR { $1 }
;
(* - end - *)


main:
    bilangan_expr EOL { ExprBilangan $1 }
    | desimal_expr EOL { ExprDesimal $1 }
    | boolean_expr EOL { ExprBool $1 }
    | invalid_arithmatic_expr EOL { ExprError $1}
    | invalid_boolean_expr EOL { ExprError $1 }
    | EOF_TOKEN { ExprToken 0 }
    | INVALID_TOKEN { ExprError "error-00" }
    | error EOL { ExprError "error-00" } (* syntax error *)
;

bilangan_expr: 
    BILANGAN { $1 }
    (* parantheses *)
    | LPAREN bilangan_expr RPAREN { $2 }
    (* arithmatic operations for integer *)
    | bilangan_expr TAMBAH bilangan_expr { $1 + $3 }
    | bilangan_expr KURANG bilangan_expr { $1 - $3 }
    | bilangan_expr KALI bilangan_expr { $1 * $3 }
    | bilangan_expr BAGI bilangan_expr { $1 / $3 }
    | bilangan_expr MODULO bilangan_expr { $1 mod $3 }
    | MINUS bilangan_expr %prec UNIVERSAL_MINUS { - $2 }
;

desimal_expr:
    DESIMAL { $1 }
    | LPAREN desimal_expr RPAREN { $2 }
    (* arithmatic operations for floating point *)
    | desimal_expr TAMBAH desimal_expr { $1 +. $3 }
    | desimal_expr KURANG desimal_expr { $1 -. $3 }
    | desimal_expr KALI desimal_expr { $1 *. $3 }
    | desimal_expr BAGI desimal_expr { $1 /. $3 }
;

boolean_expr:
    BENAR { $1 }
    | SALAH { $1 }
    | LPAREN boolean_expr RPAREN { $2 }
    (* boolean operators *)
    | boolean_expr DAN boolean_expr { $1 && $3 }
    | boolean_expr ATAU boolean_expr { $1 || $3 }
    | BUKAN boolean_expr { not $2 }
    (* additional operations that boolean support *)
    | boolean_expr SAMA_DENGAN boolean_expr { $1 = $3 }
    | bilangan_expr SAMA_DENGAN bilangan_expr { $1 = $3 }
    | desimal_expr SAMA_DENGAN desimal_expr { $1 = $3 }
    | bilangan_expr LEBIH_KECIL bilangan_expr { int_smaller_than $1 $3}
    | desimal_expr LEBIH_KECIL desimal_expr { float_smaller_than $1 $3 }
    | bilangan_expr LEBIH_BESAR bilangan_expr { int_greater_than $1 $3}
    | desimal_expr LEBIH_BESAR desimal_expr { float_greater_than $1 $3 }
;

invalid_arithmatic_expr:
    bilangan_expr TAMBAH desimal_expr { "error-01" }
    | bilangan_expr KURANG desimal_expr { "error-01" }
    | bilangan_expr KALI desimal_expr { "error-01" }
    | bilangan_expr BAGI desimal_expr { "error-01" }
    | bilangan_expr MODULO desimal_expr { "error-01" }
    | desimal_expr TAMBAH bilangan_expr { "error-01" }
    | desimal_expr KURANG bilangan_expr { "error-01" }
    | desimal_expr KALI bilangan_expr { "error-01" }
    | desimal_expr BAGI bilangan_expr { "error-01" }
    | desimal_expr MODULO bilangan_expr { "error-01" }
    (* additional cases *)
    | bilangan_expr arith_ops boolean_expr { "error-02" }
    | desimal_expr arith_ops boolean_expr { "error-02" }
    | boolean_expr arith_ops bilangan_expr { "error-02" }
    | boolean_expr arith_ops desimal_expr { "error-02" }
;

invalid_boolean_expr:
    (* edge cases *)
    boolean_expr DAN bilangan_expr { "error-02" }
    | boolean_expr ATAU bilangan_expr { "error-02" }
    | boolean_expr SAMA_DENGAN bilangan_expr { "error-02" }
    | boolean_expr DAN desimal_expr { "error-02" }
    | boolean_expr ATAU desimal_expr { "error-02" }
    | boolean_expr SAMA_DENGAN desimal_expr { "error-02" }
    (* - end - *)
    | boolean_expr bool_ops bilangan_expr { "error-02" }
    | boolean_expr bool_ops desimal_expr { "error-02" }
    | bilangan_expr bool_ops boolean_expr { "error-02" }
    | desimal_expr bool_ops boolean_expr { "error-02" }
    | bilangan_expr bool_ops bilangan_expr { "error-02" }
    | desimal_expr bool_ops desimal_expr { "error-02" }
;