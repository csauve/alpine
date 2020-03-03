#!/bin/bash
set -e

#set these...
#WINEPREFIX
#HALO_HOME
#JMS_EXPORTER

mkdir -p tags/levels/alpine/shaders

# invader will generate tags by default into ./tags if exists
invader-bitmap -I -P data/levels/alpine/bitmaps/cliffs.tif -F dxt1 -D

blender \
  -b data/levels/alpine/models/alpine.blend \
  --python $JMS_EXPORTER \
  -- \
  data/levels/alpine/models/alpine #.jms output path
# assuming shaders already exist
wine $HALO_HOME/tool.exe structure levels\\alpine alpine
wine $HALO_HOME/tool.exe lightmaps levels\\alpine\\alpine alpine 0 0.8
