(* available exceptions *)
exception InvalidSyntax of string
exception MismatchDataType of string
exception InvalidExceptionCode of string

let call_exception (code: string) = 
  if String.equal code "error-00" then raise (InvalidSyntax "sintaks error")
  else if String.equal code "error-01" then raise (MismatchDataType "tipe data harus sama")
  else raise (InvalidExceptionCode "error tidak bise dideteksi")