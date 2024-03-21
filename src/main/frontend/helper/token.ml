(* token for analysis / frontend *)

type token = 
  (* datatypes *)
  | BILANGAN of int
  | DESIMAL of float
  | LARIK_KARAKTER of string
  | BENAR of bool
  | SALAH of bool
  (* symbols *)
  | LPAREN
  | RPAREN
  | MINUS
  (* reserved keyword *)
  | DIKETAHUI
  | TAMPILKAN
  | JIKA
  | MAKA
  | FUNGSI
  | ADALAH
  (* operations *)
  | TAMBAH
  | KURANG
  | KALI
  | BAGI
  | MODULO
  | DAN
  | ATAU
  | BUKAN
  | SAMA_DENGAN
  | LEBIH_KECIL
  | LEBIH_BESAR
  (* file token *)
  | EOL
  | EOF_TOKEN
  | INVALID_TOKEN