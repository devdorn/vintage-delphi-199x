unit fakt04;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen}
  public
    { Public-Deklarationen}
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
{$APPTYPE CONSOLE}




var
  InFile, OutFile: TextFile;
  InString: string;
  s, a, ss: string;


begin
  button1.enabled := false;
  s := '';
  SS := '';
  a := '';

  AssignFile(InFile, 'c:\rchfrd.txt');
  reset(InFile);
  try
    AssignFile(OutFile, 'c:\rchfrd1.txt');
    rewrite(OutFile);
    try
      while not eof(InFile) do
        begin
          readln(InFile, InString);
          s := instring;

          if Pos('R E C H N U N G', ss) > 0 then
            begin
              readln(infile, instring);
              s := instring;
            end;
          if Pos('G U T S C H R I F T', ss) > 0 then
            begin
              readln(infile, instring);
              s := instring;
            end;
          if Pos('MUSTERSENDUNG', ss) > 0 then
            begin
              readln(infile, instring);
              s := instring;
            end;
          if Pos('@', instring) > 0 then
            begin
              move(a, instring, sizeof(instring));
              s := instring;
            end;

          if Pos('   DM  :', ss) > 0 then
            begin
              readln(infile, instring);
              s := instring;
            end;




          if ss <= instring then
            writeln(OutFile, s);
          ss := s;



        end;
    finally
      CloseFile(OutFile);
      button1.enabled := true;
    end;
  finally
    CloseFile(InFile);
  end;
end;




procedure TForm1.Button2Click(Sender: TObject);
begin
  close;
end;

end.

