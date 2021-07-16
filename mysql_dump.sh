#!/bin/bash

user="root"
password="e10adc3949ba59"
host="127.0.0.1"
db_name="ball"

backup_path="/home/tools"
rdate=`date "+%Y-%m-%d+%H%M%S"`
rdateday=`date "+%Y-%m-%d"`
ignoreFlag="with-oss"

if [ ! -d $backup_path/$rdateday ]; then
  mkdir -p $backup_path/$rdateday
fi

umask 177

echo $rdate

echo "---------start dump------"
mysqldump --user=$user --password=$password --host=$host $db_name > $backup_path/$rdateday/$db_name-$rdate.sql
echo "---------end dump--------"


if [ $1 -a $1 = $ignoreFlag ]
then
	echo "--------start upload to oss---------"
	/usr/local/bin/ossutil64 cp -rf $backup_path/$rdateday oss://faya-a/mysqldump/
	echo "--------end upload to oss----------"
else
	echo "ignore upload to oss"
fi

odate=`date "+%Y-%m-%d" -d "-1 days"`

echo "--------start clear old data---------"
echo $odate
rm -rf $backup_path/$odate
echo "--------end clear old data---------"

