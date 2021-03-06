/****************************************************************************
 *                                                                          *
 *                                 G S H                                    *
 *                                                                          *
 *                          C Implementation File                           *
 *                                                                          *
 *                      Copyright (C) 2011-2016, AdaCore                    *
 *                                                                          *
 * GNAT is free software;  you can  redistribute it  and/or modify it under *
 * terms of the  GNU General Public License as published  by the Free Soft- *
 * ware  Foundation;  either version 2,  or (at your option) any later ver- *
 * sion.  GNAT is distributed in the hope that it will be useful, but WITH- *
 * OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY *
 * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License *
 * for  more details.  You should have  received  a copy of the GNU General *
 * Public License  distributed with GNAT;  see file COPYING.  If not, write *
 * to  the  Free Software Foundation,  51  Franklin  Street,  Fifth  Floor, *
 * Boston, MA 02110-1301, USA.                                              *
 *                                                                          *
 ****************************************************************************/

struct gsh_file_attributes {
  int error;

  unsigned char exists;

  unsigned char writable;
  unsigned char readable;
  unsigned char executable;

  unsigned char symbolic_link;
  unsigned char regular;
  unsigned char directory;

  long long stamp;
  long long length;
};

struct gsh_dir_entry {
  struct gsh_file_attributes fi;
  char name[512];
};

#define READ_MODE  0
#define WRITE_MODE  1
#define APPEND_MODE 2

#define P_INHERIT 0
#define P_IDLE 1
#define P_BELOW_NORMAL 2
#define P_NORMAL 3
#define P_ABOVE_NORMAL 4
#define P_HIGH 5

void *
__gsh_open_directory (char *path);
