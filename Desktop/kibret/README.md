# Custom Interpreted Language — Kibret

This is a simple programming language called **Kibret**, implemented both as an **interpreter in Python** and a **transpiler to C (using Bison/Flex)**. The language supports common features like variables, functions, conditionals, loops, input/output, and basic string operations.

---

## 🧠 Features

- Variable declaration and assignment
- Print output to console
- Accept user input
- Function definition and execution
- Conditional (`if` / `else`) blocks
- `repeat` loops
- Built-in functions: `length()`, `to_upper()`, `to_lower()`, `reverse`
- Transpilation to C for performance and portability

---

## 📜 Example Syntax

```plaintext
decl name = "Melat";
decl age = 25;
print name;
print to_upper(name);
print length(name);

funct greet(person) {
    print "Hello, " + person;
}

greet("Hanna");

if age > 18 {
    print "Adult";
} else {
    print "Minor";
}

repeat 3 {
    print "Looping!";
}
```

---

## 🚀 Interpreter

Ensure you have Python 3.11+ installed.

### ▶️ Run the Interpreter

```bash
py interpreter.py programs/helloworld.txt (Windows)
```

Your script file should end with `.txt` and follow the Kibret syntax rules.

### 📂 Project Structure

```
.
├── interpreter.py
├── programs/
│   ├── helloworld.txt
│   └── multiply.txt
└── README.md
```

### ⚙ Built-in Functions

| Custom Name    | Python Equivalent      | Example                      |
|----------------|------------------------|------------------------------|
| `length(x)`    | `len(x)`               | `length("hello") → 5`        |
| `to_upper(x)`  | `str(x).upper()`       | `to_upper("hello") → HELLO`  |
| `to_lower(x)`  | `str(x).lower()`       | `to_lower("HELLO") → hello`  |
| `reverse "x"`  | `"x"[::-1]`            | `reverse "hello" → olleh`    |

---

## 🔁 Transpiler (Kibret to C)

The Kibret Transpiler is written using **Bison** and **Flex**. It converts Kibret source code into equivalent **C code**, which can be compiled and run like any native C program.

### 📄 Example Kibret Code

```plaintext
print "Hello, World from Kibret!";
print 5 + 7;
```

### Manual Compiling or Build Step Using  MYSYS2 MINGW64

flex kibret_lexer.l
bison -d kibret_parser.y

gcc -mconsole kibret_parser.tab.c lex.yy.c -o kibret_transpiler.exe

### ⚙️ Transpiling

```bash
make
./kibret_transpiler <  helloworld.txt > hello.c
```

Then compile the generated C code:

```bash
gcc hello.c -o hello
./hello
```

### 📂 Transpiler Folder Structure

```
transpiler/
├── kibret_parser.y         # Bison grammar
├── kibret_lexer.l          # Flex lexer
├── kibret_transpiler       # Output binary (after manual building or compiling)
├── kibret_transpiler       # Output binary (after make)


    
```

---

## 📥 Input Example

```plaintext
input user_name = "What is your name?";
print user_name;
```

---

## 🧪 Function Calls

```plaintext
funct add(x, y) {
    print x + y;
}

add(5, 7);
```

---

## 📌 Notes

- All statements must end with a semicolon (`;`)
- Blocks use curly braces (`{}`) with no semicolons after them
- Whitespace is trimmed automatically
- Empty lines and comments are ignored

---

Feel free to extend this language with more features like file I/O, custom data types, or even class support.