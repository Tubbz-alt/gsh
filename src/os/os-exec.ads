------------------------------------------------------------------------------
--                                                                          --
--                                  G S H                                   --
--                                                                          --
--                                                                          --
--                       Copyright (C) 2010-2015, AdaCore                   --
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

with GNAT.OS_Lib; use GNAT.OS_Lib;
with OS.FS;

package OS.Exec is

   type Handle is private;
   --  Private type that map to a process "handle", the type in fact maps to
   --  different type of object depending on the system. On Unix system it will
   --  be usually a process id and on Windows system a handle.

   function Non_Blocking_Spawn
     (Args      : Argument_List;
      Cwd       : String;
      Env       : Argument_List;
      Stdin_Fd  : OS.FS.File_Descriptor;
      Stdout_Fd : OS.FS.File_Descriptor;
      Stderr_Fd : OS.FS.File_Descriptor)
      return Handle;
   --  Launch a process in background.
   --
   --  @param Args command line arguments including the command line itself
   --  @param Cwd directory in which the process is launched
   --  @param Env
   --      environment to be passed to the process. This is a list of of string
   --      which should have the following format "VARIABLE=value"
   --  @param Stdin_Fd Standard input of the spawned process
   --  @param Stdout_Fd likewise for standard output
   --  @param Stderr_Fd likewise for standard error
   --  @return a handle to the spawned process

   function Blocking_Spawn
     (Args      : Argument_List;
      Cwd       : String;
      Env       : Argument_List;
      Stdin_Fd  : OS.FS.File_Descriptor;
      Stdout_Fd : OS.FS.File_Descriptor;
      Stderr_Fd : OS.FS.File_Descriptor)
      return Integer;
   --  Launch a process and return its exit status code.
   --
   --  See Non_Blocking_Spawn for parameters documentation
   --
   --  @return the exit status of the process

private

   type Handle is mod 2 ** Standard'Address_Size;

end OS.Exec;