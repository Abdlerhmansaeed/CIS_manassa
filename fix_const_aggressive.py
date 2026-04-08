import subprocess
import re
import os

def run_analyze():
    result = subprocess.run(["dart", "analyze", "--format", "machine"], capture_output=True, text=True, shell=True)
    return result.stdout

def fix_errors():
    for _ in range(5): # Limit iterations to prevent infinite loops
        output = run_analyze()
        lines = output.strip().split('\n')
        
        fixes_made = 0
        error_lines_by_file = {}
        
        for line in lines:
            parts = line.split('|')
            if len(parts) >= 6:
                severity = parts[0]
                error_code = parts[2]
                file_path = parts[3]
                line_index = int(parts[4])
                
                if severity == "ERROR" and os.path.exists(file_path):
                    if file_path not in error_lines_by_file:
                        error_lines_by_file[file_path] = set()
                    error_lines_by_file[file_path].add(line_index)

        for file_path, line_indices in error_lines_by_file.items():
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.readlines()
            
            file_modified = False
            for line_num in sorted(line_indices, reverse=True):
                # Search upwards for 'const' from line_num-1
                found_const = False
                for i in range(line_num - 1, -1, -1):
                    if 'const' in content[i]:
                        # Check if it's the start of a widget/list/etc
                        # Most reliable is to just strip 'const ' or 'const'
                        new_line = re.sub(r'\bconst\s+', '', content[i])
                        new_line = re.sub(r'\bconst\b(?!\.)', '', new_line) # avoid breaking constants like AppColors.constName (if any)
                        
                        if new_line != content[i]:
                            content[i] = new_line
                            found_const = True
                            fixes_made += 1
                            file_modified = True
                            print(f"Removed const from {file_path}:{i+1} as parent of error at {line_num}")
                            break # Go to next error line or stop if satisfied
                
                # If not found upwards, maybe it's on the same line (already handled by prev script but let's be sure)
                if not found_const:
                     # sometimes the error is on the line itself
                     i = line_num - 1
                     if i < len(content):
                        new_line = re.sub(r'\bconst\s+', '', content[i])
                        if new_line != content[i]:
                            content[i] = new_line
                            fixes_made += 1
                            file_modified = True
                            print(f"Removed const from same line {file_path}:{line_num}")

            if file_modified:
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.writelines(content)

        if fixes_made == 0:
            print("No more auto-fixable errors found.")
            break
        print(f"Made {fixes_made} fixes in this pass. Re-analyzing...")

if __name__ == "__main__":
    fix_errors()
