
open OUnit2
open Evaluate

let diketahui_and_tampilkan_1_variable = fun _ -> assert_equal 2 (
  let first_input = Parser.main Lexer.parse_token (Lexing.from_string "diketahui \"test\" adalah 2\n") in
    let first_result = evaluate_expression first_input in
      let second_input = Parser.main Lexer.parse_token (Lexing.from_string "tampilkan variabel \"test\"\n") in 
        let final_result = evaluate_expression second_input in 
          match first_result, final_result with
          | DoNothing (), Tampilkan (Bilangan (i)) -> i
          | _ -> -99999
)

let diketahui_and_tampilkan_2_variable = fun _ -> assert_equal 3 (
  let first_input = Parser.main Lexer.parse_token (Lexing.from_string "diketahui \"test\" adalah 2\n") in
    let first_result = evaluate_expression first_input in
      let second_input = Parser.main Lexer.parse_token (Lexing.from_string "diketahui \"test1\" adalah 3\n") in 
        let second_result = evaluate_expression second_input in 
          let final_input = Parser.main Lexer.parse_token (Lexing.from_string "tampilkan variabel \"test1\"\n") in 
            let final_result = evaluate_expression final_input in 
              match first_result, second_result, final_result with
              | DoNothing (), DoNothing (), Tampilkan (Bilangan (i)) -> i
              | _ -> -99999
)
