program Project1;

uses
  Unit1 in 'Unit1.pas';

var s :string;
i, n :Integer;

begin
s := 'Das ist ein Textbildschirm,';
s := s + 'aber trotzdem ein 32-Bit-Delphi-Programm!';
WriteLn(s);
for i:=1 to length(s) do write('-');
writeln;
writeln('geben Sie etwas ein!');
readln(s);
writeln('Wie oft soll es untereinander ausgedruckt werden ?');
readln(n);
for i:=1 to n do writeln (i,#9,s);
writeln('druecken Sie Enter um das Programm zu verlassen!');
readln
end.



