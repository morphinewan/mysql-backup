#!/bin/bash

if [[ ${BACKUP_NUMBER} == "" ]]; then
	echo "Missing BACKUP_NUMBER env variable"
	exit 1
fi

if [[ ${DB_USER} == "" ]]; then
	echo "Missing DB_USER env variable"
	exit 1
fi

if [[ ${DB_PASS} == "" ]]; then
	echo "Missing DB_PASS env variable"
	exit 1
fi

if [[ ${DB_NAME} == "" ]]; then
	echo "Missing DB_NAME env variable"
	exit 1
fi

if [[ ${DB_HOST} == "" ]]; then
	echo "Missing DB_HOST env variable"
	exit 1
fi

BACKUP_DIR=/var/db/backup
TIMESTAMP=`date +%Y%m%d%H%M%S`

echo "Dumping database: ${DB_NAME}"
mysqldump -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" --triggers --routines --events ${DB_NAME} > ${BACKUP_DIR}/${DB_NAME}-${TIMESTAMP}.sql

#写创建备份日志
echo "create ${BACKUP_DIR}/${DB_NAME}-${TIMESTAMP}.sql" >> ${BACKUP_DIR}/log.txt
#找出需要删除的备份
delfile=`ls -l -crt ${BACKUP_DIR}/*.sql | awk '{print $9 }' | head -1`
#判断现在的备份数量是否大于$number
count=`ls -l -crt  ${BACKUP_DIR}/*.sql | awk '{print $9 }' | wc -l`
if [ ${count} -gt ${BACKUP_NUMBER} ]
then
  rm $delfile  # 删除最早生成的备份只保留number数量的备份
  #写删除文件日志
  echo "delete $delfile" >> ${BACKUP_DIR}/log.txt
fi