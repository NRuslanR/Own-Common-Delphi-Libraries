program xlsexport;

uses
  Forms,
  ptest in 'ptest.pas' {frmExportTest};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmExportTest, frmExportTest);
  Application.Run;
end.
