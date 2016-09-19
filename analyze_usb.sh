#!/bin/bash
#
#Author: Benjamin Holdermann
#
mbrfile="MFT"
ddfile="block.dd"
waitForEnter(){
read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
}
echo "---------------------------------"
echo -n "Enter sample file location(sample4.E0*) and press [ENTER]: "
read file
mmls $file
echo -n "Will run sigfind..."
waitForEnter
sigfind -o 510 55aa $file
echo "---------------------------------"
echo -n "Enter Offset for new mmls try and press [ENTER]: "
read offset
waitForEnter
mmls -o $offset $file
echo "---------------------------------"
echo -n "Enter usb_stick image file location(usb_stick.E01) and press [ENTER]: "
read file
mmls $file
echo "---------------------------------"
echo -n "Enter Offset and press [ENTER]: "
read offset
echo "---------------------------------"
echo -n "Enter pattern to grep for and press [ENTER]: "
read grepfile
fls -p -r -o $offset $file | grep -i $grepfile
waitForEnter
echo "---------------------------------"
echo -n "Enter Inode for file and press [ENTER]: "
read inode
echo "---------------------------------"
echo "File will be saved as passwort.txt"
echo "---------------------------------"
icat -o $offset $file $inode > passwort.txt
waitForEnter
echo "---------------------------------"
echo "MBR Auswertung des Sticks"
echo "---------------------------------"
icat -o $offset $file 0 > $mbrfile
echo "---------------------------------"
echo "MBR saved as file $mbrfile in current directory"
echo "---------------------------------"
dd if=$mbrfile skip=$(($inode*1024)) bs=1 count=1024 > $ddfile
echo "---------------------------------"
echo "$ddfile saved in current directory"
echo "---------------------------------"
xxd $ddfile
waitForEnter
