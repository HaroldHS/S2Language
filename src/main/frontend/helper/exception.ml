(* available exceptions *)
exception InvalidSyntax of string
exception ArithmaticOperationError of string
exception BooleanOperationError of string
exception InvalidExceptionCode of string

let call_exception (code: string) = 
  if String.equal code "error-00" then raise (InvalidSyntax "sintaks error")
  else if String.equal code "error-01" then raise (ArithmaticOperationError "Operator / tipe data dari operasi aritmatik harus sama")
  else if String.equal code "error-02" then raise (BooleanOperationError "Operator / tipe data dari operasi boolean harus sama")
  else raise (InvalidExceptionCode "error tidak bise dideteksi")