#ifndef LEGACY_WIDGETS_FOR_GTK_INIT_INCLUDED
#define LEGACY_WIDGETS_FOR_GTK_INIT_INCLUDED

#include "wrap_init.h"
#include <gtkmm.h>

void legacy_widgets_for_gtk_init()
{
	Gtk::Main::init_gtkmm_internals();
	Lwg::wrap_init();
}

#endif
