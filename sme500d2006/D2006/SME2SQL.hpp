// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2sql.pas' rev: 10.00

#ifndef Sme2sqlHPP
#define Sme2sqlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Sme2cell.hpp>	// Pascal unit
#include <Exportds.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2sql
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSMESQLTypes;
class PASCALIMPLEMENTATION TSMESQLTypes : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FftString;
	AnsiString FftSmallint;
	AnsiString FftInteger;
	AnsiString FftWord;
	AnsiString FftBoolean;
	AnsiString FftFloat;
	AnsiString FftCurrency;
	AnsiString FftBCD;
	AnsiString FftDate;
	AnsiString FftTime;
	AnsiString FftDateTime;
	AnsiString FftAutoInc;
	AnsiString FftBlob;
	AnsiString FftMemo;
	AnsiString FftGraphic;
	AnsiString FftLargeint;
	bool FCheckRequired;
	bool FAddPrimaryKey;
	
public:
	__fastcall virtual TSMESQLTypes(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property AnsiString ftString = {read=FftString, write=FftString};
	__property AnsiString ftSmallint = {read=FftSmallint, write=FftSmallint};
	__property AnsiString ftInteger = {read=FftInteger, write=FftInteger};
	__property AnsiString ftWord = {read=FftWord, write=FftWord};
	__property AnsiString ftBoolean = {read=FftBoolean, write=FftBoolean};
	__property AnsiString ftFloat = {read=FftFloat, write=FftFloat};
	__property AnsiString ftCurrency = {read=FftCurrency, write=FftCurrency};
	__property AnsiString ftBCD = {read=FftBCD, write=FftBCD};
	__property AnsiString ftDate = {read=FftDate, write=FftDate};
	__property AnsiString ftTime = {read=FftTime, write=FftTime};
	__property AnsiString ftDateTime = {read=FftDateTime, write=FftDateTime};
	__property AnsiString ftAutoInc = {read=FftAutoInc, write=FftAutoInc};
	__property AnsiString ftBlob = {read=FftBlob, write=FftBlob};
	__property AnsiString ftMemo = {read=FftMemo, write=FftMemo};
	__property AnsiString ftGraphic = {read=FftGraphic, write=FftGraphic};
	__property AnsiString ftLargeint = {read=FftLargeint, write=FftLargeint};
	__property bool CheckRequired = {read=FCheckRequired, write=FCheckRequired, default=1};
	__property bool AddPrimaryKey = {read=FAddPrimaryKey, write=FAddPrimaryKey, default=0};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSMESQLTypes(void) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TGetCreateTable)(System::TObject* Sender, AnsiString &SQL, AnsiString &Prefix, AnsiString &Suffix);

#pragma option push -b-
enum TFieldCharCase { ecNormal, ecUpperCase, ecLowerCase, ecProper };
#pragma option pop

class DELPHICLASS TSMESQLOptions;
class PASCALIMPLEMENTATION TSMESQLOptions : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FSQLTerm;
	char FSQLQuote;
	AnsiString FSQLNULL;
	AnsiString FCommitTerm;
	int FBatchRecCount;
	bool FAddCreateTable;
	TFieldCharCase FFieldNameCharCase;
	bool FMultiRowInsert;
	TSMESQLTypes* FSQLTypes;
	void __fastcall SetSQLTypes(TSMESQLTypes* Value);
	
public:
	__fastcall virtual TSMESQLOptions(void);
	__fastcall virtual ~TSMESQLOptions(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall LoadFromStrings(Classes::TStrings* lstSpec);
	void __fastcall SaveToStream(Classes::TStream* AStream);
	
__published:
	__property bool AddCreateTable = {read=FAddCreateTable, write=FAddCreateTable, nodefault};
	__property AnsiString CommitTerm = {read=FCommitTerm, write=FCommitTerm};
	__property int BatchRecCount = {read=FBatchRecCount, write=FBatchRecCount, default=2147483647};
	__property TFieldCharCase FieldNameCharCase = {read=FFieldNameCharCase, write=FFieldNameCharCase, default=0};
	__property bool MultiRowInsert = {read=FMultiRowInsert, write=FMultiRowInsert, default=0};
	__property char SQLQuote = {read=FSQLQuote, write=FSQLQuote, nodefault};
	__property AnsiString SQLTerm = {read=FSQLTerm, write=FSQLTerm};
	__property TSMESQLTypes* SQLTypes = {read=FSQLTypes, write=SetSQLTypes};
	__property AnsiString SQLNULL = {read=FSQLNULL, write=FSQLNULL};
};


