# examples

# input: gnome, legacy_widgets_for_gtkmm_dep, build_examples

examples = [
# [[dir-name], exe-name, [sources]]
  [['example'], 'example', ['main.cc', 'LWGExampleWindow.cpp']],
]

foreach ex : examples
  dir = ''
  foreach dir_part : ex[0]
    dir = dir / dir_part
  endforeach
  ex_name = (dir / ex[1]).underscorify()
  ex_sources = []
  resources = []
  foreach src : ex[2]
    if src.endswith('.gresource.xml')
      resources = gnome.compile_resources(dir.underscorify() + '_resources',
        dir / src,
        source_dir: dir
      )
    else
      ex_sources += dir / src
    endif
  endforeach

  exe_file = executable(ex_name, ex_sources, resources,
    dependencies: legacy_widgets_for_gtkmm_dep,
    gui_app: true,
    build_by_default: build_examples
  )
endforeach
