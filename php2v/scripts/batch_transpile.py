#!/usr/bin/env python3
import os
import sys
import argparse
import subprocess
import concurrent.futures
import json
from datetime import datetime

def parse_args():
    parser = argparse.ArgumentParser(description="Batch transpile PHP files to V using php2v")
    parser.add_argument("--src", required=True, help="Source directory containing PHP files")
    parser.add_argument("--dest", required=True, help="Destination directory for output V files")
    parser.add_argument("--threads", type=int, default=os.cpu_count() or 4, help="Number of concurrent threads")
    return parser.parse_args()

def transpile_file(php2v_path, src_file, dest_file, is_lib=False):
    # Ensure destination directory exists
    os.makedirs(os.path.dirname(dest_file), exist_ok=True)
    
    # Run: ./php2v compile <src_file> -o <dest_file> [-mode lib]
    cmd = [php2v_path, "compile", src_file, "-o", dest_file]
    if is_lib:
        cmd += ["-mode", "lib"]
    res = subprocess.run(cmd, capture_output=True, text=True)
    
    if res.returncode == 0:
        return src_file, True, ""
    else:
        # Capture error output
        error_msg = res.stderr.strip() or res.stdout.strip() or "Unknown error"
        return src_file, False, error_msg

def main():
    args = parse_args()
    
    src_dir = os.path.abspath(os.path.expanduser(args.src))
    dest_dir = os.path.abspath(os.path.expanduser(args.dest))
    
    # Locate php2v executable
    script_dir = os.path.dirname(os.path.abspath(__file__))
    php2v_path = os.path.abspath(os.path.join(script_dir, "../php2v"))
    if not os.path.exists(php2v_path):
        print(f"Error: php2v executable not found at {php2v_path}")
        sys.exit(1)
        
    print(f"Scanning for PHP files in {src_dir}...")
    php_files = []
    for root, dirs, files in os.walk(src_dir):
        if "node_modules" in root or ".git" in root:
            continue
        for file in files:
            if file.endswith(".php"):
                php_files.append(os.path.join(root, file))
                
    total_files = len(php_files)
    print(f"Found {total_files} PHP files to transpile.")
    if total_files == 0:
        print("Nothing to do.")
        return

    print(f"Starting batch transpilation using {args.threads} threads...")
    
    results = []
    success_count = 0
    failed_count = 0
    errors = []

    start_time = datetime.now()
    
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.threads) as executor:
        future_to_file = {}
        for src_file in php_files:
            # Map source relative path to destination path
            rel_path = os.path.relpath(src_file, src_dir)
            # Replace .php with .v
            v_rel_path = os.path.splitext(rel_path)[0] + ".v"
            dest_file = os.path.join(dest_dir, v_rel_path)
            
            # Determine compile mode (exe or lib)
            is_lib = True
            norm_rel_path = rel_path.replace("\\", "/")
            # Root directory scripts (e.g. index.php) are entry scripts
            if "/" not in norm_rel_path:
                is_lib = False
            # wp-admin root pages are entry pages
            elif norm_rel_path.startswith("wp-admin/") and "includes/" not in norm_rel_path:
                is_lib = False
                
            future = executor.submit(transpile_file, php2v_path, src_file, dest_file, is_lib)
            future_to_file[future] = src_file
            
        for idx, future in enumerate(concurrent.futures.as_completed(future_to_file)):
            src_file = future_to_file[future]
            try:
                file_path, success, error_msg = future.result()
                if success:
                    success_count += 1
                else:
                    failed_count += 1
                    errors.append({
                        "file": os.path.relpath(file_path, src_dir),
                        "error": error_msg
                    })
            except Exception as e:
                failed_count += 1
                errors.append({
                    "file": os.path.relpath(src_file, src_dir),
                    "error": f"Exception in worker: {str(e)}"
                })
                
            # Log progress every 50 files or at completion
            if (idx + 1) % 50 == 0 or (idx + 1) == total_files:
                elapsed = (datetime.now() - start_time).total_seconds()
                print(f"Progress: {idx + 1}/{total_files} files processed. Success: {success_count}, Failed: {failed_count}. Elapsed: {elapsed:.1f}s")

    end_time = datetime.now()
    duration = (end_time - start_time).total_seconds()
    
    success_rate = (success_count / total_files) * 100 if total_files > 0 else 0
    
    # Save JSON report
    report = {
        "timestamp": end_time.isoformat(),
        "src_dir": src_dir,
        "dest_dir": dest_dir,
        "total_files": total_files,
        "success_count": success_count,
        "failed_count": failed_count,
        "success_rate": f"{success_rate:.2f}%",
        "duration_seconds": duration,
        "failures": errors
    }
    
    report_json_path = os.path.join(dest_dir, "batch_report.json")
    os.makedirs(dest_dir, exist_ok=True)
    with open(report_json_path, "w", encoding="utf-8") as f:
        json.dump(report, f, indent=2, ensure_ascii=False)
        
    # Generate a readable Markdown report
    md_report_path = os.path.join(dest_dir, "batch_report.md")
    with open(md_report_path, "w", encoding="utf-8") as f:
        f.write(f"# Transpilation Batch Report\n\n")
        f.write(f"- **Time**: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"- **Source**: `{src_dir}`\n")
        f.write(f"- **Destination**: `{dest_dir}`\n")
        f.write(f"- **Total PHP Files**: {total_files}\n")
        f.write(f"- **Success Count**: {success_count}\n")
        f.write(f"- **Failed Count**: {failed_count}\n")
        f.write(f"- **Success Rate**: `{success_rate:.2f}%`\n")
        f.write(f"- **Duration**: {duration:.2f} seconds\n\n")
        
        if failed_count > 0:
            f.write(f"## Failure Details\n\n")
            f.write(f"| File | Error Message |\n")
            f.write(f"| --- | --- |\n")
            for fail in errors[:200]: # Limit to top 200 to prevent huge MD files
                clean_err = fail['error'].replace('\n', ' <br> ').replace('|', '\\|')
                f.write(f"| `{fail['file']}` | {clean_err} |\n")
            if failed_count > 200:
                f.write(f"\n*And {failed_count - 200} more failures (see `batch_report.json` for full list).*\n")
                
    print("\n========================================")
    print("Transpilation Complete!")
    print(f"Total: {total_files}")
    print(f"Success: {success_count}")
    print(f"Failed: {failed_count}")
    print(f"Success Rate: {success_rate:.2f}%")
    print(f"Reports saved to {dest_dir}:")
    print(f"  - batch_report.json")
    print(f"  - batch_report.md")
    print("========================================")

if __name__ == "__main__":
    main()
