###
 # @Author: lidong lambdald@163.com
 # @Date: 2024-09-24 18:12:08
 # @LastEditors: lidong lambdald@163.com
 # @LastEditTime: 2024-09-24 18:12:21
 # @Description: 
### 

docker pull determinedai/determined-agent
pip install determined

echo "master_host: 192.168.0.12\nmaster_port: 8080" > agent-config.yaml

docker run --gpus all -v /var/run/docker.sock:/var/run/docker.sock -v "$PWD"/agent-config.yaml:/etc/determined/agent.yaml determinedai/determined-agent
