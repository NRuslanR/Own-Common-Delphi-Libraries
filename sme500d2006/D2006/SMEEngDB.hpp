// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Smeengdb.pas' rev: 10.00

#ifndef SmeengdbHPP
#define SmeengdbHPP

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
#include <Dbgrids.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smeengdb
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSMECustomDBDataEngine;
class PASCALIMPLEMENTATION TSMECustomDBDataEngine : public Smeengine::TSMECustomDataEngine 
{
	typedef Smeengine::TSMECustomDataEngine inherited;
	
private:
	void *bkmark;
	int FRecordCount;
	
protected:
	virtual Db::TDataSet* __fastcall GetDataset(void);
	
public:
	virtual void __fastcall EnableControls(void);
	virtual void __fastcall DisableControls(void);
	virtual void __fastcall SavePosition(void);
	virtual void __fastcall RestorePosition(void);
	virtual void __fastcall FillColumns(Smeengine::TSMEColumns* Columns, Smeengine::TSMEColumnBands* Bands, bool RightToLeft);
	virtual bool __fastcall Eof(void);
	virtual void __fastcall First(void);
	virtual void __fastcall Next(void);
	virtual Variant __fastcall GetFieldValue(Smeengine::TSMEColumn* Column);
	virtual int __fastcall RecordCount(void);
	virtual Db::TFieldType __fastcall DataTypeByColumn(Smeengine::TSMEColumn* Column);
	virtual bool __fastcall RequiredByColumn(Smeengine::TSMEColumn* Column);
	virtual bool __fastcall ReadOnlyByColumn(Smeengine::TSMEColumn* Column);
	virtual Db::TField* __fastcall FindFieldByColumn(Smeengine::TSMEColumn* Column);
	__property Db::TDataSet* Dataset = {read=GetDataset};
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TSMECustomDBDataEngine(Classes::TComponent* AOwner) : Smeengine::TSMECustomDataEngine(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TSMECustomDBDataEngine(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSMEDatasetDataEngine;
class PASCALIMPLEMENTATION TSMEDatasetDataEngine : public TSMECustomDBDataEngine 
{
	typedef TSMECustomDBDataEngine inherited;
	
private:
	bool FIsRecProcessed;
	Db::TDataSet* FDataSet;
	void __fastcall SetDataset(Db::TDataSet* Value);
	
protected:
	virtual Db::TDataSet* __fastcall GetDataset(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual ~TSMEDatasetDataEngine(void);
	virtual bool __fastcall SelectedRecordIsSupported(void);
	virtual bool __fastcall Eof(void);
	virtual void __fastcall First(void);
	virtual void __fastcall Next(void);
	virtual int __fastcall RecordCount(void);
	
__published:
	__property Db::TDataSet* Dataset = {read=GetDataset, write=SetDataset};
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TSMEDatasetDataEngine(Classes::TComponent* AOwner) : TSMECustomDBDataEngine(AOwner) { }
	#pragma option pop
	
};


class DELPHICLASS TSMEDBGridDataEngine;
class PASCALIMPLEMENTATION TSMEDBGridDataEngine : public TSMECustomDBDataEngine 
{
	typedef TSMECustomDBDataEngine inherited;
	
private:
	int intCurrentSelectedRow;
	Dbgrids::TCustomDBGrid* FDBGrid;
	Dbgrids::TCustomDBGrid* __fastcall GetDBGrid(void);
	void __fastcall SetDBGrid(Dbgrids::TCustomDBGrid* AValue);
	
protected:
	virtual Db::TDataSet* __fastcall GetDataset(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	virtual bool __fastcall SelectedRecordIsSupported(void);
	virtual void __fastcall FillColumns(Smeengine::TSMEColumns* Columns, Smeengine::TSMEColumnBands* Bands, bool RightToLeft);
	virtual bool __fastcall Eof(void);
	virtual void __fastcall First(void);
	virtual void __fastcall Next(void);
	virtual int __fastcall RecordCount(void);
	
__published:
	__property Dbgrids::TCustomDBGrid* DBGrid = {read=GetDBGrid, write=SetDBGrid};
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TSMEDBGridDataEngine(Classes::TComponent* AOwner) : TSMECustomDBDataEngine(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TSMEDBGridDataEngine(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Smeengdb */
using namespace Smeengdb;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Smeengdb
