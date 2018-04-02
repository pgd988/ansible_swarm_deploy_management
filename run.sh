#/bin/bash

DIALOG=$(dialog --title "Cluster Managment" --clear --menu "Select operation" 15 50 7  1 "Configure cluster nodes" 2 "Deploy new app release"   3 "Some Case" Q "quit" 2>&1 >/dev/tty)

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
	    sed -i "/$DIALOG1_2/d" ./inventory
	    clear
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
   3) 
    echo "some case"
    ;;
   q|Q) 
    echo "Exiting"
    exit 1
    ;;
esac
fi