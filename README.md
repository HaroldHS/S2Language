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
    * __bilangan__ = Integer
    * __desimal__ = Floating Point Number
    * __bool__ = Boolean Values ("benar" | "salah")
    * __larik_karakter__ = String

1. Reserved Keywords
    * "__diketahui__" = keyword to indicate a variable assignment.
    * "__tampilkan__" = keyword to print the intended value such as datatypes or variables.
    * "__variabel__" = keyword to indicate variable assignment where the next string (larik_karakter) is the variable name.
    * "__adalah__" = keyword to indicate that the next item is a value to be assigned to the variable name from "variabel".
    * "__jika__" = keyword to indicate conditional statement with the next operation (boolean condition) is the condition to be met.
    * "__maka__" = keyword to indicate that the next item is the intended operation / execution.

1. Arithmatic Operators
    * "__tambah__" = addition
    * "__kurang__" = subtraction
    * "__kali__" = multiplication
    * "__bagi__" = division
    * "__modulo__" = "modulo"

1. Boolean Operators
    * "__dan__" = and
    * "__atau__" = or
    * "__sama dengan__" = equals to
    * "__lebih kecil dari__" = smaller than
    * "__lebih besar dari__" = greater than

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
- [ ] Function Declaration
- [ ] Built-in libraries