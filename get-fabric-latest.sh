#!/bin/bash

minecraft_ver="$1"

# get latest stable fabric loader & installer
loader_ver=$(curl 'https://meta.fabricmc.net/v2/versions/loader' | jq 'map(select(.stable == true)).[0].version')
installer_ver=$(curl 'https://meta.fabricmc.net/v2/versions/installer' | jq 'map(select(.stable == true)).[0].version')

# build server download url
url="https://meta.fabricmc.net/v2/versions/loader/${minecraft_ver}/${loader_ver}/${installer_ver}/server/jar 
