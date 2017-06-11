#!/bin/bash

# SCRIPT BY MARCEL 'WPMASTER' HALCZYNSKI (C) ALL RIGHTS RESERVED

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="LENOVO K6 NOTE TOOLS BY WPMASTER"
TITLE="WARNING!"
MENU="This operation will erase user data. Before unlocking you have to install android tools"

OPTIONS=(1 "Reboot into Bootloader"
         2 "Check the bootloader status"
         3 "Unlock Bootloader"
		 4 "Install TeamWin Recovery Project")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            echo "Waiting device..."
			adb devices
			clear
			echo "Rebooting into Bootloader..."
			adb reboot bootloader
			./tools.sh
            ;;
        2)
            echo "Check the bootloader status"
			echo "Script will continue after 5 seconds"
			fastboot -i 0x17ef oem device-info
			sleep 5
			./tools.sh
            ;;
        3)
            echo "Unlock Bootloader..."
			fastboot -i 0x17ef oem unlock-go
			clear
			
			echo "Completed, expect the end of the formatting process"
			echo "userdata partition on your device!"
			echo
			echo "Upon completion of the formatting process,"
			echo "the device will automatically reboot in Android OS."
			echo
			echo "Thanks"
			sleep 7
			clear
			./tools.sh
            ;;
		4)
			echo "Install TWRP..."
			
			echo "Check Android device..."
			adb devices
			clear
			
			echo "Reboot into bootloader..."
			adb reboot bootloader
			clear
			
			echo "Flashing TWRP recovery..."
			fastboot -i 0x17ef flash recovery recovery.img
			clear
			
			echo "Reboot into TWRP..."
			fastboot oem reboot-recovery
			
			echo "Install completed!"
			sleep 3
			clear
			;;
esac
