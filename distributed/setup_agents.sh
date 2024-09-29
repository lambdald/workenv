###
 # @Author: lidong lambdald@163.com
 # @Date: 2024-09-24 18:12:08
 # @LastEditors: lidong lambdald@163.com
 # @LastEditTime: 2024-09-27 14:26:41
 # @Description: 
### 

docker pull determinedai/determined-agent
pip install determined

docker run --gpus all -v /var/run/docker.sock:/var/run/docker.sock -v "$PWD"/agent-config.yaml:/etc/determined/agent-config.yaml determinedai/determined-agent  --config-file /etc/determined/agent-config.yaml

