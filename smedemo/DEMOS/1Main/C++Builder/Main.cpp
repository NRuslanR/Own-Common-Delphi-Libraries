//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "ExportDS"
#pragma link "SME2BDE"
#pragma link "SME2Cell"
#pragma link "SME2CLP"
#pragma link "SME2DIF"
#pragma link "SME2HTML"
#pragma link "SME2OLE"
#pragma link "SME2SQL"
#pragma link "SME2SYLK"
#pragma link "SME2TXT"
#pragma link "SME2WKS"
#pragma link "SME2WQ"
#pragma link "SME2XLS"
#pragma link "SME2XML"
#pragma link "SMEWiz"
#pragma link "SME2RTF"
#pragma resource "*.dfm"
TfrmSMExportDemo *frmSMExportDemo;
//---------------------------------------------------------------------------
__fastcall TfrmSMExportDemo::TfrmSMExportDemo(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmSMExportDemo::FillAliasList(void)
{
  // fill a list box with alias names for the user to select from
  Session->GetAliasNames(cbAlias->Items);
  cbAlias->ItemIndex = 0;
  cbAliasChange(cbAlias);
}
//---------------------------------------------------------------------------
void __fastcall TfrmSMExportDemo::FillTableList(void)
{
  Session->GetTableNames(tblDemoExport->DatabaseName, "", true, false, lbTables->Items);
  lbTables->ItemIndex = 0;
  lbTablesClick(lbTables);
}
//---------------------------------------------------------------------------
void __fastcall TfrmSMExportDemo::FormCreate(TObject *Sender)
{
  FillAliasList();
}
//---------------------------------------------------------------------------
void __fastcall TfrmSMExportDemo::edDirectoryExit(TObject *Sender)
{
  tblDemoExport->Active = false;
  tblDemoExport->DatabaseName = edDirectory->Text;
  FillTableList();
}
//---------------------------------------------------------------------------
void __fastcall TfrmSMExportDemo::rbAliasClick(TObject *Sender)
{
  cbAlias->Enabled = true;
  edDirectory->Enabled = false;
}
//---------------------------------------------------------------------------
void __fastcall TfrmSMExportDemo::rbDirectoryClick(TObject *Sender)
{
  cbAlias->Enabled = false;
  edDirectory->Enabled = true;
}
//---------------------------------------------------------------------------
void __fastcall TfrmSMExportDemo::lbTablesClick(TObject *Sender)
{
  tblDemoExport->Active = false;
  tblDemoExport->TableName = lbTables->Items->Strings[lbTables->ItemIndex];
  tblDemoExport->Active = true;
}
//---------------------------------------------------------------------------
void __fastcall TfrmSMExportDemo::cbAliasChange(TObject *Sender)
{
  tblDemoExport->Active = false;
  tblDemoExport->DatabaseName = cbAlias->Items->Strings[cbAlias->ItemIndex];
  FillTableList();
}
//---------------------------------------------------------------------------
void __fastcall TfrmSMExportDemo::AmountInRed(TObject *Sender,
  TField *Field, AnsiString &Text, TFont *AFont, TAlignment &Alignment,
  TColor &Background, TCellType &CellType)
{
  if ((Field != NULL) &&
     (Field->FieldName == "AmountPaid") &&
     (Field->AsFloat > 5000))
  {
    Background = clRed;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmSMExportDemo::ExportIt(TSMExportBaseComponent *ExportComponent, Boolean IsFixedText)
{
  if (rbExportFromGrid->Checked == true)
    ExportComponent->ColumnSource = csDBGrid;
  else
    ExportComponent->ColumnSource = csDataSet;
  ExportComponent->AnimatedStatus = cbAnimatedStatus->Checked;
  ExportComponent->SelectedRecord = cbSelectedRecords->Checked;
  ExportComponent->BlankIfZero = cbBlankIfZero->Checked;
  if (cbFieldMask->Checked == true)
    ExportComponent->Options << soFieldMask;
  else
    ExportComponent->Options >> soFieldMask;

  if (cbCustomDrawing->Checked == true)
    ExportComponent->OnGetCellParams = AmountInRed;

  if (CompareStr(ExportComponent->ClassName(), ("TSMEWizardDlg")) == 0)
    static_cast<TSMEWizardDlg*>(ExportComponent)->Execute();
  else
    if (CompareStr(ExportComponent->ClassName(), ("TSMExportMonitor")) == 0)
      static_cast<TSMExportMonitor*>(ExportComponent)->Execute(true);
    else
    {
      if (CompareStr(ExportComponent->ClassName(), ("TSMExportToText")) == 0)
        static_cast<TSMExportToText*>(ExportComponent)->Fixed = IsFixedText;
      ExportComponent->Execute();
    };
}
//---------------------------------------------------------------------------

void __fastcall TfrmSMExportDemo::btnExportClick(TObject *Sender)
{
  switch (rbExportFormat->ItemIndex) {
    case 1: ExportIt(SMExportMonitor, false);
    case 2: ExportIt(SMExportToXLS, false);
    case 3: ExportIt(SMExportToExcel, false);
    case 4: ExportIt(SMExportToWord, false);
    case 5: ExportIt(SMExportToText, true);
    case 6: ExportIt(SMExportToText, false);
    case 7: ExportIt(SMExportToHTML, false);
    case 8: ExportIt(SMExportToSYLK, false);
    case 9: ExportIt(SMExportToDIF, false);
    case 10: ExportIt(SMExportToBDE, false);
    case 11: ExportIt(SMExportToWKS, false);
    case 12: ExportIt(SMExportToQuattro, false);
    case 13: ExportIt(SMExportToSQL, false);
    case 14: ExportIt(SMExportToXML, false);
    case 15: ExportIt(SMExportToAccess, false);
    case 16: ExportIt(SMExportToClipboard, false);
  default:
    ExportIt(SMEWizardDlg, false);
  };
}
//---------------------------------------------------------------------------
void __fastcall TfrmSMExportDemo::rbExportFromGridClick(TObject *Sender)
{
  cbSelectedRecords->Enabled = rbExportFromGrid->Checked;
}
//---------------------------------------------------------------------------
void __fastcall TfrmSMExportDemo::btnAboutClick(TObject *Sender)
{
  AboutSMExport();
}
//---------------------------------------------------------------------------
    