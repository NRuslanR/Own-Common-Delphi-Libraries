unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, Grids, DBGrids, ExtCtrls, DBCtrls, ExportDS,
  SME2BDE, SME2OLE, SMEWiz, SME2XLS, SME2DIF, SME2SYLK, SME2XML, SME2SQL,
  SME2WQ, SME2WKS, SME2CLP, SME2Cell, SME2HTML, SME2TXT, SME2RTF, SMEEngine;

type
  TfrmSMExportDemo = class(TForm)
    pnlLeft: TPanel;
    dSrcDemoExport: TDataSource;
    tblDemoExport: TTable;
    rbAlias: TRadioButton;
    rbDirectory: TRadioButton;
    cbAlias: TComboBox;
    edDirectory: TEdit;
    lbTables: TListBox;
    SMExportMonitor: TSMExportMonitor;
    SMEWizardDlg: TSMEWizardDlg;
    SMExportToExcel: TSMExportToExcel;
    SMExportToWord: TSMExportToWord;
    SMExportToText: TSMExportToText;
    SMExportToHTML: TSMExportToHTML;
    SMExportToBDE: TSMExportToBDE;
    SMExportToXLS: TSMExportToXLS;
    SMExportToSYLK: TSMExportToSYLK;
    SMExportToDIF: TSMExportToDIF;
    SMExportToWKS: TSMExportToWKS;
    SMExportToQuattro: TSMExportToQuattro;
    SMExportToSQL: TSMExportToSQL;
    SMExportToXML: TSMExportToXML;
    SMExportToAccess: TSMExportToAccess;
    SMExportToClipboard: TSMExportToClipboard;
    pnlGrid: TPanel;
    DBNavigator: TDBNavigator;
    DBGrid: TDBGrid;
    gbExport: TGroupBox;
    btnExport: TButton;
    rbExportFromGrid: TRadioButton;
    cbExportFromDataset: TRadioButton;
    rbExportFormat: TRadioGroup;
    cbAnimatedStatus: TCheckBox;
    cbBlankIfZero: TCheckBox;
    cbSelectedRecords: TCheckBox;
    cbFieldMask: TCheckBox;
    bvl: TBevel;
    cbCustomDrawing: TCheckBox;
    lblCustomDrawing: TLabel;
    btnAbout: TButton;
    SMExportToRTF: TSMExportToRTF;
    cbMerge: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure edDirectoryExit(Sender: TObject);
    procedure rbAliasClick(Sender: TObject);
    procedure rbDirectoryClick(Sender: TObject);
    procedure lbTablesClick(Sender: TObject);
    procedure cbAliasChange(Sender: TObject);
    procedure btnExportDSClick(Sender: TObject);
    procedure rbExportFromGridClick(Sender: TObject);
    procedure AmountInRed(Sender: TObject;
                          Field: TField; var Text: String; AFont: TFont; var Alignment: TAlignment;
                          var Background: TColor; var CellType: TCellType);
    procedure btnAboutClick(Sender: TObject);
  private
    { Private declarations }
    procedure FillAliasList;
    procedure FillTableList;
  public
    { Public declarations }
  end;

var
  frmSMExportDemo: TfrmSMExportDemo;

implementation

{$R *.DFM}
{$R winxp.res}

procedure TfrmSMExportDemo.FillAliasList;
begin
  { fill a list box with alias names for the user to select from }
  Session.GetAliasNames(cbAlias.Items);
  cbAlias.ItemIndex := 0;
  cbAliasChange(cbAlias);
end;

procedure TfrmSMExportDemo.FillTableList;
var
  i: Integer;
begin
  Session.GetTableNames(tblDemoExport.DatabaseName, '', True, False, lbTables.Items);

  i := lbTables.Items.IndexOf('INDUSTRY.DBF');
  if (i < 0) then
    i := 0;
  lbTables.ItemIndex := i;
  lbTablesClick(lbTables);
end;

procedure TfrmSMExportDemo.FormCreate(Sender: TObject);
begin
  FillAliasList;
end;

procedure TfrmSMExportDemo.edDirectoryExit(Sender: TObject);
begin
  tblDemoExport.Active := False;
  tblDemoExport.DatabaseName := edDirectory.Text;
  FillTableList;
