#!/bin/sh

# copy server files
cp -f /tmp/server/*.jar $PWD
[ ! -f "$PWD/eula.txt" ] && cp /tmp/server/eula.txt $PWD
[ ! -f "$PWD/server.properties" ] && cp /tmp/server/server.properties $PWD

# copy mods
[ ! -d "$PWD/mods" ] && mkdir $PWD/mods
cp -f /tmp/mods/* $PWD/mods

# copy datapack
[ ! -d "$PWD/world" ] && mkdir $PWD/world && mkdir $PWD/world/datapacks
cp -Rf /tmp/datapack/* $PWD/world/datapacks

java -jar server.jar --nogui "$@"
