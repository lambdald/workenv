#!/bin/bash
###
 # @Author: lidong lambdald@163.com
 # @Date: 2024-09-19 11:30:12
 # @LastEditors: lidong lambdald@163.com
 # @LastEditTime: 2024-09-19 11:30:16
 # @Description: 
### 

# 使用 find 命令在 /usr/local/ 下查找以 cuda- 开头的目录
cuda_dirs=($(find /usr/local/ -maxdepth 1 -type d -name "cuda-*"))

# 判断是否找到任何 cuda- 文件夹
if [ ${#cuda_dirs[@]} -eq 0 ]; then
    echo "未找到任何以 'cuda-' 开头的文件夹。"
    exit 1
else
    echo "找到的 'cuda-' 文件夹列表:"
    # 使用循环为每个文件夹标号
    for i in "${!cuda_dirs[@]}"; do
        echo "$i) ${cuda_dirs[$i]}"
    done

    # 提示用户选择编号
    while true; do
        read -p "请输入要将 /usr/local/cuda 软链接到的编号: " index
        # 检查输入是否为有效的数字并且在范围内
        if [[ "$index" =~ ^[0-9]+$ ]] && [ "$index" -ge 0 ] && [ "$index" -lt ${#cuda_dirs[@]} ]; then
            target_dir=${cuda_dirs[$index]}
            echo "你选择的目录是: $target_dir"
            break
        else
            echo "无效选择，请输入有效的编号。"
        fi
    done
fi

# 查找 /usr/local/ 目录下是否存在 'cuda' 软链接
cuda_symlink="/usr/local/cuda"
if [ -L "$cuda_symlink" ]; then
    echo "删除现有的 'cuda' 软链接..."
    sudo rm "$cuda_symlink"
elif [ -e "$cuda_symlink" ]; then
    echo "'/usr/local/cuda' 已存在且不是软链接。无法继续。"
    exit 1
fi

# 创建新的软链接指向用户选择的目录
echo "创建新的软链接: '/usr/local/cuda' -> '$target_dir'"
sudo ln -s "$target_dir" "$cuda_symlink"

echo "软链接已更新完成！"
# 运行 source ~/.bashrc 以加载可能更新的环境变量
echo "更新环境变量..."
source ~/.bashrc


echo "软链接已更新，并且环境变量已重新加载！"
echo "请输入 nvcc -V或者nvcc --version 来检查cuda版本"

