// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Smespecs.pas' rev: 10.00

#ifndef SmespecsHPP
#define SmespecsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smespecs
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmSMESpecs;
class PASCALIMPLEMENTATION TfrmSMESpecs : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TLabel* lblPrompt;
	Stdctrls::TListBox* lbSpecs;
	Stdctrls::TButton* btnClose;
	Stdctrls::TButton* btnLoad;
	Stdctrls::TButton* btnSave;
	Stdctrls::TButton* btnDelete;
	Extctrls::TImage* imgLogo;
	void __fastcall btnDeleteClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall lbSpecsClick(System::TObject* Sender);
	void __fastcall lbSpecsDblClick(System::TObject* Sender);
	
private:
	void __fastcall lbSpecsDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TfrmSMESpecs(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmSMESpecs(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmSMESpecs(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TfrmSMESpecs(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TSMESpecificationFile;
class PASCALIMPLEMENTATION TSMESpecificationFile : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	AnsiString FileName;
	AnsiString Caption;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TSMESpecificationFile(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TSMESpecificationFile(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfrmSMESpecs* frmSMESpecs;

}	/* namespace Smespecs */
using namespace Smespecs;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Smespecs
