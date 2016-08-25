#!/bin/bash -e

if [[ $# -lt 1 ]]; then

  if [[ ! -f db.configured ]]; then

    # Configure oracle xe database
    sed -i -e "s|###ORACLE_PWD###|$ORACLE_PWD|g" $INSTALL_DIR/$CONFIG_RSP
    /etc/init.d/oracle-xe configure responseFile=$CONFIG_RSP

    chown -R oracle:dba $ORACLE_BASE && \
    chmod u+x $ORACLE_BASE/$RUN_FILE

    # Listener
    echo "LISTENER = \
    (DESCRIPTION_LIST = \
      (DESCRIPTION = \
      (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC_FOR_XE)) \
      (ADDRESS = (PROTOCOL = TCP)(HOST = 0.0.0.0)(PORT = 1521)) \
      ) \
    ) \
    \
    " > $ORACLE_HOME/network/admin/listener.ora

    echo "DEDICATED_THROUGH_BROKER_LISTENER=ON"  >> $ORACLE_HOME/network/admin/listener.ora
    echo "DEFAULT_SERVICE_LISTENER = ($ORACLE_SID)" >> $ORACLE_HOME/network/admin/listener.ora
    echo "DIAG_ADR_ENABLED = off"  >> $ORACLE_HOME/network/admin/listener.ora;
    chown oracle. $ORACLE_HOME/network/admin/listener.ora

    # Create the file that act as a flag that the database has been configured
    touch db.configured
  
  fi

  # Start database service
  su - oracle -c "$ORACLE_BASE/$RUN_FILE"

fi

exec "$@"

