// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2ds.pas' rev: 10.00

#ifndef Sme2dsHPP
#define Sme2dsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Exportds.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2ds
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TSMExportMode { emAppend, emCopy };
#pragma option pop

typedef void __fastcall (__closure *TErrorEvent)(System::TObject* Sender, Sysutils::Exception* Error, bool &Abort);

class DELPHICLASS TSMExportToDataset;
class PASCALIMPLEMENTATION TSMExportToDataset : public Exportds::TSMExportBaseComponent 
{
	typedef Exportds::TSMExportBaseComponent inherited;
	
private:
	Classes::TStrings* FMappings;
	TSMExportMode FMode;
	Db::TDataSet* FDestination;
	TErrorEvent FOnErrorEvent;
	void __fastcall SetMappings(Classes::TStrings* AValue);
	
protected:
	virtual void __fastcall Prepare(void);
	
public:
	__fastcall virtual TSMExportToDataset(Classes::TComponent* AOwner);
	__fastcall virtual ~TSMExportToDataset(void);
	
__published:
	__property Db::TDataSet* Destination = {read=FDestination, write=FDestination};
	__property Classes::TStrings* Mappings = {read=FMappings, write=SetMappings};
	__property TSMExportMode Mode = {read=FMode, write=FMode, default=0};
	__property CharacterSet ;
	__property TErrorEvent OnErrorEvent = {read=FOnErrorEvent, write=FOnErrorEvent};
	__property OnGetCellParams ;
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Sme2ds */
using namespace Sme2ds;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2ds
