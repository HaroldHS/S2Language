(* expression type *)

type arithmatic_bilangan = 
  | TambahBilangan
  | KurangBilangan
  | KaliBilangan
  | BagiBilangan
  | ModuloBilangan

type arithmatic_desimal = 
  | TambahDesimal
  | KurangDesimal
  | KaliDesimal
  | BagiDesimal

type boolean = 
  | BooleanDan
  | BooleanAtau
  | BooleanSamaDengan
  | BooleanLebihKecil
  | BooleanLebihBesar

type expr = 
  (* datatypes *)
  | Bilangan of int
  | Desimal of float
  | LarikKarakter of string
  | Bool of bool
  (* arithmatic operations *)
  | BilanganExpression of arithmatic_bilangan * expr * expr
  | DesimalExpression of  arithmatic_desimal * expr * expr
  (* boolean operations *)
  | BooleanExpression of boolean * expr * expr
  (* other operations *)
  | Tampilkan of expr
  (* | Diberikan of string * expr * expr *)
  | Jika of expr * expr
  (* | Fungsi of string * string * expr *)
  (* token related *)
  (* | Token of int *)
  (**
  
    error code for error handling 
  
    "error-00" = InvalidSyntax
    "error-01" = ArithmaticOperationError
    "error-02" = BooleanOperationError
    "error-03" = IfOperationError
    "error-04" = IfExecutionError

  **)
  | ErrorExpression of string