#!/bin/bash

# retrieve the download url for the latest version of a mod compatible with the given version of Minecraft

mod_name="$1"
minecraft_version="$2"

url=$(curl -G --data-urlencode 'loaders=["fabric"]' \
  --data-urlencode "game_versions=[\"${minecraft_version}\"]" \
  "https://api.modrinth.com/v2/project/${mod_name}/version" | jq '.[0].files[0].url')

echo $url

