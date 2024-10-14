
# starship
"\nmkdir ~/.cache/starship\nstarship init nu | save -f ~/.cache/starship/init.nu\n" | save --append $nu.env-path
"\nuse ~/.cache/starship/init.nu\n" | save --append $nu.config-path 

# conda
"\n$env.CONDA_NO_PROMPT = true\nuse ~/.config/nushell/scripts/conda.nu\n" | save --append $nu.config-path
