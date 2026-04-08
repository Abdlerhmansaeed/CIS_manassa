import subprocess
import re
import os

def run_analyze():
    result = subprocess.run(["dart", "analyze", "--format", "machine"], capture_output=True, text=True, shell=True)
    return result.stdout

def fix_errors():
    while True:
        output = run_analyze()
        lines = output.strip().split('\n')
        
        fixed_files = set()
        errors_to_fix = [
            "INVALID_CONSTANT",
            "CONST_WITH_NON_CONSTANT_ARGUMENT",
            "NON_CONSTANT_MAP_VALUE",
            "NON_CONSTANT_LIST_ELEMENT",
            "CONST_INITIALIZED_WITH_NON_CONSTANT_VALUE"
        ]
        
        fixes_made = 0
        
        # Machine format: SEVERITY|TYPE|ERROR_CODE|FILE_PATH|LINE|COLUMN|LENGTH|MESSAGE
        for line in lines:
            parts = line.split('|')
            if len(parts) >= 6:
                severity = parts[0]
                error_code = parts[2]
                file_path = parts[3]
                line_num = int(parts[4])
                
                if error_code in errors_to_fix or severity == "ERROR":
                    if os.path.exists(file_path):
                        with open(file_path, 'r', encoding='utf-8') as f:
                            content = f.readlines()
                        
                        if 0 <= line_num - 1 < len(content):
                            original_line = content[line_num - 1]
                            if 'const ' in original_line:
                                content[line_num - 1] = original_line.replace('const ', '')
                                with open(file_path, 'w', encoding='utf-8') as f:
                                    f.writelines(content)
                                fixes_made += 1
                                print(f"Fixed const error in {file_path}:{line_num}")
                            elif 'const' in original_line: # handle cases where there might not be a space after const (rare but possible)
                                # Try more aggressive regex
                                content[line_num - 1] = re.sub(r'\bconst\s+', '', original_line)
                                with open(file_path, 'w', encoding='utf-8') as f:
                                    f.writelines(content)
                                fixes_made += 1
                                print(f"Fixed const error in {file_path}:{line_num}")
        
        if fixes_made == 0:
            print("No more auto-fixable const errors found.")
            break
        print(f"Made {fixes_made} fixes in this pass. Re-analyzing...")

if __name__ == "__main__":
    fix_errors()
