// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Smemonitor.pas' rev: 10.00

#ifndef SmemonitorHPP
#define SmemonitorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Exportds.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smemonitor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmExportDlg;
class PASCALIMPLEMENTATION TfrmExportDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TRadioGroup* rgTableType;
	Extctrls::TRadioGroup* rgSeparator;
	Stdctrls::TEdit* edSymbol;
	Stdctrls::TCheckBox* cbAddTitle;
	Stdctrls::TLabel* lblCharacterSet;
	Stdctrls::TComboBox* cbCharacterSet;
	Extctrls::TBevel* bvlBtn;
	Stdctrls::TButton* btnOk;
	Stdctrls::TButton* btnCancel;
	Stdctrls::TLabel* lblFileName;
	Stdctrls::TEdit* edFileName;
	Buttons::TSpeedButton* btnOpenDlg;
	Stdctrls::TCheckBox* cbFixed;
	Dialogs::TSaveDialog* SaveDlg;
	Stdctrls::TCheckBox* cbSelectedRecord;
	Stdctrls::TCheckBox* cbBlankIfZero;
	void __fastcall rgTableTypeClick(System::TObject* Sender);
	void __fastcall edFileNameChange(System::TObject* Sender);
	void __fastcall btnOkClick(System::TObject* Sender);
	void __fastcall rgSeparatorClick(System::TObject* Sender);
	void __fastcall btnOpenDlgClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	AnsiString TitleSaveDlg;
	void __fastcall SetDefaultExt(void);
	
public:
	AnsiString strAccessTable;
	AnsiString strFPrompt;
	AnsiString strTName;
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TfrmExportDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmExportDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmExportDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TfrmExportDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool __fastcall SetExportParam(Exportds::TSMExportBaseComponent* sme, AnsiString &FileName, AnsiString &TableName, Exportds::TTableTypeExport &TabType, Exportds::TCharacterSet &csCharacterSet, AnsiString &chSeparator, bool &boolAddTitle, bool &boolFixed, bool &boolBlankIfZero, int &intSelectedRecord, Exportds::TExportFormatTypes Formats);

}	/* namespace Smemonitor */
using namespace Smemonitor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Smemonitor
