
open OUnit2
open Evaluate

let tampilkan_valid_int_arith = fun _ -> assert_equal 2 (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "tampilkan 1 tambah (3 kurang (1 kali (2 bagi (3 modulo 2))))\n") in
    let final_result = evaluate_expression result in 
      match final_result with
      | Tampilkan (Bilangan (i)) -> i
      | _ -> -99999
)

let tampilkan_valid_float_arith = fun _ -> assert_equal 2.5 (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "tampilkan 1.0 tambah (3.0 kurang (1.0 kali (3.0 bagi 2.0)))\n") in 
    let final_result = evaluate_expression result in
      match final_result with
      | Tampilkan (Desimal (d)) -> d
      | _ -> -99999.
)

let tampilkan_valid_bool = fun _ -> assert_equal "false" (
  let result = Parser.main Lexer.parse_token (Lexing.from_string "tampilkan benar dan (salah atau ((benar sama dengan salah) dan (1 sama dengan 1) dan (1.0 lebih kecil dari 2.0) atau (2.0 > 1.0)))\n") in 
    let final_result = evaluate_expression result in  
      match final_result with
        | Tampilkan (Bool (b)) -> string_of_bool b
        | _ -> "error"
)