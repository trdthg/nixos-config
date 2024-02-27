ip addr | grep inet | grep -v 127.0.0.1 | grep -v inet6 | grep `ip route | grep '^default' | awk '{print $5}'` | awk '{print $2}'
