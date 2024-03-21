(* expression type *)

type expr = 
  | ExprBilangan of int
  | ExprDesimal of float
  | ExprLarikKarakter of string
  | ExprBool of bool
  | ExprPrint of string
  (* token related *)
  | ExprToken of int
  (** error code for error handling 
  
    "error-01" = MismatchDataType

  *)
  | ExprError of string
  (* expressions for evaluation *)
  | ExprIntArithmatic of int * string * int
  | ExprFloatArithmatic of float * string * int