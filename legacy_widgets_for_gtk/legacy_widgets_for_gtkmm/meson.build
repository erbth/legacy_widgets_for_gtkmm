# legacy_widgets_for_gtk/legacy_widgets_for_gtkmm

# Input: legacy_widgets_for_gtkmm_build_dep, legacy_widgets_for_gtkmm_pcname, maintainer_mode, project_source_root,
#        generate_binding, m4_files, legacy_widgets_for_gtkmm_libversion, install_includedir,
#        dist_cmd, python3
# Output: hg_ccg_basenames, extra_h_files, built_file_targets, built_files_root,
#         legacy_widgets_for_gtkmm_dep

defs_basefiles = [
  'legacy_widgets_for_gtk.defs',
  'legacy_widgets_for_gtk_methods.defs',
  'legacy_widgets_for_gtk_enums.defs',
  'legacy_widgets_for_gtk_signals.defs',
  'legacy_widgets_for_gtk_vfuncs.defs',
  'legacy_widgets_for_gtk_docs.xml',
]

defs_files = []
foreach file : defs_basefiles
  defs_files += '..' / 'src' / file
endforeach

hg_ccg_basenames = [
  'legacy_widgets_for_gtk',
]

extra_cc_files = [
]

extra_h_files = [
  'wrap_init.h',
]

install_headers('..' / 'legacy_widgets_for_gtkmm.h', subdir: legacy_widgets_for_gtkmm_pcname)
install_headers(extra_h_files, subdir: legacy_widgets_for_gtkmm_pcname / 'legacy_widgets_for_gtkmm')

untracked_legacy_widgets_for_gtkmm = 'untracked' / 'legacy_widgets_for_gtk' / 'legacy_widgets_for_gtkmm'
src_untracked_legacy_widgets_for_gtkmm = project_source_root / untracked_legacy_widgets_for_gtkmm

if maintainer_mode

  # Maintainer mode. Generate .h and .cc files from .hg and .ccg files in ../src.

  # doc/reference/meson.build needs this.
  built_files_root = project_build_root

  hg_files = []
  foreach file : hg_ccg_basenames
    hg_files += '..' / 'src' / file + '.hg'
  endforeach

  # Create wrap_init.cc in project_build_root/legacy_widgets_for_gtk/legacy_widgets_for_gtkmm.
  wrap_init_target = custom_target('wrap_init.cc',
    input: hg_files,
    output: 'wrap_init.cc',
    command: [
      python3, generate_binding, 'generate_wrap_init',
      gmmproc_dir,
      '@OUTPUT@',
      'Lwg', # namespace
      '@INPUT@',
    ],
    build_by_default: maintainer_mode,
    install: false,
  )

  # Force meson+ninja to generate source files before anything is compiled.
  # Compilation must depend on these targets.
  built_file_targets = []

  # Create .h/_p.h/.cc files from .hg/.ccg files in project_build_root/legacy_widgets_for_gtk/legacy_widgets_for_gtkmm.
  foreach file : hg_ccg_basenames
    hg_file = '..' / 'src' / file + '.hg'
    ccg_file = '..' / 'src' / file + '.ccg'
    built_file_targets += custom_target(file + '.cc',
      input: [hg_file, ccg_file],
      output: [file + '.stamp', file + '.cc'],
      command: [
        python3, generate_binding, 'gmmproc',
        gmmproc_dir,
        '@OUTPUT0@',
        file,
        meson.current_source_dir() / '..' / 'src',
        project_source_root / 'tools' / 'm4',
		'/usr/lib/x86_64-linux-gnu/gtkmm-3.0/proc/m4',
		'/usr/lib/x86_64-linux-gnu/atkmm-1.6/proc/m4',
		'/usr/lib/x86_64-linux-gnu/pangomm-1.4/proc/m4',
      ],
      depend_files: defs_files + m4_files,
      build_by_default: maintainer_mode,
      install: false,
    )
  endforeach

  extra_include_dirs = ['..']
  legacy_widgets_for_gtkmm_library = library(legacy_widgets_for_gtkmm_pcname,
    wrap_init_target, built_file_targets, extra_cc_files,
    version: legacy_widgets_for_gtkmm_libversion,
    include_directories: extra_include_dirs,
    dependencies: legacy_widgets_for_gtkmm_build_dep,
    install: true,
  )

  built_h_cc_dir = meson.current_build_dir()

else # not maintainer_mode

  # Not maintainer mode. Compile built source code files in
  # project_source_root/untracked/legacy_widgets_for_gtk/legacy_widgets_for_gtkmm.

  # doc/reference/meson.build needs these.
  built_file_targets = []
  built_files_root = project_source_root / 'untracked'

  # Two cases:
  # 1. The source code comes from a tarball, where the built files
  #    are stored in project_source_root/untracked.
  #    There are no built files in the build tree.
  # 2. Files have been built in the build tree. Then maintainer_mode has
  #    been changed from true to false. Files that are missing or not up to date
  #    in project_source_root/untracked are copied from the build tree.

  # Try to copy built source code files to the source tree.
  run_command(
    python3, generate_binding, 'copy_built_files',
    meson.current_build_dir(),
    src_untracked_legacy_widgets_for_gtkmm,
    hg_ccg_basenames,
  )

  built_cc_files = [ src_untracked_legacy_widgets_for_gtkmm / 'wrap_init.cc' ]
  foreach file : hg_ccg_basenames
    built_cc_files += src_untracked_legacy_widgets_for_gtkmm / file + '.cc'
  endforeach

  extra_include_dirs = [ '..', '..' / '..' / 'untracked' / 'legacy_widgets_for_gtk' ]
  legacy_widgets_for_gtkmm_library = library(legacy_widgets_for_gtkmm_pcname,
    built_cc_files, extra_cc_files,
    version: legacy_widgets_for_gtkmm_libversion,
    include_directories: extra_include_dirs,
    dependencies: legacy_widgets_for_gtkmm_build_dep,
    install: true,
  )

  built_h_cc_dir = src_untracked_legacy_widgets_for_gtkmm

endif

# Install built .h and _p.h files.
meson.add_install_script(
  python3.path(), generate_binding, 'install_built_h_files',
  built_h_cc_dir,
  install_includedir / legacy_widgets_for_gtkmm_pcname / 'legacy_widgets_for_gtkmm', # subdir below {prefix}
  hg_ccg_basenames
)

if not meson.is_subproject()
  # Distribute built files.
  # (add_dist_script() is not allowed in a subproject)
  meson.add_dist_script(
    python3.path(), dist_cmd,
    python3.path(), generate_binding, 'dist_built_files',
    built_h_cc_dir,
    untracked_legacy_widgets_for_gtkmm,
    hg_ccg_basenames,
  )
endif

# This is useful in the main project when legacy_widgets_for_gtkmm is used as a subproject.
# It's also used when building example programs and test programs.
legacy_widgets_for_gtkmm_dep = declare_dependency(
  link_with: legacy_widgets_for_gtkmm_library,
  include_directories: extra_include_dirs,
  dependencies: legacy_widgets_for_gtkmm_build_dep
)
