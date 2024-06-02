# S2Language
S2Language (Small and Simple Language) is a program that interprets custom language written in Bahasa.

### How to run / perform test
```bash
# 1. Build the project
dune build main.exe

# 2.a Perform test
dune test

# 2.b Run the project (interpreter mode)
dune exec ./main.exe

# 2.c Execute a .s2l file
dune exec ./main.exe (path of .s2l file)

# 3. Clean the project (optional)
dune clean
```

### Available commands
```text
1. (bilangan | desimal) [arithmatic operations] (bilangan | desimal)

2. (bilangan | desimal | bool) [boolean operations] (bilangan | desimal | bool)

3. diketahui (larik_karakter) adalah (bilangan | desimal | bool | larik_karakter)

4. tampilkan (bilangan | desimal | bool | larik_karakter | variabel larik_karakter)

5. jika (boolean condition) maka (tampilkan statement / 4th statement)
```

1. Datatypes
    * bilangan = Integer
    * desimal = Floating Point Number
    * bool = Boolean Values ("benar" | "salah")
    * larik_karakter = String
1. Reserved Keywords
    * "diketahui" = keyword to indicate a variable assignment.
    * "tampilkan" = keyword to print the intended value such as datatypes or variables.
    * "variabel" = keyword to indicate variable assignment where the next string (larik_karakter) is the variable name.
    * "adalah" = keyword to indicate that the next item is a value to be assigned to the variable name from "variabel".
    * "jika" = keyword to indicate conditional statement with the next operation (boolean condition) is the condition to be met.
    * "maka" = keyword to indicate that the next item is the intended operation / execution.
1. Arithmatic Operators
    * "tambah" = addition
    * "kurang" = subtraction
    * "kali" = multiplication
    * "bagi" = division
    * "modulo" = "modulo"
1. Boolean Operators
    * "dan" = and
    * "atau" = or
    * "sama dengan" = equals to
    * "lebih kecil dari" = smaller than
    * "lebih besar dari" = greater than

### Example
```text
[ INPUT ]
diketahui "kecepatan" adalah 10
diketahui "kecepatan baru" adalah variabel "kecepatan" tambah 10
jika variabel "kecepatan baru" sama dengan 20 maka tampilkan "program berjalan dengan baik"

[ OUTPUT ]
program berjalan dengan baik
```

### Features

- [x] Dynamic Variables
- [x] Variable Assignment
- [x] Conditional Statement
- [x] Print Statement
- [] Function Declaration
- [] Built-in libraries