program db2mdb;

uses
  Forms,
  Main in 'Main.pas' {gtmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TgtmMain, gtmMain);
  Application.Run;
end.
