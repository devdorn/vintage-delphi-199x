unit DataMod1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db;

type
  TDataM1 = class(TDataModule)
    AbtRects: TDataSource;
    AbtRecT: TTable;
    BatchMove1: TBatchMove;
    AbtRec1ds: TDataSource;
    AbtRecd: TTable;
    AbtRecdVKB: TFloatField;
    AbtRecdJAHR: TFloatField;
    AbtRecdMON: TFloatField;
    AbtRecdANZREC: TFloatField;
    AbtRecdANZGUT: TFloatField;
    AbtRecdANZSTR: TFloatField;
    AbtRecdANZINT: TFloatField;
    AbtRecdZCH: TStringField;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  DataM1: TDataM1;

implementation
 uses monat1;
{$R *.DFM}

end.
