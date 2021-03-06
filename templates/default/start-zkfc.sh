#!/bin/bash

command=zkfc
h=`hostname`

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin"; pwd`

DEFAULT_LIBEXEC_DIR="$bin"/../libexec
HADOOP_LIBEXEC_DIR=${HADOOP_LIBEXEC_DIR:-$DEFAULT_LIBEXEC_DIR}
. $HADOOP_LIBEXEC_DIR/hadoop-config.sh
. ${bin}/set-env.sh

log=<%= node.apache_hadoop.logs_dir %>/zkfc-<%= node.apache_hadoop.hdfs.user %>-$command-$h.log

"$bin"/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script start $command
sleep 1; head "$log"

PID_FILE=$HADOOP_PID_DIR/hadoop-<%= node.apache_hadoop.hdfs.user %>-$command.pid
PID=`cat $PID_FILE` 
kill -0 $PID 

exit $?