end;

procedure TfrmSMExportDemo.rbAliasClick(Sender: TObject);
begin
  cbAlias.Enabled := True;
  edDirectory.Enabled := False;
end;

procedure TfrmSMExportDemo.rbDirectoryClick(Sender: TObject);
begin
  cbAlias.Enabled := False;
  edDirectory.Enabled := True;
end;

procedure TfrmSMExportDemo.lbTablesClick(Sender: TObject);
begin
  with tblDemoExport do
  begin
    Active := False;
    TableName := lbTables.Items[lbTables.ItemIndex];
    Active := True;
  end;
end;

procedure TfrmSMExportDemo.cbAliasChange(Sender: TObject);
begin
  tblDemoExport.Active := False;
  tblDemoExport.DatabaseName := cbAlias.Items[cbAlias.ItemIndex];
  FillTableList;
end;

procedure TfrmSMExportDemo.AmountInRed(Sender: TObject;
  Field: TField; var Text: String; AFont: TFont; var Alignment: TAlignment;
  var Background: TColor; var CellType: TCellType);
begin
  if Assigned(Field) and
     (Field.FieldName = 'AmountPaid') and
     (Field.AsFloat > 5000) then
    Background := clRed 
end;

procedure TfrmSMExportDemo.btnExportDSClick(Sender: TObject);

  procedure ExportIt(ExportComponent: TSMExportBaseComponent; IsFixedText: Boolean);
  begin
    if rbExportFromGrid.Checked then
      ExportComponent.ColumnSource := csDBGrid
    else
      ExportComponent.ColumnSource := csDataSet;
    ExportComponent.AnimatedStatus := cbAnimatedStatus.Checked;
    ExportComponent.SelectedRecord := cbSelectedRecords.Checked;
    ExportComponent.BlankIfZero := cbBlankIfZero.Checked;
    if cbFieldMask.Checked then
      ExportComponent.Options := ExportComponent.Options + [soFieldMask]
    else
      ExportComponent.Options := ExportComponent.Options - [soFieldMask];
    if cbMerge.Checked then
      ExportComponent.Options := ExportComponent.Options + [soMergeData]
    else
      ExportComponent.Options := ExportComponent.Options - [soMergeData];

    if cbCustomDrawing.Checked then
      ExportComponent.OnGetCellParams := AmountInRed;

    if ExportComponent is TSMEWizardDlg then
      TSMEWizardDlg(ExportComponent).Execute
    else
      if ExportComponent is TSMExportMonitor then
        TSMExportMonitor(ExportComponent).Execute(True)
      else
      begin
        if (ExportComponent is TSMExportToText) then
          TSMExportToText(ExportComponent).Fixed := IsFixedText;
        ExportComponent.Execute;
      end;
  end;

begin
  case rbExportFormat.ItemIndex of
    1: ExportIt(SMExportMonitor, False);
    2: ExportIt(SMExportToXLS, False);
    3: ExportIt(SMExportToExcel, False);
    4: ExportIt(SMExportToWord, False);
    5: ExportIt(SMExportToText, True);
    6: ExportIt(SMExportToText, False);
    7: ExportIt(SMExportToHtml, False);
    8: ExportIt(SMExportToSYLK, False);
    9: ExportIt(SMExportToDIF, False);
   10: ExportIt(SMExportToBDE, False);
   11: ExportIt(SMExportToWKS, False);
   12: ExportIt(SMExportToQuattro, False);
   13: ExportIt(SMExportToSQL, False);
   14: ExportIt(SMExportToXML, False);
   15: ExportIt(SMExportToAccess, False);
   16: ExportIt(SMExportToClipboard, False);
   17: ExportIt(SMExportToRTF, False);
  else
    ExportIt(SMEWizardDlg, False);
  end;
end;

procedure TfrmSMExportDemo.rbExportFromGridClick(Sender: TObject);
begin
  cbSelectedRecords.Enabled := rbExportFromGrid.Checked
end;

procedure TfrmSMExportDemo.btnAboutClick(Sender: TObject);
begin
  AboutSMExport
end;

end.
