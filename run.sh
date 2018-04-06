#/bin/bash

DIALOG=$(dialog --title "Cluster Managment" --clear --menu "Select operation" 15 50 7  1 "Configure Nodes Roles" 2 "Deploy new app release" Q "quit" 2>&1 >/dev/tty)

clear
#
if [ "$?" -eq "0" ]; then
case $DIALOG in
   1) DIALOG1=$(dialog --clear --title "Node roles managment" --menu "Select operation" 15 50 7 1 "Manage SWARM" 2 "Edit Nodes List" 3 "Manage Load Balancers" 2>&1 >/dev/tty)
	clear
	case $DIALOG1 in
	    1) DIALOG1_1=$(dialog --clear --title "SWARM Managment" --menu "Select operation" 15 50 7 1 "Deploy config" 2 "Check config" 2>&1 >/dev/tty)
		clear
		case $DIALOG1_1 in
		    1)
		    dialog --title --clear "Deploy new Swarm Custer configuration" --msgbox 'Press Enter for Swarm Custer configuration Deploing' 10 50
		    clear
		    ansible-playbook -i inventory sw.yml
		    clear
		    ;;
		    2)
		    dialog --title --clear "Deploy new Swarm Custer configuration" --msgbox 'Press Enter for Swarm Custer configuration Check' 10 50
		    clear
		    ansible-playbook -i inventory --check sw.yml
		    clear
		    ;;
		esac
	    ;;
	    2)
	    if ! dialog --clear --title "EDIT: LB=Load Balancers Linux_servers=Swarm Nodes" --editbox ./inventory 17 50 2>.inventory.tmp; then
	    clear
	    rm -rf ./.*.tmp
	    else
	    cat .inventory.tmp > inventory
	    rm -rf ./.*.tmp
	    fi
	    clear
	    ;;
	    3) DIALOG1_3_1=$(dialog --clear --title "Load Balancers Managment" --menu "Select operation" 15 50 7 1 "Deploy config" 2 "Check config" 2>&1 >/dev/tty)
		clear
		case $DIALOG1_3_1 in
		    1)
		    dialog --title --clear "Deploy new Load Balancers configuration" --msgbox 'Press Enter for Load Balancers configuration Deploing' 10 50
		    clear
		    ansible-playbook -i inventory LB.yml
		    clear
		    ;;
		    2)
		    dialog --title --clear "Deploy new Load Balancers configuration" --msgbox 'Press Enter for Load Balancers configuration Check' 10 50
		    clear
		    ansible-playbook -i inventory --check LB.yml
		    clear
		    ;;
		esac
	    ;;
	esac
    ;;
    2) DIALOG2=$(dialog --clear --title "Deploying releases" --menu "Select operation" 15 50 7 1 "Deploy new release" 2 "Rollback release" 2>&1 >/dev/tty)
	clear
	case $DIALOG2 in
	    1)
    	    DIALOG2_1=$(dialog --clear --title "Deploying releases" --inputbox "Enter Release TAG:" 15 50 3>&1 1>&2 2>&3 3>&-)
	    ;;
	    2)
	    DIALOG2_2=$(dialog --clear --title "Deploying releases" --inputbox "Enter Release TAG:" 15 50 3>&1 1>&2 2>&3 3>&-)
	    ;;
	esac
    ;;
   q|Q) dialog --clear --title "EXIT" --msgbox "Press Enter to EXIT" 10 50
    clear
    ;;
esac
fi
