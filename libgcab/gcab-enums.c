
/* Generated data (by glib-mkenums) */

/*
 * Copyright (C) 2012 Marc-André Lureau <marcandre.lureau@redhat.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library. If not, see <http://www.gnu.org/licenses/>.
 */

#include "gcab-enums.h"

#include "libgcab/gcab-folder.h"

GType
gcab_compression_get_type (void)
{
  static volatile gsize g_define_type_id__volatile = 0;

  if (g_once_init_enter (&g_define_type_id__volatile))
    {
      static const GEnumValue values[] = {
        { GCAB_COMPRESSION_NONE, "GCAB_COMPRESSION_NONE", "none" },
        { GCAB_COMPRESSION_MSZIP, "GCAB_COMPRESSION_MSZIP", "mszip" },
        { GCAB_COMPRESSION_QUANTUM, "GCAB_COMPRESSION_QUANTUM", "quantum" },
        { GCAB_COMPRESSION_LZX, "GCAB_COMPRESSION_LZX", "lzx" },
        { GCAB_COMPRESSION_MASK, "GCAB_COMPRESSION_MASK", "mask" },
        { 0, NULL, NULL }
      };
      GType g_define_type_id =
        g_enum_register_static (g_intern_static_string ("GCabCompression"), values);
      g_once_init_leave (&g_define_type_id__volatile, g_define_type_id);
    }

  return g_define_type_id__volatile;
}


/* Generated data ends here */

