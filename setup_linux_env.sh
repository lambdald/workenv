#!/bin/bash
# 设置工作环境
workenv=`pwd`

# 进入当前目录
cd 

# 输出工作环境
echo "workenv: $workenv"
# 设置工作空间
workspace=$HOME/workenv

mkdir workenv && cd workenv
#! Install conda
echo "*** Install conda ***"
if [ ! -f "$HOME/miniconda3/bin/conda" ]; then
    echo "Download Miniconda"
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    echo "Install Miniconda"
    bash Miniconda3-latest-Linux-x86_64.sh
else
    echo "Miniconda is already installed"
fi

conda init bash

#! Install conda packages
echo "Install conda packages"
conda install nushell starship -c conda-forge -y

#! Install nerd font
echo "Install nerd font"
# from https://www.nerdfonts.com/font-downloads
if [! -f "Hack-v3.003-ttf.zip"]; then
    wget https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
fi

unzip Hack-v3.003-ttf.zip
ls Hack-v3.003-ttf
mkdir -p ~/.local/share/fonts
mv ttf/* ~/.local/share/fonts
fc-cache -f -v

#! Install starship
echo "Configure nushell"
echo "Config conda in nushell"
mkdir -p ~/.config/nushell/scripts
cp $workenv/conda/nu_conda.nu ~/.config/nushell/scripts/conda.nu


#! Configure nushell
nu $workenv/setup_nu_env.nu
