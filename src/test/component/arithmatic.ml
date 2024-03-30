
open OUnit2
open Evaluate

let valid_int_arith = fun _ -> assert_equal 2 (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "1 tambah (3 kurang (1 kali (2 bagi (3 modulo 2))))\n") in
    let final_result = evaluate_expression result in 
      match final_result with
      | Bilangan i -> i
      | _ -> -99999
)

let valid_float_arith = fun _ -> assert_equal 2.5 (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "1.0 tambah (3.0 kurang (1.0 kali (3.0 bagi 2.0)))\n") in 
    let final_result = evaluate_expression result in
      match final_result with
      | Desimal d -> d
      | _ -> -99999.
)

let invalid_int_arith = fun _ -> assert_equal "error-01" (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "1 tambah (3.0 kurang 2.0)\n") in 
    let final_result = evaluate_expression result in
      match final_result with
      | ErrorExpression s -> s
      | _ -> "valid"
)

let invalid_float_arith = fun _ -> assert_equal "error-01" (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "1.0 tambah (3 kurang 2)\n") in
    let final_result = evaluate_expression result in
      match final_result with
      | ErrorExpression s -> s
      | _ -> "valid"
)