program sg2xls;

uses
  Forms,
  Main in 'Main.pas' {frmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'SMExport: StringGrid to XLS';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
