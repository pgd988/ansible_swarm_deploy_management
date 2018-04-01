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
	    echo "some case 1"
	    ping -c 10 ya.ru
	    ;;
	    2) 
	    echo "some case 2"
	    ping -c 10 8.8.8.8
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