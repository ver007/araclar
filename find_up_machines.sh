#!/bin/bash
# By Gokhan ALKAN
# twitter: @cigalkan , web site: http://www.agguvenligi.net/

subnet="$1"
thread_count="$2"

if [ ! $# -eq 2 ]
then
    echo "Usage: $0 <subnet> <thread_count>"
    exit 1   
fi

function pinger()
{
    ip="$1"

    tmp_file="`mktemp /tmp/$USER.XXXXXX`"
    ping -c 1 -w 2 "$ip_addr" > $tmp_file

        grep -q "1 received" $tmp_file

        if [ $? -eq 0 ]
        then
                echo "$ip_addr: alive"
        else
                echo "$ip_addr: down"
        fi

    rm -f $tmp_file
}

for ip in `seq 1 254`
do
    ip_addr="`echo $subnet | cut -d "." -f1-3`.$ip"

    while [ 1 ]
    do
        ping_count="`ps -ef | grep ping | grep -v grep | wc -l`"

        if [ "$ping_count" -gt $thread_count ]
        then
            sleep 0.5
        else
            break
        fi
    done

    pinger "$ip_addr" &   
done
