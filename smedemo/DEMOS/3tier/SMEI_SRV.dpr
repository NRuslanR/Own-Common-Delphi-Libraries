program SMEI_SRV;

uses
  Forms,
  SrvMain in 'SrvMain.pas' {frmSrvMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSrvMain, frmSrvMain);
  Application.Run;
end.
