#!/bin/bash

manager=`sed -n '/linux_servers/{n;p;}' ../inventory`
user='ubuntu'
service_name=`grep project_name ../roles/containerization/vars/main.yml | awk {'print$2'}`
msg=`ssh $user@$manager docker service inspect $service_name --pretty`

dialog --title "Service status is" --msgbox "$msg" 50 50
clear
