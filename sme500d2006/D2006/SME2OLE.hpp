// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2ole.pas' rev: 10.00

#ifndef Sme2oleHPP
#define Sme2oleHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Exportds.hpp>	// Pascal unit
#include <Sme2cell.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2ole
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TMSExcelVersion { evExcelAuto, evExcel2, evExcel2FarEast, evExcel3, evExcel4, evExcel5, evExcel7, evExcel9597, evExcel8, evExcel2007 };
#pragma option pop

class DELPHICLASS TSMExportToExcel;
class PASCALIMPLEMENTATION TSMExportToExcel : public Sme2cell::TSMExportToCellFile 
{
	typedef Sme2cell::TSMExportToCellFile inherited;
	
private:
	TMSExcelVersion FExcelVersion;
	AnsiString FTemplateFile;
	bool IsNewestCom;
	bool FUseCurrentInstance;
	int FStartColumn;
	int FStartRow;
	bool FFreezeFixed;
	bool FDeleteDefaultSheets;
	AnsiString FPassword;
	AnsiString strLastFileName;
	bool FIsMemoColumnExist;
	Variant arrData;
	Graphics::TColor colorDefault;
	Classes::TStrings* FPageHeader;
	Classes::TStrings* FPageFooter;
	Classes::TStrings* __fastcall GetPageHeader(void);
	void __fastcall SetPageHeader(Classes::TStrings* Value);
	Classes::TStrings* __fastcall GetPageFooter(void);
	void __fastcall SetPageFooter(Classes::TStrings* Value);
	bool __fastcall IsVersionStore(void);
	void __fastcall DrawBorder(const Variant &Range, bool IsVertical);
	
protected:
	int intMergedSheetRows;
	virtual void __fastcall InternalFileCreate(const AnsiString AFileName);
	virtual AnsiString __fastcall GetFormat(Db::TFieldType ft, int Precision);
	bool __fastcall IsFormula(const AnsiString Value);
	
public:
	Variant xls;
	Variant xlw;
	__fastcall virtual TSMExportToExcel(Classes::TComponent* AOwner);
	__fastcall virtual ~TSMExportToExcel(void);
	virtual AnsiString __fastcall Extension();
	void __fastcall SaveFileStream(void);
	virtual void __fastcall CloseFileStream(void);
	void __fastcall CreateNewSheet(const AnsiString SheetName);
	virtual void __fastcall WriteHeader(void);
	virtual void __fastcall WriteFooter(void);
	virtual void __fastcall WriteDimensions(int intRowCount, int intColCount);
	virtual void __fastcall WriteColWidth(int intCurColumn, int intColWidth);
	virtual void __fastcall WriteData(Db::TField* fld, Smeengine::TCellType &CellType, int ARow, int ACol, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	virtual void __fastcall WriteMergeData(Smeengine::TCellType &CellType, int ARow, int ACol, int AMergeCols, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	virtual void __fastcall WriteRowStart(void);
	virtual void __fastcall WriteRowEnd(void);
	
__published:
	__property AutoFitColumns  = {default=0};
	__property bool UseCurrentInstance = {read=FUseCurrentInstance, write=FUseCurrentInstance, default=0};
	__property TMSExcelVersion ExcelVersion = {read=FExcelVersion, write=FExcelVersion, stored=IsVersionStore, default=0};
	__property AnsiString TemplateFile = {read=FTemplateFile, write=FTemplateFile};
	__property bool FreezeFixed = {read=FFreezeFixed, write=FFreezeFixed, default=0};
	__property bool DeleteDefaultSheets = {read=FDeleteDefaultSheets, write=FDeleteDefaultSheets, default=0};
	__property AnsiString Password = {read=FPassword, write=FPassword};
	__property PageSetup ;
	__property Classes::TStrings* PageHeader = {read=GetPageHeader, write=SetPageHeader};
	__property Classes::TStrings* PageFooter = {read=GetPageFooter, write=SetPageFooter};
	__property ActionAfterExport  = {default=0};
	__property FileName ;
	__property int StartColumn = {read=FStartColumn, write=FStartColumn, default=0};
	__property int StartRow = {read=FStartRow, write=FStartRow, default=0};
	__property AddTitle  = {default=0};
	__property CharacterSet ;
	__property ExportStyle ;
	__property Header ;
	__property Footer ;
	__property OnGetCellParams ;
};


#pragma option push -b-
enum TSMEWordFileFormat { ewDefault, ewDocument, ewDocument97, ewText, ewDOSText, ewRTF, ewUnicodeText, ewHTML, ewWebArchive, ewFilteredHTML, ewXML, ewPDF, ewXPS, ewODT };
#pragma option pop

class DELPHICLASS TSMExportToWord;
class PASCALIMPLEMENTATION TSMExportToWord : public Sme2cell::TSMExportToCellFile 
{
	typedef Sme2cell::TSMExportToCellFile inherited;
	
private:
	bool IsNewestCom;
	bool FUseCurrentInstance;
	AnsiString FTemplateFile;
	AnsiString strLastFileName;
	Variant arrColWidths;
	int intTblRowCount;
	int intTblColCount;
	AnsiString FPassword;
	TSMEWordFileFormat FFileFormat;
	int __fastcall GetColorIndex(Graphics::TColor color);
	float __fastcall GetMeasureMargin(Smeengine::TSMEMeasure Measure, float Value);
	
protected:
	int intTotalMergedCols;
	virtual void __fastcall InternalFileCreate(const AnsiString AFileName);
	
public:
	Variant word;
	Variant document;
	Variant table;
	__fastcall virtual TSMExportToWord(Classes::TComponent* AOwner);
	virtual AnsiString __fastcall Extension();
	virtual void __fastcall CloseFileStream(void);
	virtual void __fastcall WriteDataBegin(void);
	virtual void __fastcall WriteDimensions(int intRowCount, int intColCount);
	virtual void __fastcall WriteColWidth(int intCurColumn, int intColWidth);
	virtual void __fastcall WriteData(Db::TField* fld, Smeengine::TCellType &CellType, int ARow, int ACol, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	virtual void __fastcall WriteMergeData(Smeengine::TCellType &CellType, int ARow, int ACol, int AMergeCols, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	virtual void __fastcall WriteRowStart(void);
	
__published:
	__property bool UseCurrentInstance = {read=FUseCurrentInstance, write=FUseCurrentInstance, default=0};
	__property AnsiString TemplateFile = {read=FTemplateFile, write=FTemplateFile};
	__property AutoFitColumns  = {default=0};
	__property AnsiString Password = {read=FPassword, write=FPassword};
	__property TSMEWordFileFormat FileFormat = {read=FFileFormat, write=FFileFormat, default=0};
	__property PageSetup ;
	__property ActionAfterExport  = {default=0};
	__property FileName ;
	__property AddTitle  = {default=0};
	__property CharacterSet ;
	__property ExportStyle ;
	__property Header ;
	__property Footer ;
	__property OnGetCellParams ;
public:
	#pragma option push -w-inl
	/* TSMExportBaseComponent.Destroy */ inline __fastcall virtual ~TSMExportToWord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSMExportToADODOA;
class PASCALIMPLEMENTATION TSMExportToADODOA : public Exportds::TSMExportBaseComponent 
{
	typedef Exportds::TSMExportBaseComponent inherited;
	
private:
	bool FUseCurrentInstance;
	AnsiString FUserName;
	AnsiString FPassword;
	
protected:
	bool IsNewestCom;
	Graphics::TFont* fontUser;
	virtual void __fastcall InitializeConnection(void);
	virtual void __fastcall FinilizeConnection(void);
	virtual void __fastcall OpenDatabase(AnsiString Value);
	virtual bool __fastcall TableExists(const AnsiString Value);
	virtual void __fastcall DeleteTable(const AnsiString Value);
	virtual void __fastcall CreateNewTable(void);
	virtual void __fastcall OpenRecordset(void);
	virtual void __fastcall AddNewRecord(void);
	virtual void __fastcall UpdateField(int ACol, Db::TField* fld, const Variant &Value);
	virtual void __fastcall PostRecord(void);
	virtual void __fastcall Prepare(void);
	
public:
	__fastcall virtual TSMExportToADODOA(Classes::TComponent* AOwner);
	
__published:
	__property bool UseCurrentInstance = {read=FUseCurrentInstance, write=FUseCurrentInstance, default=0};
	__property AnsiString UserName = {read=FUserName, write=FUserName};
	__property AnsiString Password = {read=FPassword, write=FPassword};
	__property ActionAfterExport  = {default=0};
	__property FileName ;
	__property TableName ;
	__property CharacterSet ;
	__property OnGetCellParams ;
public:
	#pragma option push -w-inl
	/* TSMExportBaseComponent.Destroy */ inline __fastcall virtual ~TSMExportToADODOA(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TMSAccessVersion { avAuto, avAccess97, avAccess2000, avAccess2007 };
#pragma option pop

class DELPHICLASS TSMExportToAccess;
class PASCALIMPLEMENTATION TSMExportToAccess : public TSMExportToADODOA 
{
	typedef TSMExportToADODOA inherited;
	
private:
	TMSAccessVersion FMSAccessVersion;
	bool __fastcall IsVersionStore(void);
	
protected:
	virtual AnsiString __fastcall GetFieldStr(Db::TField* Field);
	virtual void __fastcall InitializeConnection(void);
	virtual void __fastcall FinilizeConnection(void);
	virtual void __fastcall OpenDatabase(AnsiString Value);
	virtual bool __fastcall TableExists(const AnsiString Value);
	virtual void __fastcall DeleteTable(const AnsiString Value);
	virtual void __fastcall CreateNewTable(void);
	virtual void __fastcall OpenRecordset(void);
	virtual void __fastcall AddNewRecord(void);
	virtual void __fastcall UpdateField(int ACol, Db::TField* fld, const Variant &Value);
	virtual void __fastcall PostRecord(void);
	
public:
	OleVariant access;
	OleVariant db;
	OleVariant recordset;
	__fastcall virtual TSMExportToAccess(Classes::TComponent* AOwner);
	virtual AnsiString __fastcall Extension();
	
__published:
	__property TMSAccessVersion MSAccessVersion = {read=FMSAccessVersion, write=FMSAccessVersion, stored=IsVersionStore, default=0};
public:
	#pragma option push -w-inl
	/* TSMExportBaseComponent.Destroy */ inline __fastcall virtual ~TSMExportToAccess(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSMExportToOpenOffice;
class PASCALIMPLEMENTATION TSMExportToOpenOffice : public Sme2cell::TSMExportToCellFile 
{
	typedef Sme2cell::TSMExportToCellFile inherited;
	
private:
	bool IsNewestCom;
	bool FUseCurrentInstance;
	AnsiString FFilterName;
	AnsiString strLastFileName;
	Variant arrColWidths;
	int intTblRowCount;
	int intTblColCount;
	
protected:
	int intTotalMergedCols;
	virtual void __fastcall InternalFileCreate(const AnsiString AFileName);
	Variant __fastcall MakePropertyValue(AnsiString PropName, AnsiString PropValue);
	AnsiString __fastcall FixPathChar(const AnsiString s);
	
public:
	Variant StarDesktop;
	Variant StarOffice;
	Variant Document;
	Variant Table;
	__fastcall virtual TSMExportToOpenOffice(Classes::TComponent* AOwner);
	virtual AnsiString __fastcall Extension();
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall CloseFileStream(void);
	virtual void __fastcall WriteDataBegin(void);
	virtual void __fastcall WriteDimensions(int intRowCount, int intColCount);
	virtual void __fastcall WriteColWidth(int intCurColumn, int intColWidth);
	virtual void __fastcall WriteData(Db::TField* fld, Smeengine::TCellType &CellType, int ARow, int ACol, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	virtual void __fastcall WriteMergeData(Smeengine::TCellType &CellType, int ARow, int ACol, int AMergeCols, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	/*         class method */ static void __fastcall GetFilterNames(TMetaClass* vmt, Classes::TStrings* lst);
	
__published:
	__property bool UseCurrentInstance = {read=FUseCurrentInstance, write=FUseCurrentInstance, default=0};
	__property AnsiString FilterName = {read=FFilterName, write=FFilterName};
	__property ActionAfterExport  = {default=0};
	__property FileName ;
	__property AddTitle  = {default=0};
	__property CharacterSet ;
	__property ExportStyle ;
	__property Header ;
	__property Footer ;
	__property OnGetCellParams ;
public:
	#pragma option push -w-inl
	/* TSMExportBaseComponent.Destroy */ inline __fastcall virtual ~TSMExportToOpenOffice(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TMSExcelVersion DefaultExcelVersion;
extern PACKAGE TMSAccessVersion DefaultAccessVersion;
extern PACKAGE AnsiString defOOFilterName;
extern PACKAGE bool __fastcall MSExcelIsInstalled(void);
extern PACKAGE bool __fastcall MSWordIsInstalled(void);
extern PACKAGE bool __fastcall MSAccessIsInstalled(void);
extern PACKAGE bool __fastcall MSJETIsInstalled(void);
extern PACKAGE bool __fastcall OpenOfficeIsInstalled(void);
extern PACKAGE void __fastcall GetAccessTableNames(Classes::TStrings* lst, const AnsiString DBName);

}	/* namespace Sme2ole */
using namespace Sme2ole;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2ole
