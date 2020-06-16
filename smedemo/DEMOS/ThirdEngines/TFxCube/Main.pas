unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, FxGrid, FxDB, FxCommon, FxStore, StdCtrls,
  SMEEngine, SMEEngFxDC, ExportDS, SMEWiz;

type
  TfrmMain = class(TForm)
    FxCube1: TFxCube;
    FxSource1: TFxSource;
    FxGrid1: TFxGrid;
    tblTable1: TTable;
    SMEWizardDlg1: TSMEWizardDlg;
    SMEFxCubeDataEngine1: TSMEFxCubeDataEngine;
    btnExport: TButton;
    procedure btnExportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  SMEWizardDlg1.Execute
end;

end.
