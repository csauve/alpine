#!/bin/bash
set -e

#set these...
#WINEPREFIX
#HALO_HOME
#JMS_EXPORTER

RADIOSITY_QUALITY=0.5
RADIOSITY_STOP=0.38

blender \
  -b data/levels/alpine/models/alpine.blend \
  --python $JMS_EXPORTER \
  -- \
  --filepath data/levels/alpine/models/alpine \
  --encoding utf_8 \
  --jms_version 3 \
  --game_version haloce \
  --extension ".JMS" \
  --triangulate_faces false # this flag doesnt work, but its OK

# assuming shaders already exist
wine "$HALO_HOME/tool.exe" structure levels\\alpine alpine
wine "$HALO_HOME/tool.exe" lightmaps levels\\alpine\\alpine alpine $RADIOSITY_QUALITY $RADIOSITY_STOP
