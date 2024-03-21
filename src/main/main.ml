(* implementation of entry point *)

open Printf
open Exception

let main = 
  let cin = if Array.length Sys.argv > 1 then open_in Sys.argv.(1) else stdin in
    let lexbuf = Lexing.from_channel cin in
      for x=0 to 100 do
        let result = Parser.main Lexer.parse_token lexbuf in
          match result with
          | ExprBilangan i -> printf "baris %d >>  %d\n" x i
          | ExprDesimal f -> printf "baris %d >> %F\n" x f
          | ExprBool b -> printf "baris %d >> %B\n" x b
          | ExprLarikKarakter s -> printf "baris %d >> %s\n" x s
          | ExprToken t -> exit t
          | ExprError e -> call_exception e
          | _ -> call_exception "error-00"
      done

let _ = main