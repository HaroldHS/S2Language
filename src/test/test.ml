
open OUnit2

(* all available test cases *)
open Arithmatic

let all_test_cases = "perform all built-in test cases" >::: [
  "valid integer arithmatic operation" >:: (valid_int_arith);
  "valid float arithmatic operation" >:: (valid_float_arith);
  "invalid int arithmatic operation" >:: (invalid_int_arith);
  "invalid float arithmatic operation" >:: (invalid_float_arith);
]

let _ = run_test_tt_main all_test_cases