#!/bin/bash

DB_USER=${DB_USER:-${MYSQL_ENV_DB_USER}}
DB_PASS=${DB_PASS:-${MYSQL_ENV_DB_PASS}}
DB_NAME=${DB_NAME:-${MYSQL_ENV_DB_NAME}}
DB_HOST=${DB_HOST:-${MYSQL_ENV_DB_HOST}}

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

echo "Dumping database: ${DB_NAME}"
mysqldump -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" --triggers --routines --events ${DB_NAME} > ./mysqldump/${DB_NAME}_$(date +%F_%H%M%S).sql