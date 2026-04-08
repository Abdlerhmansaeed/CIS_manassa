import os
import re
import subprocess
import time

lib_path = 'lib'

valid_colors = [
    'primary', 'primaryContainer', 'onPrimaryContainer', 'secondary', 'surface',
    'onPrimary', 'onSurface', 'onSurfaceVariant', 'surfaceContainerHighest',
    'surfaceContainerLowest', 'surfaceContainerLow', 'surfaceContainer',
    'surfaceContainerHigh',
    'outline', 'outlineVariant', 'error', 'errorContainer', 'tertiaryContainer'
]
import_statement = "import 'package:mansaa_app/core/extensions/theme_extension.dart';"

def replace_in_file(file_path):
    if file_path.endswith('app_colors.dart') or file_path.endswith('app_theme.dart') or file_path.endswith('theme_extension.dart'):
        return

    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    original_content = content
    modified_content = content
    replaced = False

    for color in valid_colors:
        pat = r'AppColors\.' + color + r'\b'
        if re.search(pat, modified_content):
            modified_content = re.sub(pat, f'context.colors.{color}', modified_content)
            replaced = True

    if not replaced:
        return

    if import_statement not in modified_content:
        imports = re.findall(r'^import .*;', modified_content, re.MULTILINE)
        if imports:
            last_import = imports[-1]
            modified_content = modified_content.replace(last_import, last_import + '\n' + import_statement, 1)
        else:
            modified_content = import_statement + '\n\n' + modified_content

    # simple inline const removal
    lines = modified_content.split('\n')
    for i, line in enumerate(lines):
        if 'context.colors.' in line and 'const ' in line:
            lines[i] = re.sub(r'\bconst\s+', '', line)
    
    modified_content = '\n'.join(lines)
    
    if modified_content != original_content:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(modified_content)

for root, dirs, files in os.walk(lib_path):
    for file in files:
        if file.endswith('.dart'):
            replace_in_file(os.path.join(root, file))

def fix_const_errors():
    print("Running dart analyze and fixing const errors...")
    while True:
        try:
            result = subprocess.run(["dart", "analyze"], capture_output=True, text=True, shell=True)
            output = result.stdout + result.stderr
        except Exception as e:
            print("Failed to run dart analyze", e)
            break
            
        lines = output.split('\n')
        # Look for "error • Invalid constant value"
        # Format usually:  error • Invalid constant value • lib/features/.../file.dart:12:5 • invalid_constant
        # Or: error • Arguments of a constant creation must be constant expressions • lib/...:12:12 • const_with_non_constant_argument
        
        errors_found = False
        fixed_count = 0
        
        for line in lines:
            if "invalid_constant" in line or "const_with_non_constant_argument" in line or "non_constant_default_value" in line or "const_initialized_with_non_constant_value" in line or "invalid_annotation" in line:
                # Need to parse file:line:col
                parts = line.strip().split(' • ')
                if len(parts) >= 3:
                    file_info = parts[-2] # e.g. lib\features\...\file.dart:12:5
                    path_parts = file_info.split(':')
                    if len(path_parts) >= 3:
                        filepath = ':'.join(path_parts[:-2])
                        try:
                            line_num = int(path_parts[-2])
                            col_num = int(path_parts[-1])
                            
                            with open(filepath, 'r', encoding='utf-8') as f:
                                file_lines = f.readlines()
                            
                            if 0 <= line_num - 1 < len(file_lines):
                                error_line = file_lines[line_num - 1]
                                # remove const from this line
                                if 'const ' in error_line:
                                    file_lines[line_num - 1] = re.sub(r'\bconst\s+', '', error_line)
                                    with open(filepath, 'w', encoding='utf-8') as f:
                                        f.writelines(file_lines)
                                    fixed_count += 1
                                    errors_found = True
                        except Exception as e:
                            print(f"Failed parsing/modifying {file_info}: {e}")

        if not errors_found or fixed_count == 0:
            print("No more constant errors to auto-fix.")
            break
        print(f"Fixed {fixed_count} const errors. Re-analyzing...")

fix_const_errors()
print("Done!")
