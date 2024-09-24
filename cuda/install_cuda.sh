#!/bin/bash
###
 # @Author: lidong lambdald@163.com
 # @Date: 2024-09-24 17:50:08
 # @LastEditors: lidong lambdald@163.com
 # @LastEditTime: 2024-09-24 17:56:07
 # @Description: 
### 

# 安装依赖
sudo apt update
sudo apt install -y gcc g++ make wget

# 设置 CUDA 和 cuDNN 版本
cuda_version="12.1"
cudnn_version="8.9.2"

# 下载 CUDA

cuda_filename=cuda_12.1.1_530.30.02_linux.run

wget https://developer.download.nvidia.com/compute/cuda/12.1.1/local_installers/$cuda_filename
chmod +x $cuda_filename
sudo ./$cuda_filename
# 在安装过程中，根据提示进行操作，可能需要接受许可协议、选择不安装 NVIDIA 驱动等选项。

# 设置环境变量
echo 'export PATH=/usr/local/cuda-'$cuda_version'/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-'$cuda_version'/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc

# 下载 cuDNN
wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/8.9.2/local_installers/12.1/cudnn-linux-x86_64-8.9.2.26_cuda12-1.tgz

# 解压并安装 cuDNN
tar -xzvf cudnn-linux-x86_64-8.9.2.26_cuda12-1.tgz
sudo cp cudnn-linux-x86_64-8.9.2.26_cuda12-1/include/cudnn*.h /usr/local/cuda-$cuda_version/include
sudo cp cudnn-linux-x86_64-8.9.2.26_cuda12-1/lib/libcudnn* /usr/local/cuda-$cuda_version/lib64
sudo chmod a+r /usr/local/cuda-$cuda_version/include/cudnn*.h /usr/local/cuda-$cuda_version/lib64/libcudnn*

echo "CUDA $cuda_version and cuDNN $cudnn_version installation completed."
