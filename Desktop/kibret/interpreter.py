import re

# Global dictionaries to hold variables and functions
variables = {}
functions = {}

# Function to evaluate expressions (e.g. arithmetic, function calls, etc.)
def evaluate(expr):
    expr = expr.strip()  # Remove leading/trailing whitespace

    # Replace variable names in the expression with their current values
    for var in sorted(variables, key=len, reverse=True):  # Sort to avoid partial replacements
        if isinstance(variables[var], str):
            # Wrap strings in quotes
            expr = re.sub(rf'\b{var}\b', f'"{variables[var]}"', expr)
        else:
            expr = re.sub(rf'\b{var}\b', str(variables[var]), expr)

    # Replace built-in functions with valid Python equivalents
    expr = expr.replace("length(", "len(")
    expr = re.sub(r'to_upper\((.*?)\)', r'str(\1).upper()', expr)
    expr = re.sub(r'to_lower\((.*?)\)', r'str(\1).lower()', expr)
    expr = re.sub(r'reverse\s+"(.*?)"', r'"\1"[::-1]', expr)

    # Restrict built-ins for safety in eval()
    safe_globals = {
        "_builtins_": None,
        "len": len,
        "str": str
    }

    try:
        # Safely evaluate the expression and return result
        return eval(expr, safe_globals, {})
    except:
        # If evaluation fails, return raw string value (e.g. fallback for unevaluated)
        return expr.strip('"')

# Core function to execute program lines (statements)
def execute_lines(lines):
    global variables, functions 
    i = 0  # Line pointer
    while i < len(lines):
        line = lines[i].strip()

        # Skip blank lines and comments
        if not line or line.startswith("#"):
            i += 1
            continue

        # Ensure proper syntax (semicolon or braces)
        if not line.endswith(";") and not line.endswith("{") and line != "}":
            print(f"Missing semicolon at line: {line}")
            return

        # Handle variable declaration
        if line.startswith("decl "):
            _, rest = line.split("decl ", 1)
            var_name, expr = map(str.strip, rest[:-1].split("=", 1))  # Remove semicolon
            variables[var_name] = evaluate(expr)  # Save evaluated result

        # Handle print statement
        elif line.startswith("print "):
            expr = line[len("print "):-1]  # Remove semicolon
            print(evaluate(expr))  # Evaluate and print

        # Handle input statement
        elif line.startswith("input "):
            _, rest = line.split("input ", 1)
            var_name, prompt = map(str.strip, rest[:-1].split("=", 1))  # Remove semicolon
            prompt = evaluate(prompt)  # Evaluate prompt string
            val = input(str(prompt) + " ")  # Read input
            variables[var_name] = int(val) if val.isdigit() else val  # Try to store as int

        # Handle function definitions
        elif line.startswith("funct "):
            match = re.match(r'funct\s+(\w+)\((.?)\)\s\{', line)
            if match:
                name = match.group(1)
                params = match.group(2).split(",") if match.group(2).strip() else []
                body = []
                i += 1
                # Capture lines inside the function body
                while i < len(lines) and lines[i].strip() != "}":
                    body.append(lines[i])
                    i += 1
                # Save function definition
                functions[name] = {"params": [p.strip() for p in params], "body": body}

        # Handle function calls
        elif re.match(r"\w+\(.*\);", line):
            func_call = line[:-1]  # Remove semicolon
            match = re.match(r"(\w+)\((.*?)\)", func_call)
            if match:
                name = match.group(1)
                args = [evaluate(arg.strip()) for arg in match.group(2).split(",")] if match.group(2).strip() else []
                if name in functions:
                    # Save current variable scope
                    old_vars = variables.copy()
                    # Assign arguments to function parameters
                    param_list = functions[name]["params"]
                    for p, v in zip(param_list, args):
                        variables[p] = v
                    # Execute function body
                    execute_lines(functions[name]["body"])
                    # Restore previous scope after function execution
                    variables = old_vars
                else:
                    # Not a user-defined function — treat as built-in or expression
                    result = evaluate(func_call)
                    if result is not None:
                        print(result)

        # Handle if-blocks
        elif line.startswith("if "):
            match = re.match(r"if\s+(.?)\s\{", line)
            if match:
                condition = match.group(1)
                block = []
                i += 1
                # Collect lines inside the if block
                while i < len(lines) and lines[i].strip() != "}":
                    block.append(lines[i])
                    i += 1
                # Execute block only if condition is true
                if evaluate(condition):
                    execute_lines(block)

        # Handle else blocks (only executes if reached)
        elif line.startswith("else"):
            block = []
            i += 1
            while i < len(lines) and lines[i].strip() != "}":
                block.append(lines[i])
                i += 1
            execute_lines(block)  # Execute else block

        # Handle repeat loops
        elif line.startswith("repeat "):
            match = re.match(r"repeat\s+(\w+|\d+)\s*\{", line)
            if match:
                count = match.group(1)
                # Count may be a variable or a direct integer
                count = int(variables[count]) if count in variables else int(count)
                block = []
                i += 1
                # Collect lines inside the repeat block
                while i < len(lines) and lines[i].strip() != "}":
                    block.append(lines[i])
                    i += 1
                # Repeat block execution count times
                for _ in range(count):
                    execute_lines(block)
        i += 1  # Move to the next line

# Load and execute a file
def run_file(filename):
    with open(filename) as f:
        lines = f.readlines()
        execute_lines(lines)

# Entry point when script is run directly
if __name__== "__main__":
   
    import sys
    if len(sys.argv) != 2:
        print("Usage: python interpreter.py programs/file.txt")
    else:
        run_file(sys.argv[1])
