#!/bin/bash

# get the latest version of minecraft compatible with the specified mod
mod_name="${1:-lithium}"
minecraft_ver=$(curl -G --data-urlencode 'loaders=["fabric"]' \
  "https://api.modrinth.com/v2/project/${mod_name}/version" | jq '.[0].game_versions[0]')

echo "$minecraft_ver"
