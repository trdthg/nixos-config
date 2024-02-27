ip="$(ip addr | grep inet | grep -v 127.0.0.1 | grep -v inet6 | grep `ip route | grep '^default' | awk '{print $5}'` | awk '{print $2}' | awk -F '/' '{print $1}')"

env="
export http_proxy=http://$ip:17890
export https_proxy=http://$ip:17890
"

echo "
$env
echo '$env' >> ~/.bashrc 
echo '$env' >> ~/.zshrc

echo "host: $ip"

sudo apt-get update
sudo apt-get install vim wget curl iputils-ping -y
sudo apt-get install cmake ninja-build -y
"
