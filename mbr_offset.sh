#!/bin/bash
#
# Author: Benjamin Holdermann
waitForEnter(){
read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
}
echo "---------------------------------"
echo -n "Enter file location and press [ENTER]: "
read file
mmls $file
waitForEnter
sigfind -o 510 55am $file
waitForEnter
echo "---------------------------------"
echo -n "Enter Offset for mmls and press [ENTER]: "
read offset
mmls -o $offset $file