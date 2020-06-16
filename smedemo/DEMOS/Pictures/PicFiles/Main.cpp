//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "ExportDS"
#pragma link "SME2Cell"
#pragma link "SME2OLE"
#pragma link "SMEEngine"
#pragma resource "*.dfm"
TfrmMain *frmMain;
//---------------------------------------------------------------------------
__fastcall TfrmMain::TfrmMain(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::btnExportClick(TObject *Sender)
{
  if (OpenPictureDialog1->Execute()) {
    FFileList->Clear();
    FFileList->AddStrings(OpenPictureDialog1->Files);

    SMExportToWord1->Header->Text = "SMExport suite: http://www.scalabium.com/sme\nPicture exporting\n\n";
    SMExportToWord1->Execute();
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::FormCreate(TObject *Sender)
{
  FFileList = new TStringList;

  SMExportToWord1->FileName = ExtractFilePath(Application->ExeName) + "smexport.doc";
  OpenPictureDialog1->InitialDir = ExtractFilePath(Application->ExeName);
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::FormDestroy(TObject *Sender)
{
  delete FFileList;
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::SMEVirtualDataEngine1Count(TObject *Sender,
      int &Count)
{
  /* we must say how many rows we want to export */
  Count = FFileList->Count;
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::SMEVirtualDataEngine1First(TObject *Sender)
{
  /* here we must initialize some our internal structures.
  For example, we'll initialize the counter */
  CurrentPictureNo = 0;
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::SMEVirtualDataEngine1Next(TObject *Sender,
      bool &Abort)
{
  /* here we must prepare a next "row"
  We'll increase the counter */
  CurrentPictureNo = CurrentPictureNo + 1;

}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::SMEVirtualDataEngine1FillColumns(TObject *Sender)
{
  /* we must define columns which will be exported.
  As alternative you can define a same Columns directly in TSMExportToWord.Columns

  IMPORTANT:
  Must be defined at least one column */

  SMExportToWord1->Columns->Clear();

  /* add first virtual column */
  TSMEColumn* col1 = SMExportToWord1->Columns->Add();
  col1->FieldName = "FileName";
  col1->Title->Caption = "Picture filename";
  col1->DataType = ctString;
  col1->Alignment = taCenter;
  col1->Width = 20;

  /* add second virtual column */
  TSMEColumn* col2 = SMExportToWord1->Columns->Add();
  col2->FieldName = "Graphic";
  col2->Title->Caption = "Picture";
  col2->DataType = ctGraphic;
  col2->Width = 30;
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::SMEVirtualDataEngine1GetValue(TObject *Sender,
      TSMEColumn *Column, Variant &Value)
{
  /* here we must return a value for current row for Column */
  if (Column) {
    if (Column->FieldName == "FileName") {
      Value = ExtractFileName(FFileList->Strings[CurrentPictureNo]);
    }
    else {
      if (Column->FieldName == "Graphic") {
        /* load bitmap to string stream */
        TStringStream* strStream = new TStringStream("");
        TFileStream* fs = new TFileStream(FFileList->Strings[CurrentPictureNo], fmOpenRead + fmShareDenyWrite);
        fs->Seek(0, soFromBeginning);
        strStream->CopyFrom(fs, 0);
        delete fs;

        Value = strStream->DataString;
        delete strStream;
      }
    }
  }
}
//---------------------------------------------------------------------------

