(**

  Virtual variable container.

  Variables created by 'diketahui' statement are stored in an array (called container) with predefined type (called virtual variable).
  Each virtual variable has 4 properties that could be used to store values.
  Array / container has a fixed size which is 25.

**)

open Exception
open Expression

(* exception to break loop / iteration *)
exception Break

type virtual_variable_type = {
  mutable name: string;         (* variable name *)
  mutable int_value: int;       (* Bilangan *)
  mutable float_value: float;   (* Desimal *)
  mutable bool_value: bool;     (* Bool *)
  mutable string_value: string; (* LarikKarakter *)
}

(* type for saving loop index *)
type virtual_variable_index_type = {
  mutable index: int;
}

let virtual_variable_index = {index = 0}

let virtual_variable_container = Array.init 25 (fun _ -> {
  name = "init"; 
  int_value = 0; 
  float_value = 0.0; 
  bool_value = false; 
  string_value = "";
})

(* function for obtaining variable values *)

let rec find_virtual_variable = fun (var_name: string) -> begin
  get_virtual_variable_index var_name;
  get_virtual_variable var_name;
end

and get_virtual_variable = fun (var_name: string) -> 
  let var_value = get_virtual_variable_value var_name virtual_variable_index.index in
    match var_value with
    | Bilangan b -> Bilangan b
    | Desimal d -> Desimal d
    | Bool bo -> Bool bo
    | LarikKarakter s -> LarikKarakter s
    | _ -> call_exception "error-07"

and get_virtual_variable_value = fun (var_name: string) -> fun (i: int) -> 
  if virtual_variable_container.(i).name = var_name && virtual_variable_container.(i).int_value <> 0 && virtual_variable_container.(i).float_value = 0.0 && virtual_variable_container.(i).bool_value = false && virtual_variable_container.(i).string_value = "" then
    Bilangan (virtual_variable_container.(i).int_value)
  else if virtual_variable_container.(i).name = var_name && virtual_variable_container.(i).int_value = 0 && virtual_variable_container.(i).float_value <> 0.0 && virtual_variable_container.(i).bool_value = false && virtual_variable_container.(i).string_value = "" then
    Desimal (virtual_variable_container.(i).float_value)
  else if virtual_variable_container.(i).name = var_name && virtual_variable_container.(i).int_value = 0 && virtual_variable_container.(i).float_value = 0.0 && virtual_variable_container.(i).bool_value = false && virtual_variable_container.(i).string_value <> "" then
    LarikKarakter (virtual_variable_container.(i).string_value)
  else if virtual_variable_container.(i).name = var_name && virtual_variable_container.(i).int_value = 0 && virtual_variable_container.(i).float_value = 0.0 && virtual_variable_container.(i).string_value = "" then
    Bool (virtual_variable_container.(i).bool_value)
  else
    call_exception "error-07"

and get_virtual_variable_index = fun (var_name: string) ->
  for i=0 to 24 do
    if virtual_variable_container.(i).name = var_name then 
      virtual_variable_index.index <- i
    else
      ()
  done

(* functions for variable assignment *)

let rec assign_virtual_variable (var_name: string) (var_value: expr) = match var_value with
  | Bilangan b -> iterate_container var_name b 0.0 false ""
  | Desimal d -> iterate_container var_name 0 d false ""
  | Bool bo -> iterate_container var_name 0 0.0 bo ""
  | LarikKarakter ss -> iterate_container var_name 0 0.0 false ss
  | _ -> call_exception "error-06"

and iterate_container = 
  fun (var_name: string) -> 
    fun (int_value: int) -> 
      fun (float_value: float) -> 
        fun (bool_value: bool) -> 
          fun (string_value: string) -> 
            try
              for i=0 to 24 do
                if virtual_variable_container.(i).name = "init" then 
                  update_value i var_name int_value float_value bool_value string_value
                else if i < 24 && virtual_variable_container.(i).name <> "init" then
                  () (* do nothing / continue *)
                else if i = 24 && virtual_variable_container.(i).name <> "init" then 
                  call_exception "error-05"
                else
                  call_exception "error"
              done
            with Break -> ()

and update_value = fun (index: int) ->
  fun (name: string) -> 
    fun (bilangan: int) -> 
      fun (desimal: float) -> 
        fun (boolean: bool) -> 
          fun (larik_karakter: string) -> begin
            virtual_variable_container.(index).name <- name;
            virtual_variable_container.(index).int_value <- bilangan;
            virtual_variable_container.(index).float_value <- desimal;
            virtual_variable_container.(index).bool_value <- boolean;
            virtual_variable_container.(index).string_value <- larik_karakter;
            raise Break (* stop iteration *)
          end