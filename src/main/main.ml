(* implementation of entry point *)

open Printf

(* required helper *)
open Evaluate
open Exception

let main = 
  let cin = if Array.length Sys.argv > 1 then open_in Sys.argv.(1) else stdin in
    let lexbuf = Lexing.from_channel cin in
      for x=1 to 101 do
        let result = Parser.main Lexer.parse_token lexbuf in
          let final_result = evaluate_expression result in
            match final_result with
            | Bilangan i -> printf "[baris %d] %d\n" x i
            | Desimal f -> printf "[baris %d] %F\n" x f
            | LarikKarakter s -> printf "[baris %d] %s\n" x s
            | Bool b -> printf "[baris %d] %B\n" x b
            (* print statements *)
            | Tampilkan (Bilangan (b)) -> printf "%d\n" b
            | Tampilkan (Desimal (d)) -> printf "%F\n" d
            | Tampilkan (Bool (bo)) -> printf "%B\n" bo
            | Tampilkan (LarikKarakter (s)) -> printf "%s\n" s
            | ErrorExpression s -> call_exception s
            | _ -> call_exception "error-00"
      done

let _ = main