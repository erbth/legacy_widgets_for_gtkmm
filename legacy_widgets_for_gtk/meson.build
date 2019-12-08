# legacy_widgets_for_gtk

# Input: install_prefix, install_datadir, install_includedir,
#        legacy_widgets_for_gtkmm_pcname, legacy_widgets_for_gtkmm_api_version, legacy_widgets_for_gtkmm_requires,
#        install_pkgconfigdir, install_libdir, build_deprecated_api,
#        legacy_widgets_for_gtkmm_major_version, legacy_widgets_for_gtkmm_minor_version, legacy_widgets_for_gtkmm_micro_version
# Output: pkg_conf_data, install_includeconfigdir

pkg_conf_data = configuration_data()
pkg_conf_data.set('prefix', install_prefix)
pkg_conf_data.set('exec_prefix', '${prefix}')
pkg_conf_data.set('libdir', '${prefix}' / install_libdir)
pkg_conf_data.set('datarootdir', '${prefix}' / install_datadir)
pkg_conf_data.set('datadir', '${datarootdir}')
pkg_conf_data.set('includedir', '${prefix}' / install_includedir)
pkg_conf_data.set('srcdir', meson.current_source_dir())
pkg_conf_data.set('PACKAGE_TARNAME', meson.project_name())
pkg_conf_data.set('PACKAGE_VERSION', meson.project_version())
pkg_conf_data.set('LEGACY_WIDGETS_FOR_GTKMM_MODULE_NAME', legacy_widgets_for_gtkmm_pcname)
pkg_conf_data.set('LEGACY_WIDGETS_FOR_GTKMM_API_VERSION', legacy_widgets_for_gtkmm_api_version)
pkg_conf_data.set('LEGACY_WIDGETS_FOR_GTKMM_MODULES', legacy_widgets_for_gtkmm_requires)

if not build_deprecated_api
  pkg_conf_data.set('LEGACY_WIDGETS_FOR_GTKMM_DISABLE_DEPRECATED', true)
endif
pkg_conf_data.set('LEGACY_WIDGETS_FOR_GTKMM_MAJOR_VERSION', legacy_widgets_for_gtkmm_major_version)
pkg_conf_data.set('LEGACY_WIDGETS_FOR_GTKMM_MINOR_VERSION', legacy_widgets_for_gtkmm_minor_version)
pkg_conf_data.set('LEGACY_WIDGETS_FOR_GTKMM_MICRO_VERSION', legacy_widgets_for_gtkmm_micro_version)

configure_file(
  input: 'legacy_widgets_for_gtkmm.pc.in',
  output: legacy_widgets_for_gtkmm_pcname + '.pc',
  configuration: pkg_conf_data,
  install_dir: install_pkgconfigdir,
)

configure_file(
  input: 'legacy_widgets_for_gtkmm-uninstalled.pc.in',
  output: legacy_widgets_for_gtkmm_pcname + '-uninstalled.pc',
  configuration: pkg_conf_data,
)

install_includeconfigdir = install_libdir / legacy_widgets_for_gtkmm_pcname / 'include'
configure_file(
  input: 'legacy_widgets_for_gtkmmconfig.h.in',
  output: '@BASENAME@',
  configuration: pkg_conf_data,
  install_dir: install_includeconfigdir,
)

subdir('legacy_widgets_for_gtkmm')
