#/bin/bash

DIALOG=$(dialog --title "Cluster Managment" --clear --menu "Select operation" 15 50 7  1 "Configure cluster nodes" 2 "Deploy new app release"   3 "Manage Load Balancers" Q "quit" 2>&1 >/dev/tty)

clear
#
if [ "$?" -eq "0" ]; then
case $DIALOG in
   1) DIALOG1=$(dialog --clear --title "Docker Swarm managment" --menu "Select operation" 15 50 7 1 "Add new node" 2 "Remove node frome cluster" 2>&1 >/dev/tty)
	clear
	case $DIALOG1 in
	    1) 
	    DIALOG1_1=$(dialog --clear --title "Docker Swarm managment" --inputbox "Enter New node IP:" 15 50 3>&1 1>&2 2>&3 3>&-)
	    sed -i "/linux_servers/a $DIALOG1_1" ./inventory
	    clear
	    ansible-playbook -i inventory sw.yml
	    clear
	    ;;
	    2) 
	    DIALOG1_2=$(dialog --clear --title "Docker Swarm managment" --inputbox "Enter node IP to REMOVE from cluster:" 15 50 3>&1 1>&2 2>&3 3>&-)
	    sed -n '/linux_servers/,/EOB/p' inventory > .inv_linx
	    sed -n '/lb/,/EOB/p' inventory > .inv_lb
	    if test $(grep -c $DIALOG1_2 .inv_linx) -eq 0; then
	    clear
	    echo "IP NOT IN LINUX_SERVERS  LIST"
	    rm -rf ./.inv_*;
	    else
	    sed -i "/$DIALOG1_2/d" .inv_linx &&
	    cat .inv_lb > inventory && cat .inv_linx >> inventory
	    rm -rf ./.inv_*
	    clear
	    fi
	    ;;
	esac
    ;;
   2) DIALOG2=$(dialog --clear --title "Deploying releases" --menu "Select operation" 15 50 7 1 "Deploy new release" 2 "Rollback release" 2>&1 >/dev/tty)
	clear
	case $DIALOG2 in
	    1)
    	    echo "Start build container..."
	    ;;
	    2)
	    echo "Rollback release"
	    ;;
	esac
    ;;
   3) DIALOG3=$(dialog --clear --title "Load Balancers managment" --menu "Select operation" 15 50 7 1 "Add new Load balancer node" 2 "Remove node" 2>&1 >/dev/tty)
	clear
	case $DIALOG3 in
	1)
	DIALOG3_1=$(dialog --clear --title "Load Balancers managment" --inputbox "Enter New Load Balancer IP:" 15 50 3>&1 1>&2 2>&3 3>&-)
	clear
	sed -i "/lb/a $DIALOG3_1" ./inventory
	clear
	ansible-playbook -i inventory LB.yml
	clear
	;;
	2)
	DIALOG3_2=$(dialog --clear --title "Load Balancers managment" --inputbox "Enter Load Balancer IP to REMOVE:" 15 50 3>&1 1>&2 2>&3 3>&-)
	sed -n '/linux_servers/,/EOB/p' inventory > .inv_linx
	sed -n '/lb/,/EOB/p' inventory > .inv_lb
	if test $(grep -c $DIALOG3_2 .inv_lb) -eq 0; then
	clear
	echo "IP NOT IN LINUX_SERVERS  LIST"
	rm -rf ./.inv_*;
	else
	sed -i "/$DIALOG3_2/d" .inv_lb
	cat .inv_lb > inventory && cat .inv_linx >> inventory
	rm -rf ./.inv_*
	clear
	fi
	;;
	esac
    ;;
   q|Q) 
    echo "Exiting"
    exit 1
    ;;
esac
fi
