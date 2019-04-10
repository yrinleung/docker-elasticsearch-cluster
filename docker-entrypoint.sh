#!/bin/bash
[[ $DEBUG ]] && set -x
[[ $PAUSE ]] && sleep $PAUSE
sed -i -e "s/POD_IP/${POD_IP:-'0.0.0.0'}/g" \
       -e "s/HOSTNAME/${HOSTNAME}.${HOSTNAME%-*}.${TENANT_ID}.svc.cluster.local./g" /usr/share/elasticsearch/config/elasticsearch.yml
exec $@
