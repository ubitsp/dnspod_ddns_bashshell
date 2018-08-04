API_ID=$1
API_Token=$2
host=$3
domain=$4
sleep 30s
oldIP=$(ping -c1 $host.$domain |grep -Eo "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" |tail -n1)
while true 
do
	newIP=$(curl http://ip.qq.com |grep -Eo  "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | head -n1)
	if [ $newIP == $oldIP ];
	then 
		sleep 30s
		continue
	fi
	token="login_token=${API_ID},${API_Token}&format=json&lang=en&error_on_empty=yes&domain=${domain}&sub_domain=${host}"
	record_id=$(curl -X POST https://dnsapi.cn/Record.List -d "${token}" |grep -Eo "[0-9]{9,9}"|tail -n1)
	ddns_result=$(curl -X POST https://dnsapi.cn/Record.Ddns -d "${token}&record_id=${record_id}&record_line_id=0&value=$newIP" |grep -Eo "successful")
	ddns_test="successful"
	if [ $ddns_result == $ddns_test ];
	then
		echo "update ddns successful"
		oldIP=$newIP
	else
		echo "update failed,try again"
		sleep 30s
	fi
done
