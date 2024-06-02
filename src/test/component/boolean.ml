
open OUnit2
open Evaluate

let valid_bool = fun _ -> assert_equal "false" (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "benar dan (salah atau ((benar sama dengan salah) dan (1 sama dengan 1) dan (1.0 lebih kecil dari 2.0) atau (2.0 > 1.0)))\n") in 
    let final_result = evaluate_expression result in  
      match final_result with
        | Bool b -> string_of_bool b
        | _ -> "error"
)

let valid_var_bool = fun _ -> assert_equal "false" (
  let assign_var = Parser.main Lexer.parse_token (Lexing.from_string "diketahui \"test\" adalah benar\n") in 
    let var_result = evaluate_expression assign_var in
      let compare_var = Parser.main Lexer.parse_token (Lexing.from_string "variabel \"test\" dan salah\n") in
        let final_result = evaluate_expression compare_var in  
          match var_result, final_result with
            | DoNothing(), Bool b -> string_of_bool b
            | _ -> "error"
)

let invalid_bool = fun _ -> assert_equal "error-02" (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "((1 sama dengan 1) dan salah) dan (1.0 tambah (2.0 kali 3.0))\n") in 
    let final_result = evaluate_expression result in  
      match final_result with
        | ErrorExpression s -> s
        | _ -> "error"
)

let arith_with_bool_is_invalid = fun _ -> assert_equal "error-02" (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "(1.0 tambah (2.0 kali 3.0)) dan ((1 sama dengan 1) dan (12 < 15))\n") in 
    let final_result = evaluate_expression result in  
      match final_result with
      | ErrorExpression s -> s
      | _ -> "error"
)