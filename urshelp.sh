#!/bin/bash
/sbin/iptables -I INPUT 1 -p tcp --dport 10255 -j ACCEPT
