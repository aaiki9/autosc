#!/bin/bash
#installer Websocker tunneling 

cd

#Install Script Websocket-SSH Python
wget -O /usr/local/bin/ws-dropbear https://raw.githubusercontent.com/aaiki9/autoscript-multiws/main/sshws/ws-dropbear
wget -O /usr/local/bin/ws-stunnel https://raw.githubusercontent.com/aaiki9/autoscript-multiws/main/sshws/ws-stunnel

#izin permision
chmod +x /usr/local/bin/ws-dropbear
chmod +x /usr/local/bin/ws-stunnel

#System Dropbear Websocket-SSH Python
#wget -O /etc/systemd/system/ws-dropbear.service https://raw.githubusercontent.com/aaiki9/autoscript-multiws/main/sshws/service-wsdropbear && chmod +x /etc/systemd/system/ws-dropbear.service
# Create system Service ws-dropbear
cat > /etc/systemd/system/ws-dropbear.service <<END
[Unit]
Description=Dropbear Python Over Websocket
Documentation=https://github.com/syapik96/aws
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ws-dropbear
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

#System SSL/TLS Websocket-SSH Python
#wget -O /etc/systemd/system/ws-stunnel.service https://raw.githubusercontent.com/aaiki9/autoscript-multiws/main/sshws/ws-stunnel.service && chmod +x /etc/systemd/system/ws-stunnel.service
# Create system Service ws-stunnel
cat > /etc/systemd/system/ws-stunnel.service <<END
[Unit]
Description=Python Ssl Proxy Websocket
Documentation=https://github.com/syapik96/aws
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ws-stunnel
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

#restart service
systemctl daemon-reload

#Enable & Start & Restart ws-dropbear service
systemctl enable ws-dropbear.service
systemctl start ws-dropbear.service
systemctl restart ws-dropbear.service

#Enable & Start & Restart ws-openssh service
systemctl enable ws-stunnel.service
systemctl start ws-stunnel.service
systemctl restart ws-stunnel.service