
# let cuda_paths = 
# let local_cuda_paths = 
let cuda_paths = []
if $env.OS == "Windows_NT" {
  let cuda_paths = (ls "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\*")
}
else if $env.OS == "Linux" {
  let cuda_paths = (ls /usr/local/cuda-* | sort-by name | get name) ++ (ls ~/devlibs/cuda-* | sort-by name | get name)
}

print "CUDA Versions:"
print $cuda_paths

print $"Select a CUDA version to use: 0-(($cuda_paths | length) - 1)"
let key = (input listen --types [key]).code | into int

print $key
let cuda_path = ($cuda_paths | get $key)
print $"Use CUDA version: ($cuda_path)"



def write_cuda_env [cuda_path] {
    mkdir ~/.config/nushell/scripts
    let cuda_config_file = "~/.config/nushell/scripts/cuda.nu"
    print $"Writing CUDA config file: ($cuda_config_file)"
    rm $cuda_config_file

    let cuda_bin_path = ($cuda_path + "/bin")
    let cuda_lib_path = ($cuda_path + "/lib64")

    print $"CUDA bin path: ($cuda_bin_path)"
    print $"CUDA lib path: ($cuda_lib_path)"
    
    $"\n$env.CUDA_PATH=($cuda_path)\n" | save --append $cuda_config_file
    $"\n$env.CUDA_BIN_PATH=($cuda_path)/bin\n" | save --append $cuda_config_file
    $"\n$env.CUDA_LIB_PATH=($cuda_path)/lib64\n" | save --append $cuda_config_file

    "$env.PATH = (
        $env.PATH
        | split row (char esep)
        | append $env.CUDA_BIN_PATH
        | uniq # filter so the paths are unique
      )\n" | save --append $cuda_config_file

      "$env.LD_LIBRARY_PATH = (
        $env.LD_LIBRARY_PATH
        | split row (char esep)
        | append $env.CUDA_LIB_PATH
        | uniq # filter so the paths are unique
      )\n" | save --append $cuda_config_file
}

write_cuda_env $cuda_path


# let cuda_path = (get $cuda_version)

# let cuda_include_path = ($cuda_path + "/include")
# let cuda_lib_path = ($cuda_path + "/lib64")

# let cuda_include = (env CUDA_INCLUDE_PATH $cuda_include_path)
# let cuda_lib = (env CUDA_LIB_PATH $cuda_lib_path)