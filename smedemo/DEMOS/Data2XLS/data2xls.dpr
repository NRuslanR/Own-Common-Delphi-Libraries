program data2xls;

uses
  Forms,
  main in 'main.pas' {frmXLSExport};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmXLSExport, frmXLSExport);
  Application.Run;
end.
