(* available exceptions *)
exception InvalidSyntax of string
exception ArithmaticOperationError of string
exception BooleanOperationError of string
exception IfOperationError of string
exception IfExecutionError of string
exception VirtualContainerFullError of string
exception UnsupportedDataTypeForVariableError of string
exception VariableIsNotDefinedError of string
exception InvalidExceptionCode of string

let call_exception (code: string) = 
  if String.equal code "error-00" then raise (InvalidSyntax "sintaks error")
  else if String.equal code "error-01" then raise (ArithmaticOperationError "Operator / tipe data dari operasi aritmatik harus sama")
  else if String.equal code "error-02" then raise (BooleanOperationError "Operator / tipe data dari operasi boolean harus sama")
  else if String.equal code "error-03" then raise (IfOperationError "Kondisi pada perintah 'jika' harus ekspresi boolean dan bernilai benar")
  else if String.equal code "error-04" then raise (IfOperationError "Perintah yang dijalankan pada perintah 'jika' haruslah tampilkan")
  else if String.equal code "error-05" then raise (VirtualContainerFullError "Penyimpanan variabel telah penuh")
  else if String.equal code "error-06" then raise (UnsupportedDataTypeForVariableError "Nilai / data yang diberikan pada perintah 'diketahui' tidak valid")
  else if String.equal code "error-07" then raise (VariableIsNotDefinedError "Varibel tidak dapat ditemukan")
  else raise (InvalidExceptionCode "error tidak bise dideteksi")