#!/bin/sh
API=https://dnsapi.cn/Record.Ddns

IP_FILE=/tmp/dnspodip

get_old_ip() {
    ip=
    if [ -e "$IP_FILE" ]; then
        ip=`cat $IP_FILE`
    fi
    echo $ip
}

save_new_ip() {
    echo -n $1 > $IP_FILE
}

get_new_ip() {
    #echo `curl ifconfig.me`
    echo `nc ns1.dnspod.net 6666`
}

email=156208621@qq.com
passwd=zyxsljwpc

#Use the following command to see domain id and record id
#echo `curl -s -d "login_email=156208621@qq.com&login_password=zyxsljwpc&format=json&domain=surefond.com" https://dnsapi.cn/Domain.Id`
#echo `curl -s -d "login_email=156208621@qq.com&login_password=zyxsljwpc&format=json&domain=surefond.com" https://dnsapi.cn/Record.List`

domain_id=8520302
record_id=48903179
sub_domain=linzhu

old_ip=$(get_old_ip)
new_ip=$(get_new_ip)

if [ "$new_ip" != "$old_ip" ];
then
    curl -k $API -d "format=json&login_email=$email&login_password=$passwd&domain_id=$domain_id&record_id=$record_id&sub_domain=$sub_domain&record_line=默认"
    save_new_ip $new_ip
fi
