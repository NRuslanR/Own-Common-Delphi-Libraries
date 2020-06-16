// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2ado.pas' rev: 10.00

#ifndef Sme2adoHPP
#define Sme2adoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Exportds.hpp>	// Pascal unit
#include <Sme2ole.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2ado
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSMExportToADO;
class PASCALIMPLEMENTATION TSMExportToADO : public Sme2ole::TSMExportToADODOA 
{
	typedef Sme2ole::TSMExportToADODOA inherited;
	
protected:
	virtual void __fastcall InitializeConnection(void);
	virtual void __fastcall FinilizeConnection(void);
	virtual void __fastcall OpenDatabase(AnsiString Value);
	virtual bool __fastcall TableExists(const AnsiString Value);
	virtual void __fastcall DeleteTable(const AnsiString Value);
	virtual void __fastcall CreateNewTable(void);
	void __fastcall CreateNewTable1(void);
	virtual void __fastcall OpenRecordset(void);
	virtual void __fastcall AddNewRecord(void);
	virtual void __fastcall UpdateField(int ACol, Db::TField* fld, const Variant &Value);
	virtual void __fastcall PostRecord(void);
	
public:
	Variant connection;
	Variant recordset;
	__fastcall virtual TSMExportToADO(Classes::TComponent* AOwner);
	virtual AnsiString __fastcall Extension();
public:
	#pragma option push -w-inl
	/* TSMExportBaseComponent.Destroy */ inline __fastcall virtual ~TSMExportToADO(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE WideString __fastcall PromptDataSource(unsigned ParentHandle, WideString InitialString);
extern PACKAGE void __fastcall GetADOTableNames(Classes::TStrings* lst, const AnsiString ConnectionString, bool SystemTables);
extern PACKAGE void __fastcall GetADOTableFields(Classes::TStrings* lst, const AnsiString ConnectionString, const AnsiString TableName);

}	/* namespace Sme2ado */
using namespace Sme2ado;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2ado
