program SMEI_CLI;

uses
  Forms,
  CliMain in 'CliMain.pas' {frmCliMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCliMain, frmCliMain);
  Application.Run;
end.
