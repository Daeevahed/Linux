####### script for join to domain YOU Must Run Script with Sudoer Permission
#!/bin/bash

##Set NTP Server##
timedatectl set-timezone Asia/Tehran
echo "NTP=172.21.2.10" >> /etc/systemd/timesyncd.conf
systemctl restart systemd-timesyncd
echo "nameserver	172.21.2.10" >> /etc/resolv.conf

##chaneg hostname
tput setaf 5;echo "Please Insert hostname (lowercase & no symbols)"
read hname 
hostnamectl set-hostname "$hname".ernyka.com


##install apps for join

sudo realm discover example.com

tput setaf 5;echo "please Enter user that have permission for join to domain"
read domainuser
sudo realm join -U $domainuser example.com

sudo realm  list
sudo echo "ad_server = dl-dc01, km-dc01" >> /etc/sssd/sssd.conf
sudo echo "ad_gpo_access_control = permissive" >> /etc/sssd/sssd.conf
sudo realm list
sudo pam-auth-update
sudo systemctl restart sssd
sudo systemctl status sssd
sudo realm permit --all
