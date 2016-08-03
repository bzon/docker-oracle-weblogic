#!/bin/bash -e

# Start the container as AdminServer if no arguments were passed to `docker run`.
if [[ $# -lt 1 ]]; then
  # Create Datasource
  /u01/oracle/deployDataSource.sh
  # Start Weblogic
  $DOMAIN_HOME/startWebLogic.sh
fi

# Execute whatever argument was passed like `bash`, `createServer.sh`, `createMachine.sh`
if [[ $1 != 'bash' ]]; then /u01/oracle/deployDataSource.sh; fi
exec "${@}"

