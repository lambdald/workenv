# workenv
My personal working environment for linux and windows.

## Shell
shell是开发环境的基础，好的shell应该提供方便快捷的工具，方便进行系统管理和开发工作。
如果是复杂的操作流程，建议使用python脚本。

本人有Linux和Windows双平台开发需求，优先使用跨平台的nushell。
其次，在Linux使用zsh，在Windows使用PowerShell，这两种shell语言不通用。

目前首选的搭配是：nushell + starship + Hack Nerd Font
### Nushell
[Nushell文档](https://www.nushell.sh/)

### zsh

zsh+oh-my-zsh

### PowerShell

powershell+oh-my-posh

### 通用
starship是个非常好用的命令行提示符修改工具，可以跨平台使用，而且支持多种shell，包括nushell、zsh、PowerShell。

Nerd字体可以提供更好的显示效果，建议使用Hack字体。

## Dev

由于使用C++/Python/Rust开发，所以需要进行开发环境隔离，这里使用conda进行环境管理。

编译的C++和Rust可执行文件安装在conda env的bin目录下，Python的虚拟环境安装在conda env的python包目录下。

### Conda
安装miniconda。