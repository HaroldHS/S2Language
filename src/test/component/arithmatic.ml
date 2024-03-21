
open OUnit2

let valid_int_arith = fun _ -> assert_equal 2 (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "1 tambah (3 kurang (1 kali (2 bagi (3 modulo 2))))\n") in 
    match result with
    | ExprBilangan i -> i
    | _ -> -99999
)

let valid_float_arith = fun _ -> assert_equal 2.5 (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "1.0 tambah (3.0 kurang (1.0 kali (3.0 bagi 2.0)))\n") in 
    match result with
    | ExprDesimal d -> d
    | _ -> -99999.
)

let invalid_int_arith = fun _ -> assert_equal "error-01" (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "1 tambah (3.0 kurang 2.0)\n") in
    match result with
    | ExprError e -> e
    | _ -> "valid"
)

let invalid_float_arith = fun _ -> assert_equal "error-01" (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "1.0 tambah (3 kurang 2)\n") in
    match result with
    | ExprError e -> e
    | _ -> "valid"
)