#!/bin/env python
import shutil
import glob
from os import path, stat
import sys

if len(sys.argv) != 2:
    print("Usage: hek-sync.py <hek-root>")
    sys.exit(1)

dev_root = "."
hek_root = sys.argv[1]

def sync(pattern):
    dev_files = {path.relpath(f, dev_root): stat(f).st_mtime for f in glob.glob(path.join(dev_root, path.normpath(pattern)), recursive=True)}
    hek_files = {path.relpath(f, hek_root): stat(f).st_mtime for f in glob.glob(path.join(hek_root, path.normpath(pattern)), recursive=True)}
    for f in {*dev_files.keys(), *hek_files.keys()}:
        if f in dev_files and (f not in hek_files or dev_files[f] > hek_files[f]):
            print("Copying to HEK: " + f)
            shutil.copy2(path.join(dev_root, f), path.join(hek_root, f))
        elif f in hek_files and (f not in dev_files or hek_files[f] > dev_files[f]):
            print("Copying to local: " + f)
            shutil.copy2(path.join(hek_root, f), path.join(dev_root, f))

sync("data/levels/alpine/**/**.tif")
sync("data/levels/alpine/**/**.JMS")
sync("data/levels/alpine/**/**.hsc")
sync("data/scenery/wildflower/**/**.tif")
sync("data/scenery/wildflower/**/**.JMS")
sync("data/sky/sky_alpine/**/**.tif")
sync("data/sky/sky_alpine/**/**.JMS")

sync("tags/levels/alpine/**/**.*")
sync("tags/scenery/wildflower/**/**.*")
sync("tags/sky/sky_alpine/**/**.*")
