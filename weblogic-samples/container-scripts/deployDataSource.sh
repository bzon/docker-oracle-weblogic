#!/bin/bash -e

echo "Preparing to deploy JMS to the domain.."

DATASOURCE_PROPS_FILE="/u01/oracle/datasource.properties"

# Replace tokens in the datasource properties file
replacer() {
  replacement=$(env | grep $token | sed "s/${token}=//")
  if [[ $(cat $DATASOURCE_PROPS_FILE | grep "###$token###" | wc -l) -gt 0 ]]; then
    sed -i "s+###$token###+$replacement+g" $DATASOURCE_PROPS_FILE
  fi
}

echo "Replacing tokens in $DATASOURCE_PROPS_FILE .."

declare -a DS_ENVS=$(env | grep ^"DS_" | awk -F= '{print $1}')
for token in ${DS_ENVS[@]}
do
  replacer
done

configure_ds() {
  # Do not wait if there is no defined external database
  if [[ ${DS_DB_HOST} != 'localhost' ]]; then
    DB_WAIT_TIMEOUT=${DB_WAIT_TIMEOUT:-60}
    /u01/oracle/wait-for-it.sh ${DS_DB_HOST}:${DS_DB_PORT} --timeout=${DB_WAIT_TIMEOUT} --strict -- echo "${DS_DB_TYPE} ${DS_DB_NAME} Database is ready for use!"
  fi

  # Check if jms-deploy was already executed. This is created to not execute the jms scripts upon container restart.
  if [[ ! -f jms-deploy.success ]]; then
    # Load datasource properties
    wlst -loadProperties $DATASOURCE_PROPS_FILE /u01/oracle/ds-deploy.py

    # Configure JMS
    wlst /u01/oracle/jms-deploy.py

    # Create jms-deploy.success file
    if [[ $? -eq 0 ]]; then
      touch jms-deploy.success
    fi

  fi
}

configure_ds

