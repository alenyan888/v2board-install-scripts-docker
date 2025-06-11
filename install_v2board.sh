#!/bin/bash

# 退出时如果有错误发生则终止脚本
set -e

# 安装必要的软件包：curl、git、docker 和 docker-compose
echo "安装必要的软件包..."
sudo apt install -y curl git apt-transport-https ca-certificates lsb-release sudo

# 安装 Docker
echo "安装 Docker..."
curl -fsSL https://get.docker.com | sudo bash

# 安装 Docker Compose
echo "安装 Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# 验证 Docker 和 Docker Compose 安装
echo "验证安装..."
docker --version
docker-compose --version

# 创建 V2Board 项目目录
echo "创建 V2Board 项目目录..."
mkdir -p ~/v2board
cd ~/v2board

# 下载 V2Board Docker Compose 配置文件
echo "下载 V2Board Docker Compose 配置文件..."
git clone https://github.com/v2board/v2board-docker.git .

# 编辑配置文件（如数据库等）
echo "编辑环境配置..."
cp .env.example .env
# 此时你可以通过文本编辑器（如 nano）修改 .env 文件来配置数据库密码、端口等
nano .env

# 启动 V2Board 服务
echo "启动 V2Board 服务..."
sudo docker-compose up -d

# 查看 Docker 容器状态
echo "查看容器状态..."
sudo docker ps

# 提示完成
echo "V2Board 安装完成! 访问地址：http://<服务器IP>:80"
