#!/bin/bash

. ./.env


docker-compose up -d

while ! docker-compose exec db sh -c "mysql -u ${ENV_DB_USER} -p${ENV_DB_PASSWORD} -D ${ENV_DB_NAME} -e 'show tables'" > /dev/null 2>&1; do 
  echo "Database is not available"
  sleep 1
done

for sqlfile in `ls -1 database/scripts/*.sql|sort -n`; do
  docker-compose exec db sh -c "mysql -u ${ENV_DB_USER} -p${ENV_DB_PASSWORD} -D ${ENV_DB_NAME} < /tmp/`basename ${sqlfile}`"
done

cat ${ENV_APP_VOLUME}/META-INF/context.xml|sed -e "s/username=\".*\"/username=\"${ENV_DB_USER}\"/" -e "s/password=\".*\"/password=\"${ENV_DB_PASSWORD}\"/" -e "s#url=\"jdbc:mysql://.*:.*/.*\"#url=\"jdbc:mysql://mysql-server:3306/${ENV_DB_NAME}\"#" > ${ENV_APP_VOLUME}/META-INF/context.xml.new
cp ${ENV_APP_VOLUME}/META-INF/context.xml ${ENV_APP_VOLUME}/META-INF/context.xml.ori
mv ${ENV_APP_VOLUME}/META-INF/context.xml.new ${ENV_APP_VOLUME}/META-INF/context.xml
