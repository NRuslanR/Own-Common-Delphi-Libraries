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
    cbExportColors: TCheckBox;
    rgFileType: TRadioGroup;
    procedure btnExportClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure cbExportColorsClick(Sender: TObject);
    procedure rgFileTypeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  SMEWizardDlg.Execute
end;

procedure TfrmMain.btnAboutClick(Sender: TObject);
begin
  SMEWizardDlg.AboutSME
end;

procedure TfrmMain.cbExportColorsClick(Sender: TObject);
begin
  if cbExportColors.Checked then
    SMEWizardDlg.Options := SMEWizardDlg.Options + [soColorsFonts]
  else
    SMEWizardDlg.Options := SMEWizardDlg.Options - [soColorsFonts]
end;

procedure TfrmMain.rgFileTypeClick(Sender: TObject);
begin
  if rgFileType.ItemIndex = 0 then
    SMEWizardDlg.TableType := teHTML
  else
    SMEWizardDlg.TableType := teExcel
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  SMEWizardDlg.FileName := ExtractFilePath(Application.ExeName) + SMEWizardDlg.FileName
end;

end.
