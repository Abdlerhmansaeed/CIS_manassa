import subprocess
import os

def fix_undefined_context():
    result = subprocess.run(["dart", "analyze", "--format", "machine"], capture_output=True, text=True, shell=True)
    output = result.stdout
    lines = output.strip().split('\n')
    
    fixes_made = 0
    for line in lines:
        parts = line.split('|')
        if len(parts) >= 8:
            error_code = parts[2]
            file_path = parts[3]
            line_num = int(parts[4])
            message = parts[7]
            
            if "Undefined name 'context'" in message and os.path.exists(file_path):
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.readlines()
                
                if 0 <= line_num - 1 < len(content):
                    original_line = content[line_num - 1]
                    # Replace context.colors.XXX with AppColors.XXX
                    # We need to handle both light and dark. In mappers, we usually want the semantic color.
                    # Since we don't have context, we'll revert to AppColors for now.
                    import re
                    new_line = re.sub(r'context\.colors\.(\w+)', r'AppColors.\1', original_line)
                    
                    if new_line != original_line:
                        content[line_num - 1] = new_line
                        with open(file_path, 'w', encoding='utf-8') as f:
                            f.writelines(content)
                        fixes_made += 1
                        print(f"Reverted context.colors to AppColors in {file_path}:{line_num}")
    
    return fixes_made

if __name__ == "__main__":
    count = fix_undefined_context()
    print(f"Finished. Made {count} fixes.")
