# elk-docker
To start just use "vagrant up" kibana will become available at 192.168.111.10 with login "admin" and password "L0nl1L0kl1".

This is dockerized highly available ELK-stack cluster.
The data is gathered with filebeat, moved to logstash, then moved to rabbitmq, and throug another logstash to elasticsearch, then becomes available on kibana interface.
HAproxy is being used for redundancy of cluster elements.

It's just a concept and needs some adjusting to be used in production.
Still with this you can have fully capable highly available elk stack running on your pc. 
