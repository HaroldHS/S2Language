
open Exception

let eval_int_arithmatic = fun (x: int) -> fun (y: string) -> fun (z: int) -> match y with
| "tambah" -> x + z
| "kurang" -> x - z
| "kali" -> x * z
| "bagi" -> x / z
| "modulo" -> x mod z
| _ -> call_exception "error-00"

let eval_float_arithmatic = fun (x: float) -> fun (y: string) -> fun (z: float) -> match y with
| "tambah" -> x +. z
| "kurang" -> x -. z
| "kali" -> x *. z
| "bagi" -> x /. z
| _ -> call_exception "error-00"