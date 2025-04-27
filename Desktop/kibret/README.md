# Custom Interpreted Language — Kibret

This is a simple programming language called **Kibret**, implemented both as an **interpreter in Python** and a **transpiler to C (using Bison/Flex)**. The language supports common features like variables, functions, conditionals, loops, input/output, and basic string operations.

---

## 🧠 Supported Features

| Category            | Name               | Description                            | Example                                | Supported In         |
|---------------------|--------------------|----------------------------------------|----------------------------------------|----------------------|
| **Keyword**         | `print`             | Output value or string                 | `print "Hello";`<br>`print 5 + 3;`     | Interpreter, Transpiler |
| **Keyword**         | `decl`              | Declare variable                      | `decl age = 25;`                       | Interpreter Only     |
| **Keyword**         | `input`             | Get input from user                    | `input name = "Enter name:";`           | Interpreter Only     |
| **Keyword**         | `funct`             | Define function                       | `funct greet(person) { print person; }` | Interpreter Only     |
| **Keyword**         | `if / else`         | Conditional blocks                    | `if age > 18 { print "Adult"; }`        | Interpreter Only     |
| **Keyword**         | `repeat`            | Repeat block multiple times           | `repeat 3 { print "Hi"; }`              | Interpreter Only     |
| **Operator**        | `+`                 | Add or concatenate                    | `print 2 + 3;`<br>`print "A" + "B";`    | Interpreter, Transpiler |
| **Symbol**          | `;`                 | Statement terminator                  | `print "Done";`                        | Interpreter, Transpiler |
| **Type**            | `STRING`            | Text between quotes                   | `"Hello World"`                        | Interpreter, Transpiler |
| **Type**            | `NUMBER`            | Integer numbers                       | `25`, `-10`, `100`                     | Interpreter, Transpiler |
| **Variable**        | `IDENTIFIER`        | Variable names                        | `name`, `age`, `counter`               | Interpreter Only     |
| **Built-in Func**   | `length(x)`          | String length                         | `print length("hello"); // 5`          | Interpreter Only     |
| **Built-in Func**   | `to_upper(x)`        | String to uppercase                   | `print to_upper("hello"); // HELLO`    | Interpreter Only     |
| **Built-in Func**   | `to_lower(x)`        | String to lowercase                   | `print to_lower("HELLO"); // hello`    | Interpreter Only     |
| **Built-in Func**   | `reverse "x"`        | Reverse a string                      | `print reverse "hello"; // olleh`      | Interpreter Only     |
| **Transpiler**      | `Kibret -> C`        | Converts Kibret code to C source       | `print "Hello, World from Kibret!";`    | Transpiler Only      |
---

## 📜 Example Syntax

```plaintext
# Declare a variable with a string value
decl name = "Melat";

# Declare a variable with a number
decl age = 25;

# Print the value of the variable 'name'
print name;

# Define a function named 'greet' that takes one argument
funct greet(person) {
    # Print a greeting message using string concatenation
    print "Hello, " + person;
}

# Call the 'greet' function with the argument "Hanna"
greet("Hanna");

# Conditional block: check if age is greater than 18
if age > 18 {
    print "Adult";        # This will print if condition is true
} else {
    print "Minor";        # This will print if condition is false
}

# Repeat block: runs the inner block 3 times
repeat 3 {
    print "Looping!";     # Prints "Looping!" three times
}


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

| Custom Name   | Python Equivalent | Example                     |
| ------------- | ----------------- | --------------------------- |
| `length(x)`   | `len(x)`          | `length("hello") → 5`       |
| `to_upper(x)` | `str(x).upper()`  | `to_upper("hello") → HELLO` |
| `to_lower(x)` | `str(x).lower()`  | `to_lower("HELLO") → hello` |
| `reverse "x"` | `"x"[::-1]`       | `reverse "hello" → olleh`   |

---

## 🔁 Transpiler (Kibret to C)

The Kibret Transpiler is written using **Bison** and **Flex**. It converts Kibret source code into equivalent **C code**, which can be compiled and run like any native C program.

### 📄 Example Kibret Code

```plaintext
print "Hello, World from Kibret!";
print 5 + 7;
```

### Manual Compiling or Build Step Using MYSYS2 MINGW64

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
