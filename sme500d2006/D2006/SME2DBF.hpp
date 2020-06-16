// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2dbf.pas' rev: 10.00

#ifndef Sme2dbfHPP
#define Sme2dbfHPP

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
#include <Smeengine.hpp>	// Pascal unit
#include <Sme2cell.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2dbf
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct TDBFField
{
	
public:
	char FieldName[11];
	char FieldType;
	int Address;
	Byte Length;
	Byte Decimals;
	Byte Reserved1[2];
	Byte WordAreaID;
	Word MultiUserDBase;
	Byte SetFields;
	Byte Reserved2[8];
	Byte MDXFlag;
} ;
#pragma pack(pop)

#pragma pack(push,1)
struct TDBFField7
{
	
public:
	char FieldName[32];
	char FieldType;
	Byte Length;
	Byte Decimals;
	Byte Reserved1[2];
	Byte MDXFlag;
	unsigned Reserved2;
	unsigned NextAutoInc;
	Word Reserved3;
} ;
#pragma pack(pop)

typedef TDBFField TDBFFields[4096];

#pragma option push -b-
enum TDBFVersion { dBase3, dBase3Memo, dBase3Plus, dBase3PlusMemo, FoxPro, FoxProMemo, dBase4, dBase4Memo, VFP3, dBase5, dBase7, dBase7Memo, FoxBASE1, FoxBASE2, VFP3AutoIncrement, HyperSix, VFP3Binary, dBase4SQL, dBase4SQLSys, FoxPro2 };
#pragma option pop

#pragma option push -b-
enum TDBFMemoType { dmDBT, dmFPT, dmSMT };
#pragma option pop

#pragma pack(push,1)
struct TDBFHeader
{
	
public:
	Byte VersionNumber;
	Byte LastUpdateYear;
	Byte LastUpdateMonth;
	Byte LastUpdateDay;
	int NumberOfRecords;
	Word HeaderSize;
	Word RecordSize;
	char Reserve1[2];
	Byte IncompleteTransaction;
	Byte Encrypted;
	char Reserved[12];
	Byte MDXIsExist;
	Byte LanguageID;
	char Reserved2[2];
	int NumberOfFields;
	TDBFField Fields[4096];
} ;
#pragma pack(pop)

#pragma pack(push,1)
struct TSMEDBTHeader
{
	
public:
	int NextBlock;
	Byte Dummy[4];
	Byte DbfFile[8];
	Byte Version;
	Byte Dummy2[3];
	Word BlockLen;
	Byte Dummy3[490];
} ;
#pragma pack(pop)

#pragma pack(push,1)
struct TSMEFPTHeader
{
	
public:
	int NextBlock;
	Byte Dummy[2];
	Word BlockLen;
	Byte Dummy3[504];
} ;
#pragma pack(pop)

struct TSMEBlockHeader;
typedef TSMEBlockHeader *PSMEBlockHeader;

struct TSMEBlockHeader
{
	
public:
	int MemoType;
	int MemoSize;
} ;

class DELPHICLASS TSMExportToDBF;
class PASCALIMPLEMENTATION TSMExportToDBF : public Sme2cell::TSMExportToCellFile 
{
	typedef Sme2cell::TSMExportToCellFile inherited;
	
private:
	#pragma pack(push,1)
	TDBFHeader DBFHeader;
	#pragma pack(pop)
	#pragma pack(push,1)
	TSMEDBTHeader MEMOHeader;
	#pragma pack(pop)
	#pragma pack(push,1)
	TSMEFPTHeader FPTHeader;
	#pragma pack(pop)
	TDBFVersion FDBFVersion;
	TDBFMemoType FDBFMemoType;
	Byte FLanguageID;
	bool MemoIsExists;
	AnsiString MemoFileName;
	
protected:
	Classes::TStream* MEMOStream;
	virtual bool __fastcall MergeIsSupported(void);
	virtual void __fastcall InternalBeforeProcess(void);
	virtual void __fastcall InternalFileCreate(const AnsiString AFileName);
	void __fastcall WriteMemo(AnsiString Value);
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall WriteDataBegin(void);
	virtual void __fastcall CloseFileStream(void);
	virtual void __fastcall WriteDimensions(int intRowCount, int intColCount);
	virtual void __fastcall WriteColWidth(int intCurColumn, int intColWidth);
	virtual void __fastcall WriteRowStart(void);
	virtual void __fastcall WriteData(Db::TField* fld, Smeengine::TCellType &CellType, int ARow, int ACol, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	virtual void __fastcall WriteString(const AnsiString s);
	__fastcall virtual TSMExportToDBF(Classes::TComponent* AOwner);
	virtual AnsiString __fastcall Extension();
	
__published:
	__property TDBFVersion DBFVersion = {read=FDBFVersion, write=FDBFVersion, default=0};
	__property TDBFMemoType DBFMemoType = {read=FDBFMemoType, write=FDBFMemoType, default=0};
	__property Byte LanguageID = {read=FLanguageID, write=FLanguageID, default=0};
public:
	#pragma option push -w-inl
	/* TSMExportBaseComponent.Destroy */ inline __fastcall virtual ~TSMExportToDBF(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Byte arrDBFVersion[20];

}	/* namespace Sme2dbf */
using namespace Sme2dbf;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2dbf
