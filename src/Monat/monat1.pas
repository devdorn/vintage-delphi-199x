unit monat1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TMonat = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Image1: TImage;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Button11: TButton;
    memo1: TMemo;
    procedure FormActivate(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Monat: TMonat;

implementation
 uses DataMod1;
{$R *.DFM}

procedure TMonat.FormActivate(Sender: TObject);
begin
shortdateformat := 'dd/mm/yyyy';
end;

procedure TMonat.Button11Click(Sender: TObject);
begin
close;
end;

procedure TMonat.Button1Click(Sender: TObject);
begin
with Datam1.Abtrecd do
begin
   EmptyTable;
end;
datam1.batchmove1.execute;
memo1.lines.add ( ' ABTRECD fertig');
end;

end.
