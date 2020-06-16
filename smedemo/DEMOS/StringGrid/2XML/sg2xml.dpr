program sg2xml;

uses
  Forms,
  Main in 'Main.pas' {frmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'SMExport: StringGrid to XML';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
