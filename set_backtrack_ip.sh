#!/bin/bash
# By Galkan 
# twitter: @cigalkan

function ip_adresi_al()
{
dhclient_path="/sbin/dhclient3"
if [ ! "$dhclient_path" ]
then
echo "$dhclient_path Sistemde Bulunamadi !!!"
        exit 3
else
ag_arayuzu="$1"
pid="`ps -ef | grep "dhclient3" | grep -v "grep" | awk '{print $2}'`"
echo "Otomatik Ip Adresi Alma Islemi Baslatildi ..."
if [ -z "$pid" ]
then
$dhclient_path "$ag_arayuzu" 2>/dev/null else
kill -9 "$pid"
$dhclient_path "$ag_arayuzu" 2>/dev/null fi
fi
}

if [ ! "$#" -eq 1 ]
then
echo "Kullanim: $0 ag_arayuzu"
        exit 1
else
ag_arayuzu="$1"
if [ ! "`ifconfig -a | grep -E "^[a-zA-Z0-9]+" | awk '{print $1}' | grep "$ag_arayuzu" | wc -l`" -eq 1 ]
then
echo "Sistemde Boyle Bir Ag_Arayuzu Bulunamadi !!!"
        exit 2
else
ip_adresi_al "$ag_arayuzu"
fi
fi
