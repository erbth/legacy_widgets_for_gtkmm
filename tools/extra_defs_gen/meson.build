# tools/extra_defs_gen

# Input: cpp_compiler, legacy_widgets_for_gtkmm_build_dep, install_libdir, legacy_widgets_for_gtkmm_pcname
# Output: m4_files, install_m4dir

glibmm_generate_extra_defs_dep = cpp_compiler.find_library(
  'glibmm_generate_extra_defs-2.4',
)

executable('generate_defs_legacy_widgets_for_gtk', 'generate_defs_legacy_widgets_for_gtk.cc',
  dependencies: [legacy_widgets_for_gtkmm_build_dep, glibmm_generate_extra_defs_dep],
  install: false,
)

# Install m4 files for reuse by other *mm projects, when building from git.
m4_basefiles = [
  'convert.m4',
  'convert_legacy_widgets_for_gtk.m4',
]
m4_files = []
foreach file : m4_basefiles
  m4_files += '..' / 'm4' / file
endforeach
m4_files = files(m4_files)
install_m4dir = install_libdir / legacy_widgets_for_gtkmm_pcname / 'proc' / 'm4'
install_data(m4_files, install_dir: install_m4dir)
