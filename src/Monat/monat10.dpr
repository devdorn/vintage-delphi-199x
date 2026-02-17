program monat10;

uses
  Forms,
  monat1 in 'monat1.pas' {Monat},
  DataMod1 in 'DataMod1.pas' {DataM1: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMonat, Monat);
  Application.CreateForm(TDataM1, DataM1);
  Application.Run;
end.
