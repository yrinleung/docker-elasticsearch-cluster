#!/bin/bash
[[ $DEBUG ]] && set -x 

sed -i -e "s/POD_IP/${POD_IP:-'0.0.0.0'}/g" \
       -e "s/HOSTNAME/${HOSTNAME}.${HOSTNAME%-*}.${TENANT_ID}.svc.cluster.local./g" /usr/share/elasticsearch/config/elasticsearch.yml

# if [[ ${SERVICE_POD_NUM} -gt 1 ]];then
#     sed -i '$a\discovery.zen.ping.unicast.hosts' /usr/share/elasticsearch/config/elasticsearch.yml
#     declare -a hosts
#     for i in $(seq ${SERVICE_POD_NUM})
#       do
#         hosts[$i-1]=\"${HOSTNAME%-*}-`expr $i - 1`.${HOSTNAME%-*}.${TENANT_ID}.svc.cluster.local.:9300\"
#       done
#     echo "elsticsearch cluster nodes are ${hosts[@]}"
#     HOSTS=$(echo [${hosts[@]}] | tr ' ' ',')
#     sed -i "s/discovery.zen.ping.unicast.hosts*/discovery.zen.ping.unicast.hosts: ${HOSTS}/g" /usr/share/elasticsearch/config/elasticsearch.yml
#     unset hosts
# fi

sleep 10
CURRENT_POD_NUM=$(nslookup ${SERVICE_NAME} | grep Address | sed '1d' | awk '{print $2}' | wc -l)
[[ $DEBUG ]] && echo $(nslookup ${SERVICE_NAME})> ./logfile
if [[ $CURRENT_POD_NUM -gt 1 ]];then
    sed -i '$a\discovery.zen.ping.unicast.hosts' /usr/share/elasticsearch/config/elasticsearch.yml
    ip=$(nslookup ${SERVICE_NAME} | grep Address | sed '1d' | awk '{print $2}')
    #ips=$(echo $ip | sed "s/ /:${ES_CLUSTER_PORT:-9300},/g" | sed "s/$/:${ES_CLUSTER_PORT:-9300}/")
    ips=$(echo $ip | tr ' ' ',')
    [[ $DEBUG ]] && echo ${ip} >> ./logfile
    sed -i "s/discovery.zen.ping.unicast.hosts*/discovery.zen.ping.unicast.hosts: [${ips}]/g" /usr/share/elasticsearch/config/elasticsearch.yml
fi
    
[[ $PAUSE ]] && sleep $PAUSE
    
exec $@
