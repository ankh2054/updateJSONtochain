#!/bin/bash

# Erase shell variables after use
set -e

## Config
JSONLOC="https://www.sentnl.io/wax.json"
WALLET_PW=XXXXXXXXXXXXXXXXXXXXXXX
EXEC="/home/charles/wax-backup/cleos.sh" 
BP_FILE="/tmp/bp.json"

createJSON(){
curl -s "$JSONLOC" | jq -M -c '.' > $BP_FILE
PRODUCER=$(cat $BP_FILE | jq -r '.producer_account_name')
# Escaping all quotes
perl -pi -e 's/"/\\"/g' $BP_FILE
}

 updateJSON(){
     $EXEC  wallet unlock --password $WALLET_PW > /dev/null 2>&1
     $EXEC push action producerjson set '{"owner":"'$PRODUCER'","json": "'`cat $BP_FILE`'"}' -p $PRODUCER@active
     $EXEC wallet lock > /dev/null 2>&1

 }
createJSON
updateJSON

