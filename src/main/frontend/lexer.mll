{
    open Parser
}

rule parse_token = parse
    [' ' '\t'] { parse_token lexbuf }
    | '(' { LPAREN }
    | ')' { RPAREN }
    | '-' { MINUS }
    | "diketahui" { DIKETAHUI }
    | "tampilkan" { TAMPILKAN }
    | "jika" { JIKA }
    | "maka" { MAKA }
    | "fungsi" { FUNGSI }
    | "adalah" { ADALAH }
    | "tambah" { TAMBAH }
    | "kurang" { KURANG }
    | "kali" { KALI }
    | "bagi" { BAGI }
    | "modulo" { MODULO }
    | "dan" { DAN }
    | "atau" { ATAU }
    | "bukan" { BUKAN }
    | "sama dengan" { SAMA_DENGAN }
    | "lebih kecil dari" { LEBIH_KECIL }
    | '<' { LEBIH_KECIL }
    | "lebih besar dari" { LEBIH_BESAR }
    | '>' { LEBIH_BESAR }
    | "benar" { BENAR true }
    | "salah" { SALAH false}
    | ('-')?['0'-'9']+ as int_num { BILANGAN (int_of_string int_num) }
    | ('-')?['0'-'9']+('.')['0'-'9']+ as float_num { DESIMAL (float_of_string float_num) }
    | ['a'-'z']+ as str { LARIK_KARAKTER str }
    | '\n' { EO_TOKEN }
    | eof { EO_TOKEN }
    | _ { INVALID_TOKEN }