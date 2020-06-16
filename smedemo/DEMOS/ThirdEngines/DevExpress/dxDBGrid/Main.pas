unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, dxDBTLCl, dxGrClms, dxTL, dxDBCtrl, dxDBGrid,
  dxCntner, DB, DBTables, ExportDS, SMEWiz, StdCtrls, SMEEngine, SMEEngDB,
  SMEEngDX;

type
  TfrmMain = class(TForm)
    srcOrders: TDataSource;
    tblOrders: TTable;
    dxdbgOrders: TdxDBGrid;
    dxdbgOrdersOrderNo: TdxDBGridMaskColumn;
    dxdbgOrdersCustNo: TdxDBGridMaskColumn;
    dxdbgOrdersSaleDate: TdxDBGridDateColumn;
    dxdbgOrdersShipDate: TdxDBGridDateColumn;
    dxdbgOrdersEmpNo: TdxDBGridMaskColumn;
    dxdbgOrdersTerms: TdxDBGridMaskColumn;
    dxdbgOrdersPaymentMethod: TdxDBGridMaskColumn;
    dxdbgOrdersItemsTotal: TdxDBGridCurrencyColumn;
    dxdbgOrdersAmountPaid: TdxDBGridCurrencyColumn;
    btnExport: TButton;
    SMEWizardDlg1: TSMEWizardDlg;
    SMEdxDBGridDataEngine1: TSMEdxDBGridDataEngine;
    procedure FormCreate(Sender: TObject);
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

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  dxdbgOrders.Filter.Active := True;
  dxdbgOrders.FullExpand
end;

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  SMEWizardDlg1.Execute
end;

end.
