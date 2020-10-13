# Alpine

This repo contains the sources and build automation for my Halo CE map, working title _Alpine_. The map is still a work in progress:

![Screenshot](screenshot.png)

## Design

_Alpine_ is intended to be a semi-symmetric mixed indoor-outdoor map and takes cues from a variety of other Halo maps:

* Exteriors inspired by Valhalla, Relic, [Mudslide](http://hce.halomaps.org/index.cfm?fid=528), and [Portent](http://hce.halomaps.org/index.cfm?fid=1796).
* Interiors inspired by The Silent Cartographer (b30), Longest, Relic, Hang 'Em High

## Building the map

At a high level, Halo CE maps are built in a multi-step iterative process:

1. Source content creation using 2D and 3D software
2. Creation and editing of tags, Halo's binary representation of map data
3. Compilation of a distributable _.map_ cache file

Halo CE maps are traditional built using the Halo Editing Kit (HEK), Photoshop, and 3ds Max on Windows. However, in this project I am attempting to take advantage of modern community-maintained tools when possible and the following instructions will follow my Linux-based workflow. This is an experiment in automation and the script in this project are very much incomplete. I intend to revisit them closer to or after completion of the map.

## Content creation
### Level geometry

The map's level geometry is authored in [Blender][2] and exported using [Project Cartographer's JMS toolset][1]. It can be found in `data/levels/alpine/models/alpine.blend`. The scene uses default units, with the view's clip range set to 100-100,000. It contains the following objects:

* **frame**: Only children of this reference frame are exported to the JMS file
  * **bsp**: Main level geometry
  * **portals**: Geometry which divides the map into clusters for rendering, sound, and weather purposes
  * **weather**: Fog planes and weather polyhedra
* **sun**: Approximate sunlight direction, used for prototyping lighting and shadows. Put Blender in rendered view mode for a preview

Before exporting, ensure all mesh modifiers have the "Realtime" setting enabled (so they take effect during export) and that any changes are saved. You can then run a script to automatically export to JMS, compile the structure, and run lightmaps on it:

```sh
export WINEPREFIX=<path to wine prefix for Halo and the HEK>
export HALO_HOME=<path to Halo installation within the prefix>
export JMS_EXPORTER=<path to Blend2Halo2-JMS.py>

./compile_bsp.sh
```

### Textures

Texture sources are .kra files for the free 2D software [Krita][7]. They are exported to flattened .tif files and then compiled to bitmap tags using the HEK's `tool.exe`. I intend to use scripted invader-bitmap for this in a future change.

### Tag creation
#### Base tagset

Firstly, a base tagset needs to be setup. I am using the stock CE tagset overlaid with some of the [Refined project tags][9]. The downloading and unpacking of these tags into the `tags` directory is automated by running `./build_base_tagset.sh`. Note this requires installing `rsync`, `wget`, and `p7zip` packages.

#### Map tagset (todo)

Map-specific tags will be built using `build_alpine_tagset.sh`, which for now is just a clipboard to keep common commands. I plan to make use of a few different tools:

* [Invader][4]: Replaces the HEK's Tool (mostly). Can be installed from the AUR or built, [see docs][10]
* [Reclaimer][5]: Declaratively generate some tag data? Installed with `pip install --user -r requirements.txt`
* [Halo Editing Kit][6]: Needed to generate tags like .gbxmodel and .scenario_structure_bsp, and run radiosity

I am aiming to avoid the HEK when possible since it's known to be buggy and produce undefined behaviour ingame, which goes against the ideals of repeatable and correct automation. It also seems like the HEK will be unable to target MCC (assuming MCC custom maps are even supported).

#### Lightmaps, scenery placement

Lightmaps can be generated using Tool or Sapien, and scenery (plus vehicles, spawns, netgame flags, etc) must be placed in Sapien as described in the [HEK tutorial][8]. Theoretically these tasks could also be done from within Blender with some yet-to-be-built tooling.

## Todo

* Try to automate shader and other tag creation using YAML and reclaimer, Blender plugin updates
* Finish skybox
* Look into cross-platform task runners like [DoIt][3]

## Thanks

Thank you to the following folks who helped with tools, advice, and testing for this map:

* General_101
* Anthony
* Kavawuvi
* Shelly
* Mack_Of_Trades69
* MosesOfEgypt
* Masterz1337

## License
This map and its sources are shared under [CC BY-SA 2.0](https://creativecommons.org/licenses/by-sa/2.0/). Feel free to remix or redistribute for any purpose as long as there's attribution and your derivatives are shared under the same license.


[1]: https://github.com/General-101/Halo-Jointed-Model-Blender-Toolset
[2]: https://www.blender.org/
[3]: https://pydoit.org/
[4]: https://github.com/Kavawuvi/invader
[5]: https://github.com/Sigmmma/reclaimer
[6]: http://hce.halomaps.org/index.cfm?fid=411
[7]: https://krita.org/en
[8]: http://hce.halomaps.org/hek/
[9]: https://www.reddit.com/r/HaloCERefined/
[10]: https://invader.opencarnage.net/
