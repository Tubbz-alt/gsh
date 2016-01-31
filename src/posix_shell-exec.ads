------------------------------------------------------------------------------
--                                                                          --
--                                  G S H                                   --
--                                                                          --
--                                                                          --
--                       Copyright (C) 2010-2016, AdaCore                   --
--                                                                          --
-- GSH is free software;  you can  redistribute it  and/or modify it under  --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 2,  or (at your option) any later ver- --
-- sion.  GSH is distributed in the hope that it will be useful, but WITH-  --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License  distributed with GNAT;  see file COPYING.  If not, write --
-- to  the  Free Software Foundation,  51  Franklin  Street,  Fifth  Floor, --
-- Boston, MA 02110-1301, USA.                                              --
--                                                                          --
-- GSH is maintained by AdaCore (http://www.adacore.com)                    --
--                                                                          --
------------------------------------------------------------------------------

with Posix_Shell.Variables; use Posix_Shell.Variables;

package Posix_Shell.Exec is

   procedure Shell_Exit (S : in out Shell_State; Code : Integer);
   pragma No_Return (Shell_Exit);
   --  Causes the shell to exit with the given error code.

   Shell_Exit_Exception : exception;
   --  An exception signaling that we need to exit the current shell.
   --  At the time when this exception is raised, the exit status has
   --  already been saved.

   Shell_Return_Exception : exception;
   --  An exception signaling that we need to return from the current
   --  shell.  At the time this exception is raised, the exit status
   --  has already been saved.

end Posix_Shell.Exec;
