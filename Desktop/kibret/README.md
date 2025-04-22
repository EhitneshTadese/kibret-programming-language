# Custom Interpreted Language

This is a simple interpreter for a custom scripting language built in Python. It supports basic features like variables, functions, conditionals, loops, input/output, and built-in string operations.

## 🧠 Features

- Variable declaration and assignment
- Print output to console
- Accept user input
- Function definition and execution
- Conditional (if / else) blocks
- repeat loops
- Basic built-in operations: length(), to_upper(), to_lower(), reverse

## 📜 Example Syntax

plaintext
decl name = "Alice";
decl age = 25;
print name;
print to_upper(name);
print length(name);

funct greet(person) {
    print "Hello, " + person;
}

greet("Bob");

if age > 18 {
    print "Adult";
} else {
    print "Minor";
}

repeat 3 {
    print "Looping!";
}


## 🚀 Running the Interpreter

Ensure you have Python 3.11 installed.

bash
python interpreter.py programs/helloworld.txt


Your script file should end with .txt and follow the syntax rules.

## 📂 Project Structure


.
├── interpreter.py
├── programs/
│   ├── helloworld.txt
│   └── int.txt
└── README.md


## ⚙ Built-in Functions

| Custom Name    | Python Equivalent          | Example                      |
|----------------|----------------------------|------------------------------|
| length(x)    | len(x)                   | length("hello") → 5        |
| to_upper(x)  | str(x).upper()           | to_upper("hello") → HELLO  |
| to_lower(x)  | str(x).lower()           | to_lower("HELLO") → hello  |
| reverse "x"  | "x"[::-1]                | reverse "hello" → olleh    |

## 📥 Input

plaintext
input user_name = "What is your name?";
print user_name;


## 🧪 Function Calls

plaintext
funct add(x, y) {
    print x + y;
}

add(5, 7);


## 📌 Notes

- All statements should end with a semicolon (;), except block declarations ({) and closing braces (}).
- Whitespace is trimmed automatically.
- Comments and empty lines are ignored.

---

Feel free to extend this interpreter with more features like file I/O, data types, or user-defined classes!