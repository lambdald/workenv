###
 # @Author: lidong lambdald@163.com
 # @Date: 2024-09-25 16:24:00
 # @LastEditors: lidong lambdald@163.com
 # @LastEditTime: 2024-09-25 16:24:23
 # @Description: 
### 

det deploy local cluster-down
docker volume rm determined_determined-db-volume
det deploy local cluster-up --master-port 8080
