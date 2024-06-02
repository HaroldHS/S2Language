
open OUnit2
open Evaluate

let valid_jika_execute_tampilkan = fun _ -> assert_equal 2 (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "jika 1 sama dengan 1 maka tampilkan 2\n") in
    let final_result = evaluate_expression result in 
      match final_result with
      | Tampilkan (Bilangan (i)) -> i
      | _ -> -99999
)

let jika_bilangan_condition_invalid = fun _ -> assert_equal "error-03" (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "jika 1 maka tampilkan 1\n") in 
    let final_result = evaluate_expression result in  
      match final_result with
      | ErrorExpression s -> s
      | _ -> "error"
)

let jika_execute_bilangan_invalid = fun _ -> assert_equal "error-04" (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "jika 1 sama dengan 1 maka 1\n") in 
    let final_result = evaluate_expression result in  
      match final_result with
      | ErrorExpression s -> s
      | _ -> "error"
)