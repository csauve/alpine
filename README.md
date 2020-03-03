# Alpine

This repo contains the sources and build automation for my Halo CE map, working title _Alpine_. The map is still a work in progress:

![Screenshot](screenshots/mesh.png)
![Screenshot 2](screenshots/mesh2.png)

## Design

_Alpine_ is intended to be a semi-symmetric mixed indoor-outdoor map and takes inspiration from a variety of other Halo multiplayer maps and campaign levels:

* The Silent Cartographer (b30)
* Halo (a30)
* Sacred Icon
* Valhalla
* Longest
* Relic
* Hang 'Em High
* [Mudslide](http://hce.halomaps.org/index.cfm?fid=528)
* [Portent](http://hce.halomaps.org/index.cfm?fid=1796)

## Building the map

At a high level, Halo CE maps are built in a multi-step iterative process:

1. Source content creation using 2D and 3D software
2. Creation and editing of tags, Halo's binary representation of map data
3. Compilation of a distributable _.map_ cache file

Halo CE maps are traditional built using the Halo Editing Kit (HEK), Photoshop, and 3ds Max on Windows. However, in this project I am attempting to take advantage of modern community-maintained tools when possible and the following instructions will follow my Linux-based workflow. This is an experiment in automation.

## Content creation
### Level geometry

The map's level geometry is authored in [Blender][2] and exported using [Project Cartographer's JMS exporter][1]. It can be found in `data/levels/alpine/models/alpine.blend`. The scene uses default units, with the view's clip range set to 100-100,000. It contains the following objects:

* **frame**: Only children of this reference frame are exported to the JMS file
  * **bsp**: Main level geometry
* **sun**: Approximate sunlight direction, used for prototyping lighting and shadows. Put Blender in rendered view mode for a preview

Before the map is exported to JMS, apply the edge split (preserves normals for hard edges) and triangulate modifiers. Select "Halo Joined Model Skeleton (.jms)" from the export menu and use these options:

* Path: `data/levels/alpine/models/alpine.JMS`
* Encoding: UTF-8
* Version: 8200
* Game: Halo CE
* Triangulate faces: no

After exporting, undo the application of modifiers. A future improvement could be [applying modifiers non-destructively][8] within the export script so this step isn't necessary. Another improvement could be supporting CLI arguments and invoking `blender` from a build script to export the JMS non-interactively.

### Textures (todo)

Texture sources are .TIFF files, which can be edited in 2D graphics software like Photoshop or [GIMP][7]. There is no need for layers to be flattened, but some textures have an alpha channel which serve a purpose in their corresponding shader tags. Texture and UV work for this map has not begun yet since I'm still iterating on the geometry.

### Tag creation
#### Base tagset

Firstly, a base tagset needs to be setup. I am using the stock CE tagset overlaid with some of the [Refined project tags][9]. The downloading and unpacking of these tags into the `tags` directory is automated by running `./build_base_tagset.sh`. Note this requires installing `rsync`, `wget`, and `p7zip` packages.

#### Map tagset (todo)

Map-specific tags will be built using `build_alpine_tagset.sh`, which for now just compiles a bitmap. I plan to make use of a few different tools:

* [Invader][4]: Replaces the HEK's Tool (mostly). Can be installed from the AUR or built, [see docs][10]
* [Reclaimer][5]: Declaratively generate some tag data? Installed with `pip install --user -r requirements.txt`
* [Halo Editing Kit][6]: Needed to generate tags like .gbxmodel and .scenario_structure_bsp, and run radiosity

I am aiming to avoid the HEK when possible since it's known to be buggy and produce undefined behaviour ingame, which goes against the ideals of repeatable and correct automation. It also seems like the HEK will be unable to target MCC.

#### Lightmaps (todo)

Use tool or Sapien for lightmap generation. Might be nice to create tooling like Aether for 3ds Max, but for Blender instead.

#### Scenery placement (todo)

HEK's Sapien will be used for scenery and netgame flag placement. Theoretically this could also be done by exporting this info from Blender to a YAML format, then serializing that into a scenario tag using reclaimer? That may allow for a shorter development cycle.

## Todo
* Resolve scale and BSP compilation issues using new JMS exporter
* Finish modeling the map
* UV mapping
* Portals
* Create custom textures
* Try to automate shader and other tag creation using YAML and reclaimer
* Try to automate scenery and netgame flag placement using Blender exports and reclaimer rather than Sapien
* Make a custom skybox
* Playtesting
* Look into cross-platform task runners like [DoIt][3]


[1]: https://github.com/Project-Cartographer/H2V-Blender-JMSv2-Exporter
[2]: https://www.blender.org/
[3]: https://pydoit.org/
[4]: https://github.com/Kavawuvi/invader
[5]: https://github.com/Sigmmma/reclaimer
[6]: http://hce.halomaps.org/index.cfm?fid=411
[7]: https://www.gimp.org/
[8]: https://docs.blender.org/api/blender_python_api_2_63_14/bpy.types.Object.html?highlight=object#bpy.types.Object.to_mesh
[9]: https://www.reddit.com/r/HaloCERefined/
[10]: https://invader.opencarnage.net/
