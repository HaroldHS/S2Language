(* implementation of entry point *)

open Printf

(* required helper *)
open Evaluate
open Exception

let main = 
  let cin = if Array.length Sys.argv > 1 then open_in Sys.argv.(1) else stdin in
    let lexbuf = Lexing.from_channel cin in
      for x=0 to 100 do
        let result = Parser.main Lexer.parse_token lexbuf in
          let final_result = evaluate_expression result in
            match final_result with
            | Bilangan i -> printf "baris %d >>  %d\n" x i
            | Desimal f -> printf "baris %d >>  %F\n" x f
            | LarikKarakter s -> printf "baris %d >> %s\n" x s
            | Bool b -> printf "baris %d >>  %B\n" x b
            | _ -> call_exception "error-00"
      done

let _ = main