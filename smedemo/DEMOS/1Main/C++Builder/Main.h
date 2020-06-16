//---------------------------------------------------------------------------
#ifndef MainH
#define MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "ExportDS.hpp"
#include "SME2BDE.hpp"
#include "SME2Cell.hpp"
#include "SME2CLP.hpp"
#include "SME2DIF.hpp"
#include "SME2HTML.hpp"
#include "SME2OLE.hpp"
#include "SME2SQL.hpp"
#include "SME2SYLK.hpp"
#include "SME2TXT.hpp"
#include "SME2WKS.hpp"
#include "SME2WQ.hpp"
#include "SME2XLS.hpp"
#include "SME2XML.hpp"
#include "SMEWiz.hpp"
#include <Db.hpp>
#include <DBCtrls.hpp>
#include <DBGrids.hpp>
#include <DBTables.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include "SME2RTF.hpp"
#include <Graphics.hpp>
//---------------------------------------------------------------------------
class TfrmSMExportDemo : public TForm
{
__published:	// IDE-managed Components
        TPanel *pnlLeft;
        TRadioButton *rbAlias;
        TRadioButton *rbDirectory;
        TComboBox *cbAlias;
        TEdit *edDirectory;
        TListBox *lbTables;
        TPanel *pnlGrid;
        TDBNavigator *DBNavigator;
        TDBGrid *DBGrid;
        TGroupBox *gbExport;
        TBevel *bvl;
        TLabel *lblCustomDrawing;
        TButton *btnExport;
        TRadioButton *rbExportFromGrid;
        TRadioButton *cbExportFromDataset;
        TRadioGroup *rbExportFormat;
        TCheckBox *cbAnimatedStatus;
        TCheckBox *cbBlankIfZero;
        TCheckBox *cbSelectedRecords;
        TCheckBox *cbFieldMask;
        TCheckBox *cbCustomDrawing;
        TButton *btnAbout;
        TDataSource *dSrcDemoExport;
        TTable *tblDemoExport;
        TSMExportMonitor *SMExportMonitor;
        TSMEWizardDlg *SMEWizardDlg;
        TSMExportToExcel *SMExportToExcel;
        TSMExportToWord *SMExportToWord;
        TSMExportToText *SMExportToText;
        TSMExportToHTML *SMExportToHTML;
        TSMExportToBDE *SMExportToBDE;
        TSMExportToXLS *SMExportToXLS;
        TSMExportToSYLK *SMExportToSYLK;
        TSMExportToDIF *SMExportToDIF;
        TSMExportToWKS *SMExportToWKS;
        TSMExportToQuattro *SMExportToQuattro;
        TSMExportToSQL *SMExportToSQL;
        TSMExportToXML *SMExportToXML;
        TSMExportToAccess *SMExportToAccess;
        TSMExportToClipboard *SMExportToClipboard;
        TSMExportToRTF *SMExportToRTF;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall edDirectoryExit(TObject *Sender);
        void __fastcall rbAliasClick(TObject *Sender);
        void __fastcall rbDirectoryClick(TObject *Sender);
        void __fastcall lbTablesClick(TObject *Sender);
        void __fastcall cbAliasChange(TObject *Sender);
        void __fastcall btnExportClick(TObject *Sender);
        void __fastcall rbExportFromGridClick(TObject *Sender);
        void __fastcall btnAboutClick(TObject *Sender);
private:	// User declarations
        void __fastcall FillAliasList(void);
        void __fastcall FillTableList(void);
        void __fastcall AmountInRed(TObject *Sender,
                        TField *Field, AnsiString &Text, TFont *AFont, TAlignment &Alignment,
                        TColor &Background, TCellType &CellType);
        void __fastcall ExportIt(TSMExportBaseComponent *ExportComponent, Boolean IsFixedText);
public:		// User declarations
        __fastcall TfrmSMExportDemo(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmSMExportDemo *frmSMExportDemo;
//---------------------------------------------------------------------------
#endif
    