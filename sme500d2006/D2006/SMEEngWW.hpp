// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Smeengww.pas' rev: 10.00

#ifndef SmeengwwHPP
#define SmeengwwHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit
#include <Smeengdb.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smeengww
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSMEwwDBGridDataEngine;
class PASCALIMPLEMENTATION TSMEwwDBGridDataEngine : public Smeengdb::TSMECustomDBDataEngine 
{
	typedef Smeengdb::TSMECustomDBDataEngine inherited;
	
private:
	int intCurrentRow;
	Controls::TControl* FDBGrid;
	bool FExportFooters;
	Controls::TControl* __fastcall GetDBGrid(void);
	void __fastcall SetDBGrid(Controls::TControl* AValue);
	
protected:
	virtual Db::TDataSet* __fastcall GetDataset(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	virtual bool __fastcall SelectedRecordIsSupported(void);
	virtual void __fastcall FillColumns(Smeengine::TSMEColumns* Columns, Smeengine::TSMEColumnBands* Bands, bool RightToLeft);
	virtual bool __fastcall IsDataRow(int Index);
	virtual bool __fastcall Eof(void);
	virtual void __fastcall First(void);
	virtual void __fastcall Next(void);
	virtual int __fastcall RecordCount(void);
	virtual Variant __fastcall GetFieldValue(Smeengine::TSMEColumn* Column);
	
__published:
	__property Controls::TControl* DBGrid = {read=GetDBGrid, write=SetDBGrid};
	__property bool ExportFooters = {read=FExportFooters, write=FExportFooters, default=0};
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TSMEwwDBGridDataEngine(Classes::TComponent* AOwner) : Smeengdb::TSMECustomDBDataEngine(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TSMEwwDBGridDataEngine(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSMEDBAdvStringGridDataEngine;
class PASCALIMPLEMENTATION TSMEDBAdvStringGridDataEngine : public Smeengdb::TSMECustomDBDataEngine 
{
	typedef Smeengdb::TSMECustomDBDataEngine inherited;
	
private:
	Controls::TControl* FDBGrid;
	Controls::TControl* __fastcall GetDBGrid(void);
	void __fastcall SetDBGrid(Controls::TControl* AValue);
	
protected:
	virtual Db::TDataSet* __fastcall GetDataset(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	virtual void __fastcall FillColumns(Smeengine::TSMEColumns* Columns, Smeengine::TSMEColumnBands* Bands, bool RightToLeft);
	
__published:
	__property Controls::TControl* DBGrid = {read=GetDBGrid, write=SetDBGrid};
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TSMEDBAdvStringGridDataEngine(Classes::TComponent* AOwner) : Smeengdb::TSMECustomDBDataEngine(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TSMEDBAdvStringGridDataEngine(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Db::TDataSet* __fastcall GetPropAsDataSet(Classes::TComponent* comp);
extern PACKAGE bool __fastcall PropIsDBGrid(Classes::TComponent* comp, bool &IsWWDBGrid, bool &IsTMSDBGrid);
extern PACKAGE Classes::TStrings* __fastcall GetPropAsSelected(Classes::TComponent* comp);
extern PACKAGE Classes::TCollection* __fastcall GetPropAsColumns(Classes::TComponent* comp);
extern PACKAGE void __fastcall FillGridList(Classes::TComponent* comp, Classes::TStrings* lst);

}	/* namespace Smeengww */
using namespace Smeengww;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Smeengww
