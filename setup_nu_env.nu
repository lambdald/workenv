
# starship

let starship_path = (which starship).path | get 0

"\n#! starship" | save --append $nu.env-path
$"\nmkdir ~/.cache/starship\n($starship_path) init nu | save -f ~/.cache/starship/init.nu\n" | save --append $nu.env-path
"\n#! starship" | save --append $nu.config-path 
"\nuse ~/.cache/starship/init.nu\n" | save --append $nu.config-path 

mkdir ~/.config/nushell/scripts
# conda
cp conda/nu_conda.nu ~/.config/nushell/scripts/conda.nu
"\n#! conda" | save --append $nu.config-path
"\n$env.CONDA_NO_PROMPT = true\nuse ~/.config/nushell/scripts/conda.nu\n" | save --append $nu.config-path

# cuda
python cuda/cuda.py --config_path ~/.config/nushell/scripts/cuda.nu

"\n#! cuda" | save --append $nu.config-path
"\nuse ~/.config/nushell/scripts/cuda.nu\n" | save --append $nu.config-path