class DELPHICLASS TSMExportToSQL;
class PASCALIMPLEMENTATION TSMExportToSQL : public Sme2cell::TSMExportToCellBufferedFile 
{
	typedef Sme2cell::TSMExportToCellBufferedFile inherited;
	
private:
	TSMESQLOptions* FSQLOptions;
	int RecInBatch;
	AnsiString strFieldNames;
	TGetCreateTable FOnGetCreateTable;
	AnsiString __fastcall GetSQLTerm();
	void __fastcall SetSQLTerm(AnsiString Value);
	char __fastcall GetSQLQuote(void);
	void __fastcall SetSQLQuote(char Value);
	AnsiString __fastcall GetCommitTerm();
	void __fastcall SetCommitTerm(AnsiString Value);
	int __fastcall GetBatchRecCount(void);
	void __fastcall SetBatchRecCount(int Value);
	bool __fastcall GetAddCreateTable(void);
	void __fastcall SetAddCreateTable(bool Value);
	TFieldCharCase __fastcall GetFieldNameCharCase(void);
	void __fastcall SetFieldNameCharCase(TFieldCharCase Value);
	TSMESQLTypes* __fastcall GetSQLTypes(void);
	void __fastcall SetSQLTypes(TSMESQLTypes* Value);
	bool __fastcall GetMultiRowInsert(void);
	void __fastcall SetMultiRowInsert(bool Value);
	TSMESQLOptions* __fastcall GetSQLOptions(void);
	void __fastcall SetSQLOptions(TSMESQLOptions* Value);
	
protected:
	virtual bool __fastcall MergeIsSupported(void);
	virtual bool __fastcall TitleIsSupported(void);
	virtual AnsiString __fastcall GetFieldStr(Db::TField* Field);
	AnsiString __fastcall GetFieldName(const AnsiString Value);
	
public:
	virtual void __fastcall WriteCommitTerm(void);
	virtual void __fastcall WriteFileBegin(void);
	virtual void __fastcall WriteFileEnd(void);
	virtual void __fastcall WriteRowStart(void);
	virtual void __fastcall WriteRowEnd(void);
	virtual void __fastcall WriteData(Db::TField* fld, Smeengine::TCellType &CellType, int ARow, int ACol, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	__fastcall virtual TSMExportToSQL(Classes::TComponent* AOwner);
	__fastcall virtual ~TSMExportToSQL(void);
	virtual AnsiString __fastcall Extension();
	
__published:
	__property ActionAfterExport  = {default=0};
	__property FileName ;
	__property bool AddCreateTable = {read=GetAddCreateTable, write=SetAddCreateTable, nodefault};
	__property AnsiString CommitTerm = {read=GetCommitTerm, write=SetCommitTerm};
	__property int BatchRecCount = {read=GetBatchRecCount, write=SetBatchRecCount, default=2147483647};
	__property TFieldCharCase FieldNameCharCase = {read=GetFieldNameCharCase, write=SetFieldNameCharCase, default=0};
	__property bool MultiRowInsert = {read=GetMultiRowInsert, write=SetMultiRowInsert, nodefault};
	__property char SQLQuote = {read=GetSQLQuote, write=SetSQLQuote, nodefault};
	__property AnsiString SQLTerm = {read=GetSQLTerm, write=SetSQLTerm};
	__property TSMESQLTypes* SQLTypes = {read=GetSQLTypes, write=SetSQLTypes};
	__property TSMESQLOptions* SQLOptions = {read=GetSQLOptions, write=SetSQLOptions};
	__property TableName ;
	__property TGetCreateTable OnGetCreateTable = {read=FOnGetCreateTable, write=FOnGetCreateTable};
	__property AddTitle  = {default=0};
	__property CharacterSet ;
	__property Header ;
	__property Footer ;
	__property OnGetCellParams ;
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE AnsiString CreateTableTemplate;

}	/* namespace Sme2sql */
using namespace Sme2sql;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2sql
