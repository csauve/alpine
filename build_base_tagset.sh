#!/bin/bash
set -e

mkdir -p deps tags

# download and extract tagsets
if [ ! -f deps/fresh.7z ]; then
    wget -O deps/fresh.7z "https://www.dropbox.com/s/j6fb3ox6z1xmzzq/fresh_mp_sp_custom_edition_tagset.7z?dl=1"
fi
if [ ! -d deps/fresh ]; then
  # could use -ir@"tag_filter.txt" because we don't need all the tags, but whatever
  7z x deps/fresh.7z -o"deps/fresh"
fi
if [ ! -f deps/refined.7z ]; then
    wget -O deps/refined.7z "https://www.dropbox.com/s/p2d76dsu47axrao/refined_halo1_replacement_tags.7z?dl=1"
fi
if [ ! -d deps/refined_halo1_replacement_tags ]; then
  7z x deps/refined.7z -o"deps"
fi

# overlay tagsets in order
rsync -r "deps/fresh/tags/" tags
rsync -r "deps/refined_halo1_replacement_tags/fixes/missing_multipurpose_fixes/dxt1/" tags
rsync -r "deps/refined_halo1_replacement_tags/fixes/00_active_camo_fix/" tags
rsync -r "deps/refined_halo1_replacement_tags/fixes/00_contrail_fixes/" tags
rsync -r "deps/refined_halo1_replacement_tags/fixes/00_incorrect_multipurpose_fixes/" tags
rsync -r "deps/refined_halo1_replacement_tags/fixes/00_senv_shader_on_gbxmodels_fix/" tags
rsync -r "deps/refined_halo1_replacement_tags/fixes/00_shader_blend_fixes/" tags
rsync -r "deps/refined_halo1_replacement_tags/fixes/00_vehicle_and_weapon_fixes/" tags
rsync -r "deps/refined_halo1_replacement_tags/fixes/01_b40_c10_c40_a30_fog_fixes/" tags
rsync -r "deps/refined_halo1_replacement_tags/fixes/02_sotr_shader_fixes/part_a/" tags
rsync -r "deps/refined_halo1_replacement_tags/enhancements/highres_rasterizer_bitmaps/" tags
rsync -r "deps/refined_halo1_replacement_tags/enhancements/jesse's_high_resolution_halo_hud/" tags
