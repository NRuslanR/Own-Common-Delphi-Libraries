// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2pump.pas' rev: 10.00

#ifndef Sme2pumpHPP
#define Sme2pumpHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit
#include <Exportds.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2pump
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TTableChanging)(System::TObject* Sender, const AnsiString TableName, bool &Skip);

typedef void __fastcall (__closure *TTableChanged)(System::TObject* Sender, const AnsiString TableName, bool &Abort);

typedef void __fastcall (__closure *TGetTableNames)(System::TObject* Sender, Classes::TStrings* TableNames);

class DELPHICLASS TSMECustomDataPump;
class PASCALIMPLEMENTATION TSMECustomDataPump : public Exportds::TSMECustomBaseComponent 
{
	typedef Exportds::TSMECustomBaseComponent inherited;
	
private:
	AnsiString FTableMask;
	bool FSystemItems;
	AnsiString FDirectory;
	TTableChanging FOnTableChanging;
	TTableChanged FOnTableChanged;
	TGetTableNames FOnGetTableNames;
	
protected:
	Classes::TStrings* TableNames;
	virtual void __fastcall FillTableNames(void);
	virtual Smeengine::TSMECustomDataEngine* __fastcall CreateDataEngine(const AnsiString TableName);
	
public:
	__fastcall virtual TSMECustomDataPump(Classes::TComponent* AOwner);
	__fastcall virtual ~TSMECustomDataPump(void);
	void __fastcall Execute(void);
	
__published:
	__property AnsiString Directory = {read=FDirectory, write=FDirectory};
	__property AnsiString TableMask = {read=FTableMask, write=FTableMask};
	__property bool SystemItems = {read=FSystemItems, write=FSystemItems, nodefault};
	__property TableType ;
	__property Separator ;
	__property TextQualifier ;
	__property RecordSeparator ;
	__property Fixed ;
	__property AddTitle  = {default=0};
	__property CharacterSet ;
	__property TTableChanging OnTableChanging = {read=FOnTableChanging, write=FOnTableChanging};
	__property TTableChanged OnTableChanged = {read=FOnTableChanged, write=FOnTableChanged};
	__property TGetTableNames OnGetTableNames = {read=FOnGetTableNames, write=FOnGetTableNames};
	__property OnGetCellParams ;
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Sme2pump */
using namespace Sme2pump;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2pump
