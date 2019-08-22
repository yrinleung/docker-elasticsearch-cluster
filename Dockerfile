FROM elastic/elasticsearch:6.8.0
MAINTAINER dazuimao1990 <guox@goodrain.com>

RUN yum makecache fast && \
    yum install bind-utils -y && \
    yum clean all && \
    rm -rf /var/cache/yum
COPY docker-entrypoint.sh /
COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
EXPOSE 9200 9300
VOLUME ["/usr/share/elasticsearch/data"]
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/local/bin/docker-entrypoint.sh","eswrapper"]
