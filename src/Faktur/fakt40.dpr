program fakt40;

uses
  Forms,
  fakt04 in 'fakt04.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
