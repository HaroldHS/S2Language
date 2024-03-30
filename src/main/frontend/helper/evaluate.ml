(* required helper *)
open Exception
open Expression

(* required module *)
open Comparison

let rec evaluate_expression (e: expr) : expr = match e with
| Bilangan _ | Desimal _ | LarikKarakter _ | Bool _ -> e
| BilanganExpression (op, e1, e2) -> bilangan_arithmatic_operation op e1 e2
| DesimalExpression (op, e1, e2) -> desimal_arithmatic_operation op e1 e2
| BooleanExpression (op, e1, e2) -> boolean_operation op e1 e2
| ErrorExpression (s) -> ErrorExpression s

and bilangan_arithmatic_operation operation e1 e2 = match operation, evaluate_expression e1, evaluate_expression e2 with
  | TambahBilangan, Bilangan a, Bilangan b -> Bilangan (a + b)
  | KurangBilangan, Bilangan a, Bilangan b -> Bilangan (a - b)
  | KaliBilangan, Bilangan a, Bilangan b -> Bilangan (a * b)
  | BagiBilangan, Bilangan a, Bilangan b -> Bilangan (a / b)
  | ModuloBilangan, Bilangan a, Bilangan b -> Bilangan (a mod b)
  | _ -> call_exception "error-01"

and desimal_arithmatic_operation operation e1 e2 = match operation, evaluate_expression e1, evaluate_expression e2 with
  | TambahDesimal, Desimal a, Desimal b -> Desimal (a +. b)
  | KurangDesimal, Desimal a, Desimal b -> Desimal (a -. b)
  | KaliDesimal, Desimal a, Desimal b -> Desimal (a *. b)
  | BagiDesimal, Desimal a, Desimal b -> Desimal (a /. b)
  | _ -> call_exception "error-01"

and boolean_operation operation e1 e2 = match operation, evaluate_expression e1, evaluate_expression e2 with
  | BooleanDan, Bool a, Bool b -> Bool (a && b)
  | BooleanAtau, Bool a, Bool b -> Bool (a || b)
  | BooleanSamaDengan, Bool a, Bool b -> Bool (a = b)
  | BooleanSamaDengan, Bilangan a, Bilangan b -> Bool (a = b)
  | BooleanSamaDengan, Desimal a, Desimal b -> Bool (a = b)
  | BooleanLebihKecil, Bilangan a, Bilangan b -> Bool (int_smaller_than a b)
  | BooleanLebihKecil, Desimal a, Desimal b -> Bool (float_smaller_than a b)
  | BooleanLebihBesar, Bilangan a, Bilangan b -> Bool (int_greater_than a b)
  | BooleanLebihBesar, Desimal a, Desimal b -> Bool (float_greater_than a b)
  | _ -> call_exception "error-02"