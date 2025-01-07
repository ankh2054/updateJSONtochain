#!/bin/bash
set -euo pipefail  # Stricter error handling

# Configuration
readonly JSONLOC="https://www.sentnl.io/wax.json"
readonly WALLET_PW=XXXXXXXXXXXXXXXXXXXXXXX
readonly EXEC="/home/charles/wax-backup/cleos.sh"
readonly BP_FILE=$(mktemp)  # Safer temporary file handling

# Cleanup on script exit
trap 'rm -f "$BP_FILE"' EXIT

# Fetch and process JSON in one step
fetch_and_process_json() {
    curl -sf "$JSONLOC" | jq -c '.' > "$BP_FILE" || {
        echo "Error: Failed to fetch or process JSON from $JSONLOC"
        exit 1
    }
}

# Update blockchain with new JSON
update_blockchain() {
    local producer
    producer=$(jq -r '.producer_account_name' "$BP_FILE")
    
    # Prepare JSON payload (more efficient than perl)
    local json_payload
    json_payload=$(jq -c -R '.' < "$BP_FILE")
    
    # Execute blockchain updates in a controlled manner
    {
        "$EXEC" wallet unlock --password "$WALLET_PW" > /dev/null &&
        "$EXEC" push action producerjson set "{\"owner\":\"$producer\",\"json\":$json_payload}" -p "$producer@active" &&
        "$EXEC" wallet lock > /dev/null
    } || {
        echo "Error: Failed to update blockchain"
        return 1
    }
}

# Main execution
main() {
    fetch_and_process_json
    update_blockchain
}

main

