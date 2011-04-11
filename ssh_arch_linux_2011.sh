#!/bin/sh

VALUE=$( "`/usr/bin/cygpath -u "$VBOX_INSTALL_PATH/VBoxManage.exe"`" guestproperty get "Arch Linux 2011" "/VirtualBox/GuestInfo/Net/0/V4/IP" )
if [[ $VALUE == Value* ]]; then
  IP=$( echo "$VALUE" | /usr/bin/cut -c8-99 | /usr/bin/sed 's/$//' )
else
  read -e -p 'IP: ' IP
fi

/usr/bin/ssh -X $IP
