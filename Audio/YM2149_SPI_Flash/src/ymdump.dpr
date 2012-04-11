{
YM5 and YM6 dumper.
(c)2001,2004 Bulba S.V.
You can use this source as you want without any reference to author.
Originally compiled in Delphi 5.
Sergey Bulba, vorobey@mail.khstu.ru, http://bulba.at.kz/
}
{$APPTYPE CONSOLE}

uses
 SysUtils;

type
 dword=longword;
 Ym5_Header = packed record
  Id:dword;
  Leo:array[0..7]of char;
  Num_of_tiks:dword;
  Song_Attr:dword;
  Num_of_Dig:word;
  ChipFrq:dword;
  InterFrq:word;
  Loop:dword;
  Add_Size:word;
 end;

 function revers(i:integer):integer;
 var
  b,c,d:integer;
 begin
  b := i and $ff00 shl 8;
  c := i and $ff0000 shr 8;
  d := i shr 24;
  result := i shl 24 + b + c + d
 end;

var
 f:file;
 buf:array of byte;
 head:Ym5_Header;
 i,j:integer;
 f2:textfile;
 f3:file;
 b:byte;
 s,s2:string;
begin
if paramcount <> 1 then
 begin
  Writeln('    Usage:');
  Writeln('  ymdump [uncompresedYM5orYM6filename]');
  exit
 end;
assignfile(f,paramstr(1));
reset(f,1);
blockread(f,head,sizeof(head));
setlength(buf,revers(head.Num_of_tiks)*16);
seek(f,filepos(f)+lo(head.Add_Size)*256+hi(head.Add_Size));
for i := 0 to lo(head.Num_of_Dig)*256 + hi(head.Num_of_Dig) - 1 do
 begin
  blockread(f,j,4);
  seek(f,filepos(f) + revers(j))
 end;
for i := 1 to 3 do
 repeat
  blockread(f,b,1);
 until b=0;
blockread(f,buf[0],revers(head.Num_of_tiks)*16);
closefile(f);
s := paramstr(1) + '.txt';
s2 := paramstr(1) + '.dat';
assignfile(f2,s);
assignfile(f3,s2);
rewrite(f2);
rewrite(f3, 1);
for i := 0 to revers(head.Num_of_tiks) - 1 do
 begin
  for j := 0 to 15 do
   if head.Song_Attr and $01000000 <> 0 then
   begin
    write(f2,IntToHex(buf[i + j*revers(head.Num_of_tiks)],2)+' ');
    BlockWrite(f3,buf[i + j*revers(head.Num_of_tiks)],1);
   end
   else
    write(f2,IntToHex(buf[i*16 + j],2)+' ');
  writeln(f2);
 end;
closefile(f2);
closefile(f3);
writeln('Saved as ' + s);
end.