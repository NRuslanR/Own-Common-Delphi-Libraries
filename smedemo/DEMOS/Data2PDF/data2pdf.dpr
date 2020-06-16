program data2pdf;

uses
  Forms,
  main in 'main.pas' {frmPDFExport};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPDFExport, frmPDFExport);
  Application.Run;
end.
