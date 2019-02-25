#!/bin/bash

#删除ES过期的索引

EXPIRE_DAY=30
ES_URL='http://es-cluster-ip:9200'

delete_indies(){
    check_day=`date -d "-$EXPIRE_DAY days" '+%F'`
    index_day=$1
    #将日期转换为时间戳
    check_day_timestamp=`date -d "$check_day" +%s`
    index_day_timestamp=`date -d "$index_day" +%s`
    #当索引的时间戳值小于当前日期30天前的时间戳时，删除此索引
    if [ ${index_day_timestamp} -lt ${check_day_timestamp} ];then
        #转换日期格式
        format_date=`echo $1 | sed 's/-/\./g'`
        curl -XDELETE $ES_URL/*$format_date
    fi
}

curl -XGET %ES_URL/_cat/indices | awk '{print $3}' | awk -F"-" '{print $NF}' | egrep "[0-9]*\.[0-9]*\.[0-9]*" | sort | uniq  | sed 's/\./-/g' | while read LINE
do
    delete_indies $LINE
done