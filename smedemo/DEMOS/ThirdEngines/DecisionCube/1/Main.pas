unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ToolWin, StdCtrls,
  mxstore, mxDB, Db, DBTables, mxtables, Grids, mxgrid, ExtCtrls,
  SMEEngine, SMEEngDC, ExportDS, SMEWiz;

type
  TfrmMain = class(TForm)
    ImageList: TImageList;
    DecisionGrid: TDecisionGrid;
    DecisionQuery: TDecisionQuery;
    DecisionSource: TDecisionSource;
    DecisionCube: TDecisionCube;
    pnlToolbar: TPanel;
    btnAbout: TButton;
    btnExport: TButton;
    SMEWizardDlg: TSMEWizardDlg;
    SMEDecisionGridDataEngine: TSMEDecisionGridDataEngine;
    procedure btnExportClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  SMEWizardDlg.Execute()
end;

procedure TfrmMain.btnAboutClick(Sender: TObject);
begin
  SMEWizardDlg.AboutSME
end;

end.
