#!/bin/bash
set -e

#set these...
#WINEPREFIX
#HALO_HOME

RADIOSITY_QUALITY=0.8
RADIOSITY_STOP=0.08

blender -b \
  data/levels/alpine/models/alpine.blend \
  --python blender-export.py \
  -- \
  --filepath data/levels/alpine/models/alpine \
  --extension ".JMS" \
  --jms_version 8200 \
  --game_version haloce \
  --triangulate_faces

# assuming shaders already exist
wine "$HALO_HOME/tool.exe" structure levels\\alpine alpine
wine "$HALO_HOME/tool.exe" lightmaps levels\\alpine\\alpine alpine $RADIOSITY_QUALITY $RADIOSITY_STOP
