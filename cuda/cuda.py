"""
Author: Lambdald lambdald@163.com
Date: 2024-10-14 22:12:58
LastEditors: lidong lambdald@163.com
LastEditTime: 2024-10-15 10:51:38
Description: 
"""
import os
import sys
from pathlib import Path
import argparse
from typing import List


def find_cuda_paths() -> List[Path]:
    cuda_paths = []
    # linux
    print(sys.platform)
    if sys.platform == 'linux':
        print('System is Linux')
        cuda_dir = Path('/usr/local')
        cuda_paths.extend(list(cuda_dir.glob('cuda-*')))

    elif sys.platform == 'win32':
        print('System is Windows')
        cuda_dir = Path("C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA")
        cuda_paths.extend(list(cuda_dir.glob('v*')))
    else:
        print('System is not Linux or Windows')
        exit(0)

    if len(cuda_paths) == 0:
        print('No CUDA found')
        exit(0)
    
    print('CUDA root dir:', cuda_dir)
    return cuda_paths

def select_cuda_version(cuda_paths: List[Path]):
    print('CUDA paths: ')
    for idx, cuda_path in enumerate(cuda_paths):
        print(f'{idx}: {cuda_path}')
    idx = int(input('Please select a CUDA version: '))
    cuda_path = cuda_paths[idx]
    print('Selected CUDA path:', cuda_path)
    return cuda_path

def write_nushell_cuda_config(cuda_path: Path, config_path: Path):
    config_path.parent.mkdir(parents=True, exist_ok=True)
    cuda_bin_path = cuda_path / 'bin'
    cuda_lib_path = cuda_path / 'lib64'

    with open(config_path, 'w') as f:
        f.write('\n')

        s = """#! cuda config
export-env {
"""
        s += f"""
  $env.CUDA_PATH = '{cuda_path}'

  $env.CUDA_BIN_PATH = '{cuda_bin_path}'

  $env.CUDA_LIB_PATH = '{cuda_lib_path}'
"""
        s += """

  $env.PATH = (
              $env.PATH
              | split row (char esep)
              | append $env.CUDA_BIN_PATH
              | uniq # filter so the paths are unique
          )

  if not ('LD_LIBRARY_PATH' in $env) {
    $env.LD_LIBRARY_PATH = []
  }
  $env.LD_LIBRARY_PATH = (
          $env.LD_LIBRARY_PATH
          | split row (char esep)
          | append $env.CUDA_LIB_PATH
          | uniq # filter so the paths are unique
        )
}
"""
        f.write(s)


def main(args):
    print(os.environ)
    cuda_paths = find_cuda_paths()
    print(f'Find CUDA paths: {cuda_paths}')
    cuda_path = select_cuda_version(cuda_paths)
    print(f'cuda_path: {cuda_path}')
    write_nushell_cuda_config(cuda_path, Path(args.config_path))
    print(f'Write nushell config to {args.config_path}')
    print('CUDA config done')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='CUDA config')
    parser.add_argument('--config_path', type=str, help='config path')
    args = parser.parse_args()
    main(args)
