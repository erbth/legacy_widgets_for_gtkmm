#!/usr/bin/env bash

# legacy_widgets_for_gtkmm/codegen/generate_defs_and_docs.sh

# Global environment variables:
# GMMPROC_GEN_SOURCE_DIR  Top directory where source files are searched for.
#                         Default value: $(dirname "$0")/../..
#                         i.e. 2 levels above this file.
# GMMPROC_GEN_BUILD_DIR   Top directory where built files are searched for.
#                         Default value: $GMMPROC_GEN_SOURCE_DIR
#
# If you use jhbuild, you can set these environment variables equal to jhbuild's
# configuration variables checkoutroot and buildroot, respectively.
# Usually you can leave GMMPROC_GEN_SOURCE_DIR undefined.
# If you have set buildroot=None, GMMPROC_GEN_BUILD_DIR can also be undefined.

# Generated files:
#   legacy_widgets_for_gtkmm/legacy_widgets_for_gtk/src/legacy_widgets_for_gtk_docs.xml
#   legacy_widgets_for_gtkmm/legacy_widgets_for_gtk/src/legacy_widgets_for_gtk_enums.defs
#   legacy_widgets_for_gtkmm/legacy_widgets_for_gtk/src/legacy_widgets_for_gtk_methods.defs
#   legacy_widgets_for_gtkmm/legacy_widgets_for_gtk/src/legacy_widgets_for_gtk_signals.defs

# Root directory of legacy_widgets_for_gtkmm source files.
root_dir="$(dirname "$0")/.."

# Where to search for source files.
if [ -z "$GMMPROC_GEN_SOURCE_DIR" ]; then
  GMMPROC_GEN_SOURCE_DIR="$root_dir/.."
fi

# Where to search for built files.
if [ -z "$GMMPROC_GEN_BUILD_DIR" ]; then
  GMMPROC_GEN_BUILD_DIR="$GMMPROC_GEN_SOURCE_DIR"
fi

# Scripts in glibmm. These are source files.
gen_docs="$GMMPROC_GEN_SOURCE_DIR/glibmm/tools/defs_gen/docextract_to_xml.py"
gen_methods="$GMMPROC_GEN_SOURCE_DIR/glibmm/tools/defs_gen/h2def.py"
gen_enums="$GMMPROC_GEN_SOURCE_DIR/glibmm/tools/enum.pl"

# Where to find the executable that generates extra defs (signals and properties).
extra_defs_gen_dir="$GMMPROC_GEN_BUILD_DIR/legacy_widgets_for_gtkmm/tools/extra_defs_gen"
### If legacy_widgets_for_gtkmm is built with meson:
if [ "$GMMPROC_GEN_SOURCE_DIR" == "$GMMPROC_GEN_BUILD_DIR" ]; then
  # legacy_widgets_for_gtkmm is built with meson, which requires non-source-dir builds.
  # This is what jhbuild does, if necesary, to force non-source-dir builds.
  extra_defs_gen_dir="$GMMPROC_GEN_BUILD_DIR/legacy_widgets_for_gtkmm/build/tools/extra_defs_gen"
fi
### If legacy_widgets_for_gtkmm is built with autotools:
# legacy_widgets_for_gtkmm is built with autotools.
# autotools support, but don't require, non-source-dir builds.

source_prefix="$GMMPROC_GEN_SOURCE_DIR/legacy_widgets_for_gtk"
build_prefix="$GMMPROC_GEN_BUILD_DIR/legacy_widgets_for_gtk"
### If legacy_widgets_for_gtk is built with meson:
if [ "$source_prefix" == "$build_prefix" ]; then
  # legacy_widgets_for_gtk is built with meson, which requires non-source-dir builds.
  # This is what jhbuild does, if neccesary, to force non-source-dir builds.
  build_prefix="$build_prefix/build"
fi
### If legacy_widgets_for_gtk is built with autotools:
# legacy_widgets_for_gtk is built with autotools, which support, but don't require, non-source-dir builds.

out_dir="$root_dir/legacy_widgets_for_gtk/src"

# Documentation
echo === legacy_widgets_for_gtk_docs.xml ===
params="--with-properties --no-recursion"
for dir in "$source_prefix/legacy_widgets_for_gtk" "$build_prefix/legacy_widgets_for_gtk"; do
  if [ -d "$dir" ]; then
    params="$params -s $dir"
  fi
done
"$gen_docs" $params > "$out_dir/legacy_widgets_for_gtk_docs.xml"

shopt -s nullglob # Skip a filename pattern that matches no file

# Enums
echo === legacy_widgets_for_gtk_enum.defs ===
"$gen_enums" "$source_prefix"/legacy_widgets_for_gtk/*.h "$build_prefix"/legacy_widgets_for_gtk/*.h  > "$out_dir/legacy_widgets_for_gtk_enums.defs"

# Functions and methods
echo === legacy_widgets_for_gtk_method.defs ===
"$gen_methods" "$source_prefix"/legacy_widgets_for_gtk/*.h "$build_prefix"/legacy_widgets_for_gtk/*.h  > "$out_dir/legacy_widgets_for_gtk_methods.defs"

# Properties and signals
echo === legacy_widgets_for_gtk_signal.defs ===
"$extra_defs_gen_dir"/generate_defs_legacy_widgets_for_gtk > "$out_dir/legacy_widgets_for_gtk_signals.defs"

