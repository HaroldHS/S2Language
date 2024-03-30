
open OUnit2

(* all available test cases *)
open Arithmatic
open Boolean
open Tampilkan

let all_test_cases = "perform all built-in test cases" >::: [
  "valid integer arithmatic operation" >:: (valid_int_arith);
  "valid float arithmatic operation" >:: (valid_float_arith);
  "invalid int arithmatic operation" >:: (invalid_int_arith);
  "invalid float arithmatic operation" >:: (invalid_float_arith);
  "valid boolean operation" >:: (valid_bool);
  "invalid boolean operation" >:: (invalid_bool);
  "test arithmatic with boolean operation" >:: (arith_with_bool_is_invalid);
  "print valid integer arithmatic operation" >:: (tampilkan_valid_int_arith);
  "print valid float arithmatic operation" >:: (tampilkan_valid_float_arith);
  "print valid boolean operation" >:: (tampilkan_valid_bool);
]

let _ = run_test_tt_main all_test_cases