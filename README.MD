
![SVG logo](https://www.sentnl.io/sentnl.svg)
          ![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)

# Sentnl.io  

Script that downloads your guilds JSON from your website and pushes it to chain using greyness producerjson contract.

## Requirements 

- jq 
- perl


## Installation

1. Update updateJSON.sh config details to match your own
 - JSONLOC="https://www.sentnl.io/wax.json"
 - WALLET_PW=XXXXXXXXXXXXXXXXXXXXXXX
 - EXEC="/home/charles/wax-backup/cleos.sh" 

2. Setup a cron script to run this daily.
0 0 * * 0 /home/charles/wax-backup/./updateJSON.sh