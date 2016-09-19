ben@random:~/document$ cat look_at_reg.sh
#!/bin/bash
#
#Author:Benjamin Holdermann
#
waitForEnter(){
read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
}
flsProEdition(){
fls -p -r -o $(($1+206848)) $2 | grep $3
}
echo "---------------------------------"
echo -n "Enter file pattern and press [ENTER]: "
read filepat
echo "---------------------------------"
echo -n "Enter offset(16384) or smth else and press [ENTER]: "
read offset
echo "---------------------------------"
echo "Grepping for SAM$"
echo "---------------------------------"
#fls -p -r -o $(($offset+206848)) $filepat | grep SAM$
flsProEdition("$offset" "$filepat" "SAM$")
waitForEnter
echo "---------------------------------"
echo "Grepping for SYSTEM$"
echo "---------------------------------"
flsProEdition("$offset" "$filepat" "SYSTEM$")
waitForEnter
echo "---------------------------------"
echo "Grepping for Softwer"
echo "---------------------------------"
flsProEdition("$offset" "$filepat" "SOFTWARE$")
waitForEnter
echo "---------------------------------"
echo "Grepping for NTUSER.DAT$"
echo "---------------------------------"
flsProEdition("$offset" "$filepat" "NTUSER.DAT$")
waitForEnter
echo "---------------------------------"
echo "Attempt to rip.pl on SYSTEM with usbtor"
echo "if snumber matches look for disk&blablabla"
echo "---------------------------------"
rip.pl -r SYSTEM -p usbtor
waitForEnter
echo "---------------------------------"
echo "Getting last ip"
echo "---------------------------------"
rip.pl -r SYSTEM -p nic_mst2
waitForEnter
