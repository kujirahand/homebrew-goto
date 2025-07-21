#!/usr/bin/env python3
import os
import subprocess
import hashlib
import re

def get_version():
    """
    'goto --version' を実行してバージョン番号を取得します。
    まず、'../../goto/goto' の存在を確認し、なければPATHから 'goto' を探します。
    """
    script_dir = os.path.dirname(os.path.abspath(__file__))
    goto_executable_path = os.path.join(script_dir, '..', '..', 'goto', 'go', 'goto')

    command = []
    if os.path.exists(goto_executable_path) and os.access(goto_executable_path, os.X_OK):
        command = [goto_executable_path, '--version']
    else:
        command = ['goto', '--version']

    try:
        print(f"Running command: {' '.join(command)}")
        result = subprocess.run(command, capture_output=True, text=True, check=True)
        # 出力は "goto version v1.1.1" や "goto v1.1.1" のような形式を想定
        output = result.stdout.strip()
        print(f"Got version output: {output}")
        match = re.search(r'v?(\d+\.\d+\.\d+)', output)
        if match:
            version = match.group(1)
            print(f"Found version: {version}")
            return version
        else:
            print(f"Error: Could not parse version from output: {output}")
            exit(1)
    except (FileNotFoundError, subprocess.CalledProcessError) as e:
        print(f"Error getting version: {e}")
        print("Please ensure 'goto' is in your PATH or at '../../goto/goto'.")
        exit(1)

def get_sha256(filepath):
    """指定されたファイルのSHA256ハッシュを計算します。"""
    if not os.path.exists(filepath):
        print(f"Error: File not found at {filepath}")
        return None
    
    print(f"Calculating SHA256 for {filepath}...")
    sha256_hash = hashlib.sha256()
    with open(filepath, "rb") as f:
        for byte_block in iter(lambda: f.read(4096), b""):
            sha256_hash.update(byte_block)
    
    hex_digest = sha256_hash.hexdigest()
    print(f"SHA256: {hex_digest}")
    return hex_digest

def main():
    """
    メイン処理。バージョンとSHA256ハッシュを取得し、
    テンプレートを置換してHomebrewのFormulaファイルを作成します。
    """
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.join(script_dir, '..')
    releases_dir = os.path.join(project_root, '..', 'goto', 'releases')

    version = get_version()
    if not version:
        exit(1)

    replacements = {
        "<VERSION>": version,
    }

    file_map = {
        "<SHA256_FOR_ARM_MAC>": f"goto-v{version}-darwin-arm64.zip",
        "<SHA256_FOR_INTEL_MAC>": f"goto-v{version}-darwin-amd64.zip",
        "<SHA256_FOR_ARM_LINUX>": f"goto-v{version}-linux-arm64.zip",
        "<SHA256_FOR_INTEL_LINUX>": f"goto-v{version}-linux-amd64.zip",
    }

    for placeholder, filename in file_map.items():
        filepath = os.path.join(releases_dir, filename)
        sha256 = get_sha256(filepath)
        if sha256:
            replacements[placeholder] = sha256
        else:
            print(f"Could not generate SHA256 for {filename}. Exiting.")
            exit(1)

    template_path = os.path.join(script_dir, 'tempate.rb')
    output_path = os.path.join(project_root, 'goto.rb')

    print(f"\nReading template from: {template_path}")
    with open(template_path, 'r') as f:
        content = f.read()

    for placeholder, value in replacements.items():
        content = content.replace(placeholder, value)

    print(f"Writing new formula to: {output_path}")
    with open(output_path, 'w') as f:
        f.write(content)

    print("\nSuccessfully created goto.rb!")

if __name__ == "__main__":
    main()
