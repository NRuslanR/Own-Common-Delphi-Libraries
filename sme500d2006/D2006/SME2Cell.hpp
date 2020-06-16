// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2cell.pas' rev: 10.00

#ifndef Sme2cellHPP
#define Sme2cellHPP

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
#include <Exportds.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2cell
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TSMEBLOBEncoding { beNone, beEncode64 };
#pragma option pop

class DELPHICLASS TSMExportToCellFile;
class PASCALIMPLEMENTATION TSMExportToCellFile : public Exportds::TSMExportBaseComponent 
{
	typedef Exportds::TSMExportBaseComponent inherited;
	
private:
	int FRecordCount;
	int FCurInBatch;
	Classes::TAlignment al;
	Smeengine::TCellType ct;
	Graphics::TFont* fontUser;
	Graphics::TColor colorUser;
	bool IsMyFileStream;
	Classes::TNotifyEvent FOnDataLevelBegin;
	Classes::TNotifyEvent FOnDataLevelEnd;
	
protected:
	int AdditionalHeaderCount;
	bool IsDataArea;
	bool FIsMergedFile;
	virtual void __fastcall Prepare(void);
	virtual void __fastcall CreateSourceDataEngine(void);
	virtual void __fastcall DestroySourceDataEngine(void);
	void __fastcall WriteDataSourceHeaders(Smeengine::TSMECustomDataEngine* de, Smeengine::TSMEColumns* AColumns, Exportds::TSMEDataLevels* ADetailSources, bool IsReprint);
	void __fastcall WriteOneRow(Smeengine::TSMECustomDataEngine* de, Smeengine::TSMEColumns* AColumns, Exportds::TSMEDataLevels* ADetailSources, Smeengine::TSMEGroupings* AGroupings, int LinNoInDataEngine, int &LinNoInFile);
	virtual void __fastcall WriteDetailLevels(Smeengine::TSMECustomDataEngine* de, Exportds::TSMEDataLevels* ADetailSources, int &LinNoInFile);
	virtual bool __fastcall MergeIsSupported(void);
	virtual bool __fastcall TitleIsSupported(void);
	virtual void __fastcall InternalFileCreate(const AnsiString AFileName);
	virtual void __fastcall InternalFileClose(void);
	
public:
	Classes::TStream* OutputStream;
	virtual void __fastcall WriteHeader(void);
	virtual void __fastcall WriteFooter(void);
	virtual void __fastcall WriteString(const AnsiString s);
	virtual void __fastcall WriteFileBegin(void);
	virtual void __fastcall WriteFileEnd(void);
	virtual void __fastcall WriteDimensions(int intRowCount, int intColCount);
	virtual void __fastcall WriteColWidth(int intCurColumn, int intColWidth);
	virtual void __fastcall WriteDataBegin(void);
	virtual void __fastcall WriteDataEnd(void);
	virtual void __fastcall WriteRowStart(void);
	virtual void __fastcall WriteRowEnd(void);
	virtual void __fastcall WriteDataLevelStart(void);
	virtual void __fastcall WriteDataLevelEnd(void);
	virtual void __fastcall WriteData(Db::TField* fld, Smeengine::TCellType &CellType, int ARow, int ACol, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	virtual void __fastcall WriteMergeData(Smeengine::TCellType &CellType, int ARow, int ACol, int AMergeCols, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	virtual void __fastcall CreateFileStream(const AnsiString AFileName, int intCurFileNum);
	virtual void __fastcall CloseFileStream(void);
	void __fastcall SaveToStream(Classes::TStream* Stream);
	
__published:
	__property ActionAfterExport  = {default=0};
	__property FileName ;
	__property AddTitle  = {default=0};
	__property CharacterSet ;
	__property Header ;
	__property Footer ;
	__property RowsPerFile  = {default=0};
	__property Layout  = {default=0};
	__property DetailSources ;
	__property OnGetCellParams ;
	__property OnGetRowHeight ;
	__property Classes::TNotifyEvent OnDataLevelBegin = {read=FOnDataLevelBegin, write=FOnDataLevelBegin};
	__property Classes::TNotifyEvent OnDataLevelEnd = {read=FOnDataLevelEnd, write=FOnDataLevelEnd};
public:
	#pragma option push -w-inl
	/* TSMExportBaseComponent.Create */ inline __fastcall virtual TSMExportToCellFile(Classes::TComponent* AOwner) : Exportds::TSMExportBaseComponent(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSMExportBaseComponent.Destroy */ inline __fastcall virtual ~TSMExportToCellFile(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSMExportToCellBufferedFile;
class PASCALIMPLEMENTATION TSMExportToCellBufferedFile : public TSMExportToCellFile 
{
	typedef TSMExportToCellFile inherited;
	
private:
	int FBufferSize;
	
protected:
	int posInBuffer;
	char *buf;
	virtual void __fastcall InternalFileCreate(const AnsiString AFileName);
	virtual void __fastcall InternalFileClose(void);
	
public:
	__fastcall virtual TSMExportToCellBufferedFile(Classes::TComponent* AOwner);
	virtual void __fastcall WriteString(const AnsiString s);
	__property int BufferSize = {read=FBufferSize, write=FBufferSize, nodefault};
public:
	#pragma option push -w-inl
	/* TSMExportBaseComponent.Destroy */ inline __fastcall virtual ~TSMExportToCellBufferedFile(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE int smeDefaultBufferSize;

}	/* namespace Sme2cell */
using namespace Sme2cell;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2cell
