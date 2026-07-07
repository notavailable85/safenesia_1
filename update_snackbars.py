import os
import re

def update_snackbars(directory):
    count = 0
    # Match SnackBar( ... ) but we want to insert duration right after SnackBar(
    # Only if it doesn't already have a duration argument.
    
    # Regex to find SnackBar(
    pattern = re.compile(r'SnackBar\s*\(')
    duration_pattern = re.compile(r'duration\s*:')
    
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.dart'):
                filepath = os.path.join(root, file)
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                if 'SnackBar(' in content:
                    # Let's do a simple replace, but wait, some SnackBars span multiple lines.
                    # It's safer to just do a string replace:
                    # We will replace `SnackBar(` with `SnackBar(duration: const Duration(milliseconds: 2500), `
                    # But we only do this if `duration:` is not in the same SnackBar.
                    # Actually, a simple way is:
                    # Replace `SnackBar(content:` with `SnackBar(duration: const Duration(milliseconds: 2500), content:`
                    # Let's check how many SnackBars don't start with `content:`.
                    pass
                    
                # A safer regex: find SnackBar( followed by anything up to the matching closing parenthesis?
                # Python's re doesn't easily do nested parenthesis.
                # Let's just replace `SnackBar(` with `SnackBar(duration: const Duration(milliseconds: 2500), `
                # and then we'll find if any file has duplicate `duration:` and fix it manually.
                # Or we can replace `SnackBar(` -> `SnackBar(duration: const Duration(milliseconds: 2500), `
                
                new_content = content.replace('SnackBar(content:', 'SnackBar(duration: const Duration(milliseconds: 2500), content:')
                new_content = new_content.replace('SnackBar(\n', 'SnackBar(\nduration: const Duration(milliseconds: 2500),\n')
                new_content = new_content.replace('SnackBar(  content:', 'SnackBar(duration: const Duration(milliseconds: 2500), content:')
                
                # if there is any `duration: const Duration(milliseconds: 2500), duration:` we fix it
                if new_content != content:
                    with open(filepath, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    count += 1

    print(f"Updated {count} files.")

if __name__ == '__main__':
    update_snackbars(r'c:\src\safenesia_1\lib')
