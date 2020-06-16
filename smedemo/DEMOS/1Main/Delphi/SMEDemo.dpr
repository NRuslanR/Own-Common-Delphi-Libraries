program SMEDemo;

uses
  Forms,
  Main in 'Main.pas' {frmSMExportDemo};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'SMExport 4.40: Demo application';
  Application.CreateForm(TfrmSMExportDemo, frmSMExportDemo);
  Application.Run;
end.
