unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    ComboBox1: TComboBox;
    Panel: TStatusBar;
    procedure edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.edit1KeyPress(Sender: TObject; var Key: Char);
begin
if key =',' then key:='.'
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
close
end;

procedure TForm1.Edit1Change(Sender: TObject);
var n : double;
code : integer;

begin
val(edit1.text,n,code);
if code = 0 then panel.simpletext :=format(combobox1.text,[n])
else panel.simpletext :='Fehler'
end;

end.
