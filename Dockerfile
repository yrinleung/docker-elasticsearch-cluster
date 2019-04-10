FROM elastic/elasticsearch:6.2.3
COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
#RUN sed -i -e "s/POD_IP/${POD_IP}/g" \
#           -e "s/HOSTNAME/${HOSTNAME}/g" /usr/share/elasticsearch/config/elasticsearch.yml
COPY docker-entrypoint.sh /
CMD ["sh","/docker-entrypoint.sh"]
