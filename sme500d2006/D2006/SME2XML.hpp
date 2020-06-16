// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2xml.pas' rev: 10.00

#ifndef Sme2xmlHPP
#define Sme2xmlHPP

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

namespace Sme2xml
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TSMEXMLFormat { xmlIE, xmlIECompact, xmlClientDataset, xmlElement, xmlMSSQL, xmlADO };
#pragma option pop

class DELPHICLASS TSMEXMLTags;
class PASCALIMPLEMENTATION TSMEXMLTags : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FRecordsTag;
	AnsiString FRecordTag;
	AnsiString FRowTag;
	AnsiString FParamsTag;
	bool FTableNameAsRecordsTag;
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property AnsiString RecordsTag = {read=FRecordsTag, write=FRecordsTag};
	__property AnsiString RecordTag = {read=FRecordTag, write=FRecordTag};
	__property AnsiString RowTag = {read=FRowTag, write=FRowTag};
	__property AnsiString ParamsTag = {read=FParamsTag, write=FParamsTag};
	__property bool TableNameAsRecordsTag = {read=FTableNameAsRecordsTag, write=FTableNameAsRecordsTag, default=0};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSMEXMLTags(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TSMEXMLTags(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TSMExportToXML;
class PASCALIMPLEMENTATION TSMExportToXML : public Sme2cell::TSMExportToCellFile 
{
	typedef Sme2cell::TSMExportToCellFile inherited;
	
private:
	TSMEXMLFormat FFormat;
	bool FGenerateXSL;
	Sme2cell::TSMEBLOBEncoding FBLOBEncoding;
	AnsiString FXMLParams;
	bool FAddDocType;
	TSMEXMLTags* FXMLTags;
	char FQuoteTerm;
	bool FHeaderFooterWithXML;
	AnsiString FLastMergedTag;
	void __fastcall SetXMLTags(TSMEXMLTags* Value);
	
protected:
	virtual bool __fastcall MergeIsSupported(void);
	virtual bool __fastcall TitleIsSupported(void);
	virtual AnsiString __fastcall GetFieldStr(Db::TField* Field);
	bool __fastcall IsParamStored(void);
	AnsiString __fastcall GetRecordsTag();
	void __fastcall OpenDataXMLTag(void);
	void __fastcall CloseDataXMLTag(void);
	
public:
	virtual void __fastcall WriteHeader(void);
	virtual void __fastcall WriteFooter(void);
	virtual void __fastcall WriteFileBegin(void);
	virtual void __fastcall WriteFileEnd(void);
	virtual void __fastcall WriteDataBegin(void);
	virtual void __fastcall WriteDataEnd(void);
	virtual void __fastcall WriteRowStart(void);
	virtual void __fastcall WriteRowEnd(void);
	virtual void __fastcall WriteDataLevelStart(void);
	virtual void __fastcall WriteDataLevelEnd(void);
	virtual void __fastcall WriteData(Db::TField* fld, Smeengine::TCellType &CellType, int ARow, int ACol, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	__fastcall virtual TSMExportToXML(Classes::TComponent* AOwner);
	__fastcall virtual ~TSMExportToXML(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual AnsiString __fastcall Extension();
	
__published:
	__property bool HeaderFooterWithXML = {read=FHeaderFooterWithXML, write=FHeaderFooterWithXML, nodefault};
	__property TSMEXMLFormat Format = {read=FFormat, write=FFormat, nodefault};
	__property bool GenerateXSL = {read=FGenerateXSL, write=FGenerateXSL, nodefault};
	__property AnsiString XMLParams = {read=FXMLParams, write=FXMLParams, stored=IsParamStored};
	__property bool AddDocType = {read=FAddDocType, write=FAddDocType, default=0};
	__property Sme2cell::TSMEBLOBEncoding BLOBEncoding = {read=FBLOBEncoding, write=FBLOBEncoding, default=1};
	__property TSMEXMLTags* XMLTags = {read=FXMLTags, write=SetXMLTags};
	__property char QuoteTerm = {read=FQuoteTerm, write=FQuoteTerm, default=34};
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TSMEXMLFormat DefaultXMLFormat;
extern PACKAGE AnsiString DefXMLParams;
extern PACKAGE AnsiString DefDTFormatForMIDAS;

}	/* namespace Sme2xml */
using namespace Sme2xml;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2xml
