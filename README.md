# S2Language
S2Language (Small and Simple Language) is a program that interprets custom language written in Bahasa.

### How to run / perform test

```bash
# Build the project
dune build main.exe

# Perform test
dune test

# Run the project (interpreter mode)
dune exec ./main.exe

# Execute a .s2l file
dune exec ./main.exe \(path of .s2l file\)

# Clean the project
dune clean
```