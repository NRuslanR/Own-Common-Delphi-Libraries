// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2pumpbde.pas' rev: 10.00

#ifndef Sme2pumpbdeHPP
#define Sme2pumpbdeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sme2pump.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit
#include <Smeengdb.hpp>	// Pascal unit
#include <Exportds.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2pumpbde
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSMEDataPumpFromBDE;
class PASCALIMPLEMENTATION TSMEDataPumpFromBDE : public Sme2pump::TSMECustomDataPump 
{
	typedef Sme2pump::TSMECustomDataPump inherited;
	
private:
	AnsiString FDatabaseName;
	Smeengdb::TSMEDatasetDataEngine* FDataEngine;
	
protected:
	virtual void __fastcall FillTableNames(void);
	virtual Smeengine::TSMECustomDataEngine* __fastcall CreateDataEngine(const AnsiString TableName);
	
public:
	__fastcall virtual ~TSMEDataPumpFromBDE(void);
	
__published:
	__property AnsiString DatabaseName = {read=FDatabaseName, write=FDatabaseName};
public:
	#pragma option push -w-inl
	/* TSMECustomDataPump.Create */ inline __fastcall virtual TSMEDataPumpFromBDE(Classes::TComponent* AOwner) : Sme2pump::TSMECustomDataPump(AOwner) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Sme2pumpbde */
using namespace Sme2pumpbde;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2pumpbde
