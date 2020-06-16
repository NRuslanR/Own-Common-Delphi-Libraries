//---------------------------------------------------------------------------

#ifndef MainH
#define MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include <ExtDlgs.hpp>
#include "ExportDS.hpp"
#include "SME2Cell.hpp"
#include "SME2OLE.hpp"
#include "SMEEngine.hpp"
//---------------------------------------------------------------------------
class TfrmMain : public TForm
{
__published:	// IDE-managed Components
        TPanel *pnlAction;
        TLabel *lblURL;
        TButton *btnExport;
        TOpenPictureDialog *OpenPictureDialog1;
        TSMExportToWord *SMExportToWord1;
        TSMEVirtualDataEngine *SMEVirtualDataEngine1;
        void __fastcall btnExportClick(TObject *Sender);
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall SMEVirtualDataEngine1Count(TObject *Sender,
          int &Count);
        void __fastcall SMEVirtualDataEngine1First(TObject *Sender);
        void __fastcall SMEVirtualDataEngine1Next(TObject *Sender,
          bool &Abort);
        void __fastcall SMEVirtualDataEngine1FillColumns(TObject *Sender);
        void __fastcall SMEVirtualDataEngine1GetValue(TObject *Sender,
          TSMEColumn *Column, Variant &Value);
private:	// User declarations
        TStrings* FFileList;
        int CurrentPictureNo;
public:		// User declarations
        __fastcall TfrmMain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMain *frmMain;
//---------------------------------------------------------------------------
#endif
