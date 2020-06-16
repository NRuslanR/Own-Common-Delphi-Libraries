// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Smestat.pas' rev: 10.00

#ifndef SmestatHPP
#define SmestatHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Appevnts.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smestat
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmSMEProcess;
class PASCALIMPLEMENTATION TfrmSMEProcess : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TProgressBar* ProgressBar;
	Stdctrls::TButton* btnCancel;
	Extctrls::TPanel* Bevel;
	Stdctrls::TLabel* lblStatus;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall btnCancelClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Appevnts::TApplicationEvents* ApplicationEvents1;
	void __fastcall ApplicationEventsActivate(System::TObject* Sender);
	void __fastcall ApplicationEventsDeactivate(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	
public:
	Comctrls::TAnimate* Animate;
	bool CancelPressed;
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TfrmSMEProcess(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmSMEProcess(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmSMEProcess(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TfrmSMEProcess(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Smestat */
using namespace Smestat;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Smestat
