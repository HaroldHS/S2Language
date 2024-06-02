(* comparison functions *)

let int_smaller_than = fun (x: int) -> fun (y: int) -> x < y
let int_greater_than = fun (x: int) -> fun (y: int) -> x > y

let float_smaller_than = fun (x: float) -> fun (y: float) -> x < y
let float_greater_than = fun (x: float) -> fun (y: float) -> x > y