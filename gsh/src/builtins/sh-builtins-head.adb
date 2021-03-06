------------------------------------------------------------------------------
--                                                                          --
--                                  G S H                                   --
--                                                                          --
--                       Sh.Builtins.Head                          --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--                                                                          --
--                       Copyright (C) 2010-2019, AdaCore                   --
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

with Sh.States.IO; use Sh.States.IO;
with Sh.Utils; use Sh.Utils;
with Sh.String_Utils; use Sh.String_Utils;
with GNAT.OS_Lib; use GNAT.OS_Lib;

package body Sh.Builtins.Head is

   ------------------
   -- Tail_Builtin --
   ------------------

   function Head_Builtin
     (S : in out Shell_State;
      Args : CList)
      return Eval_Result
   is
      Buffer             : String_Access := null;
      Current_Arg        : Integer := 1;
      Args_Last          : constant Integer := Length (Args);
      Line_Number        : Integer := 10;
      Enable_Minus_N_Opt : Boolean := True;

   begin
      --  First parse options
      while Current_Arg <= Args_Last loop
         declare
            CA : constant String := Element (Args, Current_Arg);
            Is_Valid : Boolean;
         begin

            if CA = "-n" then
               --  We cannot have a -<number> option after a -n
               Enable_Minus_N_Opt := False;

               Current_Arg := Current_Arg + 1;

               --  Check that we have an argument
               if Current_Arg > Args_Last then
                  Put (S, 2,
                       "head: option -n requires an argument" & ASCII.LF);
                  return (RESULT_STD, 1);
               end if;

                  --  Check that the argument is an integer
               To_Integer (Element (Args, Current_Arg), Line_Number, Is_Valid);

               if not Is_Valid then
                  Put (S, 2, "head: invalid context" & ASCII.LF);
                  return (RESULT_STD, 1);
               end if;
            elsif CA = "--" then
               exit;
            elsif Starts_With (CA, "-") then

               --  Check that the argument is an integer
               To_Integer (CA (CA'First + 1 .. CA'Last),
                           Line_Number, Is_Valid);
               if not Is_Valid or else not Enable_Minus_N_Opt then
                  Put (S, 2, "head: invalid option" & ASCII.LF);
                  return (RESULT_STD, 1);
               end if;

               --  Only one -<number> option is accepted
               Enable_Minus_N_Opt := False;
            else
               exit;
            end if;

            Current_Arg := Current_Arg + 1;
         end;

      end loop;

      if Current_Arg > Length (Args) then
         Buffer := new String'(Read (S, 0));
      else
         declare
            Fd : File_Descriptor;
            Byte_Reads : Integer;
            Length : Long_Integer;
         begin
            Fd := Open_Read (Resolve_Path (S, Element (Args, Current_Arg)),
                             Binary);
            Length := File_Length (Fd);
            Buffer := new String (1 .. Integer (Length));
            Byte_Reads := Read (Fd, Buffer.all'Address, Buffer.all'Last);
            Close (Fd);
            if Byte_Reads /= Integer (Length) then
               Put (S, 2, "head: cannot read file");
               return (RESULT_STD, 1);
            end if;
         end;
      end if;

      Put (S, 1, To_Line (Buffer.all, Line_Number));

      Free (Buffer);
      return (RESULT_STD, 0);
   end Head_Builtin;

end Sh.Builtins.Head;
