#!/bin/bash
#Author:Benjamin Holdermann
#
#
waitForEnter(){
read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
}
echo "---------------------------------"
echo -n "Provide sample file(sample.E0*) and press [ENTER]: "
read file
echo "---------------------------------"
echo -n "Provide offset and press [ENTER]: "
read offset
echo "---------------------------------"
echo -n "Provide zip file and press [ENTER]: "
read zipfile
fls -p -r -o $(($offset+206848)) $file | grep -i $zipfile
waitForEnter
echo "---------------------------------"
echo "searching in Volume Shadow Copies"
echo "---------------------------------"
echo "---------------------------------"
echo -n "Provide sample file (sample4.E0*) and PRESS [ENTER]: "
read sample
echo "Mounting...."
mount -in ewf $sample -cache /tmp/sample.ovl -offset $(($offset*512)) -out raw /ewf
waitForEnter
echo "---------------------------------"
echo -n "Running losetup, please provide loopdevice (/dev/loop1) and PRESS [ENTER]: "
read loop
losetup -o $((206848*512)) $loop /ewf/$($sample%%.*).dd
waitForEnter
echo "---------------------------------"
echo "Displaying vshadowinfo for $loop"
echo "---------------------------------"
vshadowinfo /dev/$loop
waitForEnter
echo "---------------------------------"
echo "Shadow mounting $loop to /mnt"
echo "---------------------------------"
vshadowmount /dev/$loop /mnt
waitForEnter
echo "---------------------------------"
echo "fls on vss grepping for $zipfile"
echo "---------------------------------"
echo "---------------------------------"
echo -n "Please provide path to vss (/mnt/vss2) and press [ENTER]: "
read vss
fls -p -r $vss |grep $zipfile
echo "---------------------------------"
echo "Now exiv"
echo "---------------------------------"
echo "---------------------------------"
echo -n "Provide path to directory with images and press [ENTER]: "
read dir
for f in $dir
do
 echo -n "Processing $file "
 exiv2 -pt $f
 waitForEnter
done