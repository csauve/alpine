#!/bin/bash
set -e

# invader will generate tags by default into ./tags if exists
mkdir -p tags

invader-bitmap -I -P data/levels/alpine/bitmaps/cliffs.tif -F dxt1 -D
