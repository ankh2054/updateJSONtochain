#!/bin/bash

## Config
JSONLOC="https://www.sentnl.io/wax.json"
WALLET_PW=XXXXXXXXXXXXXXXXXXXXXXX
PRODUCER=sentnlagents
EXEC="/home/charles/wax-backup/cleos.sh" 


createJSON(){
    curl $JSONLOC -o bp.json
}

updateJSON(){
    $EXEC  wallet unlock --password $WALLET_PW > /dev/null 2>&1
    $EXEC push action producerjson set '{"owner":"'$PRODUCER'", "json": "'`printf %q $(cat bp.json | tr -d "\r")`'"}' -p $PRODUCER@active
    $EXEC wallet lock > /dev/null 2>&1
    
}

createJSON
updateJSON


