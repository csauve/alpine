#!/bin/bash
set -e

#set these...
#WINEPREFIX
#HALO_HOME

RADIOSITY_QUALITY=1
RADIOSITY_STOP=0.4

blender -b \
  data/levels/alpine/models/alpine.blend \
  --python blender-export.py \
  -- \
  --filepath data/levels/alpine/models/alpine \
  --extension ".JMS" \
  --jms_version 8200 \
  --game_version haloce \
  --hidden_geo \
  --triangulate_faces

# assuming shaders already exist
wine "$HALO_HOME/tool.exe" structure levels\\alpine alpine
wine "$HALO_HOME/LM_Tool.exe" lightmaps levels\\alpine\\alpine alpine $RADIOSITY_QUALITY $RADIOSITY_STOP
