unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, StdCtrls, dxTLClms, dxTL, dxCntner, SMEEngine,
  SMEEngDX, ExportDS, SMEWiz;

type
  TfrmMain = class(TForm)
    smeWizard: TSMEWizardDlg;
    SMEdxTreeListDataEngine1: TSMEdxTreeListDataEngine;
    dxtData: TdxTreeList;
    dxtlcDxTreeList1Column1: TdxTreeListColumn;
    dxtlcDxTreeList1Column2: TdxTreeListColumn;
    dxTreeList1Column3: TdxTreeListCalcColumn;
    dxTreeList1Column4: TdxTreeListDateColumn;
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
  smeWizard.Execute
end;

end.
