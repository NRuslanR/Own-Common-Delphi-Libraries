// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2bde.pas' rev: 10.00

#ifndef Sme2bdeHPP
#define Sme2bdeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Exportds.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit
#include <Sme2sql.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2bde
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSMExportToBDE;
class PASCALIMPLEMENTATION TSMExportToBDE : public Exportds::TSMExportBaseComponent 
{
	typedef Exportds::TSMExportBaseComponent inherited;
	
protected:
	virtual void __fastcall Prepare(void);
	
public:
	virtual AnsiString __fastcall Extension();
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property ActionAfterExport  = {default=0};
	__property FileName ;
	__property CharacterSet ;
public:
	#pragma option push -w-inl
	/* TSMExportBaseComponent.Create */ inline __fastcall virtual TSMExportToBDE(Classes::TComponent* AOwner) : Exportds::TSMExportBaseComponent(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSMExportBaseComponent.Destroy */ inline __fastcall virtual ~TSMExportToBDE(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSMExportMonitor;
class PASCALIMPLEMENTATION TSMExportMonitor : public Exportds::TSMExportBaseComponent 
{
	typedef Exportds::TSMExportBaseComponent inherited;
	
private:
	Exportds::TExportFormatTypes FFormats;
	AnsiString FFilterName;
	Sme2sql::TSMESQLOptions* FSQLOptions;
	Sme2sql::TSMESQLOptions* __fastcall GetSQLOptions(void);
	void __fastcall SetSQLOptions(Sme2sql::TSMESQLOptions* Value);
	
public:
	__fastcall virtual TSMExportMonitor(Classes::TComponent* AOwner);
	__fastcall virtual ~TSMExportMonitor(void);
	virtual void __fastcall LoadSpecificationFromStrings(Classes::TStrings* lstSpec);
	virtual void __fastcall SaveSpecificationToStream(Classes::TStream* Stream, const AnsiString SpecName);
	void __fastcall ExportDataSet(void);
	void __fastcall ExportToDBF(void);
	void __fastcall ExportToText(void);
	void __fastcall ExportToExcel(void);
	void __fastcall ExportToWord(void);
	void __fastcall ExportToCellFile(void);
	void __fastcall ExportToAccess(void);
	void __fastcall ExportToADO(void);
	void __fastcall ExportToOpenOffice(void);
	HIDESBASE void __fastcall Execute(bool withSetParam);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property AnsiString FilterName = {read=FFilterName, write=FFilterName};
	__property Exportds::TExportFormatTypes Formats = {read=FFormats, write=FFormats, nodefault};
	__property Sme2sql::TSMESQLOptions* SQLOptions = {read=GetSQLOptions, write=SetSQLOptions};
	__property TextQualifier ;
	__property Separator ;
	__property RecordSeparator ;
	__property AutoFitColumns  = {default=0};
	__property Fixed ;
	__property TableName ;
	__property TableType ;
	__property ActionAfterExport  = {default=0};
	__property FileName ;
	__property RowsPerFile  = {default=0};
	__property Layout  = {default=0};
	__property AddTitle  = {default=0};
	__property CharacterSet ;
	__property ExportStyle ;
	__property Header ;
	__property Footer ;
	__property OnGetCellParams ;
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Exportds::TExportFormatTypes __fastcall GetAvailableExportFormats(void);

}	/* namespace Sme2bde */
using namespace Sme2bde;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2bde
