
open OUnit2

let valid_bool = fun _ -> assert_equal "true" (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "benar dan (salah atau (bukan (benar sama dengan salah) dan (1 sama dengan 1) dan (1.0 lebih kecil dari 2.0) atau (2.0 > 1.0)))\n") in 
    match result with
    | ExprBool b -> string_of_bool b
    | _ -> "error"
)

let invalid_bool = fun _ -> assert_equal "error-02" (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "((1 sama dengan 1) dan salah) dan (1.0 tambah (2.0 kali 3.0))\n") in 
    match result with
    | ExprError e -> e
    | _ -> "error"
)

let arith_with_bool_is_invalid = fun _ -> assert_equal "error-02" (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "(1.0 tambah (2.0 kali 3.0)) dan ((1 sama dengan 1) dan (12 < 15))\n") in 
    match result with
    | ExprError e -> e
    | _ -> "error"
)