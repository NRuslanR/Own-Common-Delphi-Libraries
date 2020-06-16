program DeciDemo;

uses
  Forms,
  Main in 'Main.pas' {frmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'SMExport''s TSMEDecisionGridDataEngine component example';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
