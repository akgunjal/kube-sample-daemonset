#!/bin/bash
while true
do
	echo checking service
	# generate new ssh key
	ssh-keygen -t rsa -b 4096 -C "daemonsetaccess" -f id_daemonset -N "" -q
	# clean out existing key if it already exists
	grep -v daemonsetaccess /root/.ssh/authorized_keys > /root/.ssh/authorized_keys.new
	chmod 600 /root/.ssh/authorized_keys.new
	mv /root/.ssh/authorized_keys.new /root/.ssh/authorized_keys
	# add the new key we just generated
	cat id_daemonset.pub >>/root/.ssh/authorized_keys
	# use the keys here
	ssh -oStrictHostKeyChecking=no -i id_daemonset $MY_NODE_NAME "$(< urshelp.sh)"
	# cleanup the keys before we return
	grep -v daemonsetaccess /root/.ssh/authorized_keys > /root/.ssh/authorized_keys.new
	chmod 600 /root/.ssh/authorized_keys.new
	mv /root/.ssh/authorized_keys.new /root/.ssh/authorized_keys
	rm id_daemonset*
	echo sleeping
	sleep 86400
done
