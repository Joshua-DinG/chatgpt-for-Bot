#!/bin/bash
function show_ad() {
echo -e "\033[32m**********************************************************"
echo "*                                                        *"
echo "*                欢迎使用ChatGPT QQ机器人                *"
echo "*                                                        *"
echo -e "***************************************\033[35m作者QQ群:533109074\033[0m"
echo ""
echo -e "\033[36mhttps://github.com/lss233/chatgpt-mirai-qq-bot\033[0m"
echo ""
 echo -e "\033[32m***************需要,魔法,GPT,技术支持等,就上：\033[35mshop.ding.cm\033[0m\033[0m"
}

# 显示广告页面
show_ad

# 设置文本颜色，黄色
YELLOW='\033[33m'
# 设置文本颜色，白色
WHITE='\033[0m'

# 显示警告信息
echo -e "${YELLOW}提示！运行前,确认能魔法上网并且能访问ChatGPT${WHITE}"

# 等待用户输入
read -p "按下回车键以继续初始化，输入0并回车退出: " input
echo ""

# 判断用户输入
if [[ "$input" == "0" ]]; then
  echo "退出程序。"
  break 0
fi



echo -e "\033[1m\033[38;5;214m初始化环境...\033[0m"
if ! command -v docker &> /dev/null
then
    # 安装 Docker
    echo "正在安装 Docker..."
    sudo apt-get update
    sudo apt-get install -y curl nano tree wget subversion
    curl -fsSL https://get.docker.com | sh
else
    echo "Docker 已经安装，跳过安装步骤。"
fi

# 检查 docker-compose 是否已经安装
if ! command -v docker-compose &> /dev/null
then
    # 安装最新 docker-compose
    echo "正在安装 docker-compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    
    # 添加用户到 docker 用户组并启用更改
    sudo usermod -aG docker $USER && newgrp docker
else
    echo "docker-compose 已经安装，跳过安装步骤。"
fi

echo -e "\033[1m\033[38;5;46m初始化完成...\033[0m"

# 替换文件中的参数
echo -e "\n\n\n"
clear # 清空终端
show_ad
echo -e "\033[1m\033[38;5;214m机器人的参数配置...\033[0m"

read -p $'\e[1m\e[38;5;46m请输入机器人QQ：\e[0m' new_qq
mkdir ${new_qq}
git clone https://github.com/Joshua-DinG/chatgpt-for-Bot ${new_qq}
sed -i 's/^qq = .*/qq = '"${new_qq}"'/g' ./${new_qq}/config.cfg
sed -i 's/uin: .*/uin: '"${new_qq}"'/g' ./${new_qq}/qq/config.yml

echo -e "\n\n\n"
clear # 清空终端
show_ad
read -p $'\033[1m\033[38;5;141m请输入管理员QQ：\033[0m' admin_qq
sed -i "s/^manager_qq = .*/manager_qq = ${admin_qq}/g" ./${new_qq}/config.cfg

echo -e "\n\n\n"
clear # 清空终端
show_ad
read -p $'\e[38;5;201m请输入API-Key：\e[0m' api_key
sed -i "s/^api_key = .*/api_key = \"${api_key}\"/g" ./${new_qq}/config.cfg

echo -e "\033[1m\033[38;5;46m配置完成...\033[0m"



# 下载所需文件
echo -e "\033[1m\033[38;5;214m获取所需文件...\033[0m"
svn co https://github.com/lss233/chatgpt-mirai-qq-bot/trunk/data ./${new_qq}/data
rm -rf ${new_qq}/data/.svn/
svn co https://github.com/lss233/chatgpt-mirai-qq-bot/trunk/fonts ./${new_qq}/fonts
rm -rf ${new_qq}/fonts/.svn/
svn co https://github.com/lss233/chatgpt-mirai-qq-bot/trunk/presets ./${new_qq}/presets
rm -rf ${new_qq}/presets/.svn/
#svn co https://github.com/lss233/chatgpt-mirai-qq-bot/trunk/assets/texttoimg/ ./${new_qq}/assets/texttoimg/
#rm -rf ${new_qq}/assets/texttoimg/.svn/
rm -rf ${new_qq}/.git/
echo -e "\033[1m\033[38;5;46m获取所需文件完成...\033[0m"

echo -e "\033[1m\033[38;5;214m非ROOT用户下面需要输入密码才能继续...\033[0m"
# 运行Dockerfile
echo "正在运行Dockerfile..."
sudo docker build -t gpt:Shop.DinG.CM ${new_qq}/
sudo docker build -t qq:Shop.DinG.CM ./${new_qq}/qq/

# 运行docker-compose.yaml
echo "正在运行docker-compose.yaml..."
cd ./${new_qq}
sudo docker-compose up -d
sudo docker-compose logs -f qq

while true; do sleep 1

