#!/bin/bash
set -e

mkdir -p tags/levels/alpine/shaders

# invader will generate tags by default into ./tags if exists
invader-bitmap -I -P data/levels/alpine/bitmaps/cliffs.tif -F dxt1 -D rgb
