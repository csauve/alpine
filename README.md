# Alpine
This repo contains the sources for _Alpine_, a CTF-oriented Halo Custom Edition map:

![Screenshot](screenshot.png)

_Alpine_ is inspired by Valhalla, Relic, The Silent Cartographer (b30), Longest, Hang 'Em High, [Mudslide](http://hce.halomaps.org/index.cfm?fid=528), and [Portent](http://hce.halomaps.org/index.cfm?fid=1796). A custom `sky_alpine` skybox and `wildflower` scenery are also included in this repo.

## Building the map
The [Halo Editing Kit (HEK)][8] is required to build this map. The map relies on the following tag sets, applied in this order:

1. [HEK base tags][11]: Already included in the HEK, but repair if needed.
2. [Fresh MP/SP tagset (Refined Project)][12]: A more complete tag set extracted from stock maps.
3. [Jesse's high resolution HUD][13]: A higher quality player HUD by Jesse, found under `enhancements`.

In each case, copy the tags into the HEK's tags directory to build the dependency tag set. Alpine's own tags also need to be copied into the HEK's tag set. Run the included [Python][3] script to synchronize tags from this project:

```sh
python hek-sync.py <hek-root>
```

This script will copy Alpine tags between the local project and the HEK based on file existence and last modified date, so it can be used during map development too. With the tag set now complete under the HEK, use [Tool][14] to build the map:

```sh
# creates maps/alpine.map
tool.exe build-cache-file levels\alpine\alpine
```

## Asset creation
Source assets can be found under the `data` directory.

Texture sources are `.kra` files for the free 2D software [Krita][7]. They are exported to flattened `.tif` files and then compiled to `.bitmap` tags using Tool.

The map's level geometry is authored in [Blender][2] and exported using [General_101's Blender JMS toolkit][1]. It can be found in `data/levels/alpine/models/alpine.blend`. It contains the following objects:

* **frame**: Only children of this reference frame are exported to the JMS file
  * **bsp**: Main level geometry
  * **portals**: Geometry which divides the map into clusters for rendering, sound, and weather purposes
  * **weather**: Fog planes and weather polyhedra


Before exporting, ensure all mesh modifiers have the "Realtime" setting enabled (so they take effect during export) and that any changes are saved. The scene must be exported at JMS unit scale. Alternatively, use the included script (assumes Wine on Linux) to automatically export the mesh and regenerate lightmaps:

```sh
export WINEPREFIX=<path to wine prefix for Halo and the HEK>
export HALO_HOME=<path to Halo installation within the prefix>
export JMS_EXPORTER=<path to Blend2Halo2-JMS.py>

./compile_bsp.sh
```

Final lightmaps were run with quality `1` and stop value `0.765`.

## Thanks
Thank you to the following folks who helped with tools, advice, and testing for this map:

* Anthony
* General_101
* Jesse
* Mack_Of_Trades69
* MosesOfEgypt
* [Refined team][9]
* Shelly
* Sheriff Brian

## License
This map and its sources are shared under [CC BY-SA 2.0](https://creativecommons.org/licenses/by-sa/2.0/). Feel free to remix or redistribute for any purpose as long as there's attribution and your derivatives are shared under the same license.

[1]: https://github.com/General-101/Halo-Jointed-Model-Blender-Toolset
[2]: https://www.blender.org/
[3]: https://www.python.org/
[4]: https://github.com/Kavawuvi/invader
[5]: https://github.com/Sigmmma/reclaimer
[6]: http://hce.halomaps.org/index.cfm?fid=411
[7]: https://krita.org/en
[8]: http://hce.halomaps.org/hek/
[9]: https://www.reddit.com/r/HaloCERefined/
[10]: https://invader.opencarnage.net/
[11]: https://cdn.discordapp.com/attachments/523620962390769695/654482973390929932/editor_tags.7z
[12]: https://www.dropbox.com/s/j6fb3ox6z1xmzzq/fresh_mp_sp_custom_edition_tagset.7z?dl=1
[13]: https://www.dropbox.com/s/p2d76dsu47axrao/refined_halo1_replacement_tags.7z?dl=1
[14]: https://c20.reclaimers.net/h1/tools/hek/tool/
