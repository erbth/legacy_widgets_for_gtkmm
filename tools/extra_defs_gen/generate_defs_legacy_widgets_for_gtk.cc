/* Copyright (c) 2019  Thomas Erbesdobler <t.erbesdobler@gmx.de>
 *
 * This file is part of legacy_widgets_for_gtkmm.
 *
 * legacy_widgets_for_gtkmm is free software: you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as published
 * by the Free Software Foundation, either version 2.1 of the License,
 * or (at your option) any later version.
 *
 * legacy_widgets_for_gtkmm is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

// We always need to generate the .defs for all types because the code
// using deprecated API is generated unconditionally and only disabled
// at compile time.
#undef LEGACY_WIDGETS_FOR_GTK_DISABLE_DEPRECATED

#include <glibmm_generate_extra_defs/generate_extra_defs.h>
#include <legacy_widgets_for_gtk.h>
#include <iostream>

int main(int, char**)
{
  std::cout << get_defs(LWG_TYPE_LED)
	  << get_defs(LWG_TYPE_RGB_LED);

  return 0;
}
