program sg2csv;

uses
  Forms,
  Main in 'Main.pas' {frmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'SMExport: StringGrid to CSV';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
