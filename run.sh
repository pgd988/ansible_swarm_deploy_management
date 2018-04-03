#/bin/bash

DIALOG=$(dialog --title "Cluster Managment" --clear --menu "Select operation" 15 50 7  1 "Configure Cluster Nodes" 2 "Deploy new app release" 3 "Configure Load Balancers" Q "quit" 2>&1 >/dev/tty)

clear
#
if [ "$?" -eq "0" ]; then
case $DIALOG in
   1) DIALOG1=$(dialog --clear --title "Node roles managment" --menu "Select operation" 15 50 7 1 "Deploy configuration" 2 "Edit Nodes List" 3 "Run Config Check" 2>&1 >/dev/tty)
	clear
	case $DIALOG1 in
	    1) 
	    dialog --title "Deploy new Swarm Custer configuration" --msgbox 'Press Enter for Swarm Custer configuration Deploing' 10 50
	    clear
	    ansible-playbook -i inventory sw.yml
	    clear
	    ;;
	    2) 
	    dialog --clear --title "EDIT: LB=Load Balancers Linux_servers=Swarm Nodes" --editbox ./inventory 17 50 2>.inventory.tmp
	    clear
	    cat .inventory.tmp > inventory
	    rm -rf ./.*.tmp
	    clear
	    ;;
	    3) 
	    dialog --title "Check new Swarm Custer configuration" --msgbox 'Press Enter for Start Checking' 10 50
	    clear
	    ansible-playbook -i inventory --check sw.yml
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
   3) DIALOG3=$(dialog --clear --title "Load Balancers managment" --menu "Select operation" 15 50 7 1 "Deploy new Load Balances config" 2 "Edit Nodes List" 3 "Run Config Check" 2>&1 >/dev/tty)
	clear
	case $DIALOG3 in
	1)
	dialog --title "Deploy new Swarm Custer configuration" --msgbox 'Press Enter for Swarm Custer configuration Deploing' 10 50
	clear
	ansible-playbook -i inventory LB.yml
	clear
	;;
	2)
	dialog --clear --title "EDIT: LB=Load Balancers Linux_servers=Swarm Nodes" --editbox ./inventory 17 50 2>.inventory.tmp
	clear
	cat .inventory.tmp > inventory
	rm -rf ./.*.tmp
	clear
	;;
	3)
	dialog --title "Check new Swarm Custer configuration" --msgbox 'Press Enter for Load Balancers configuration Checking' 10 50
	clear
	ansible-playbook -i inventory --check LB.yml
	clear
	;;

	esac
    ;;
   q|Q) 
    echo "Exiting"
    exit 1
    ;;
esac
fi
