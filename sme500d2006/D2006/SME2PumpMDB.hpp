// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2pumpmdb.pas' rev: 10.00

#ifndef Sme2pumpmdbHPP
#define Sme2pumpmdbHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Sme2pump.hpp>	// Pascal unit
#include <Exportds.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2pumpmdb
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSMEDataPumpFromAccess;
class PASCALIMPLEMENTATION TSMEDataPumpFromAccess : public Sme2pump::TSMECustomDataPump 
{
	typedef Sme2pump::TSMECustomDataPump inherited;
	
private:
	AnsiString FDatabaseName;
	
protected:
	virtual void __fastcall FillTableNames(void);
	
__published:
	__property AnsiString DatabaseName = {read=FDatabaseName, write=FDatabaseName};
public:
	#pragma option push -w-inl
	/* TSMECustomDataPump.Create */ inline __fastcall virtual TSMEDataPumpFromAccess(Classes::TComponent* AOwner) : Sme2pump::TSMECustomDataPump(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSMECustomDataPump.Destroy */ inline __fastcall virtual ~TSMEDataPumpFromAccess(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Sme2pumpmdb */
using namespace Sme2pumpmdb;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2pumpmdb
