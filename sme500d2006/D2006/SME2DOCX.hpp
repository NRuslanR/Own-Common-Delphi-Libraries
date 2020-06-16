// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2docx.pas' rev: 10.00

#ifndef Sme2docxHPP
#define Sme2docxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Sme2cell.hpp>	// Pascal unit
#include <Exportds.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit
#include <Smezipfile.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2docx
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS ESMEWordException;
class PASCALIMPLEMENTATION ESMEWordException : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall ESMEWordException(const AnsiString Msg) : Sysutils::Exception(Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESMEWordException(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESMEWordException(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESMEWordException(int Ident, System::TVarRec const * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESMEWordException(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESMEWordException(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESMEWordException(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESMEWordException(System::PResStringRec ResStringRec, System::TVarRec const * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESMEWordException(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TDOCObjectKind { dokUnknown, dokHyperlink, dokNote, dokPicture, dokImage, dokGraphic, dokRTF, dokHTML, dokBookmark };
#pragma option pop

class DELPHICLASS TDOCObject;
class PASCALIMPLEMENTATION TDOCObject : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TDOCObjectKind FObjectKind;
	Word FFromCol;
	Word FFromRow;
	Word FToCol;
	Word FToRow;
	
public:
	virtual AnsiString __fastcall GetID(int AIndex);
	__property TDOCObjectKind ObjectKind = {read=FObjectKind, write=FObjectKind, default=0};
	__property Word FromCol = {read=FFromCol, write=FFromCol, nodefault};
	__property Word FromRow = {read=FFromRow, write=FFromRow, nodefault};
	__property Word ToCol = {read=FToCol, write=FToCol, nodefault};
	__property Word ToRow = {read=FToRow, write=FToRow, nodefault};
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TDOCObject(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TDOCObject(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDOCPicture;
class PASCALIMPLEMENTATION TDOCPicture : public TDOCObject 
{
	typedef TDOCObject inherited;
	
private:
	Graphics::TPicture* FPicture;
	int FSize;
	
public:
	__fastcall virtual TDOCPicture(void);
	__fastcall virtual ~TDOCPicture(void);
	int __fastcall GetPictureSize(void);
	int __fastcall GetPictureType(void);
	AnsiString __fastcall GetPictureExt();
	void __fastcall WriteToStream(Classes::TStream* strm);
	AnsiString __fastcall GetAsString(bool ConvertToJpeg);
	__property Graphics::TPicture* Picture = {read=FPicture, write=FPicture};
	__property int Size = {read=FSize, write=FSize, nodefault};
};


class DELPHICLASS TDOCChunk;
class PASCALIMPLEMENTATION TDOCChunk : public TDOCObject 
{
	typedef TDOCObject inherited;
	
private:
	Classes::TMemoryStream* FData;
	
public:
	__fastcall virtual TDOCChunk(void);
	__fastcall virtual ~TDOCChunk(void);
	__property Classes::TMemoryStream* Data = {read=FData, write=FData};
};


class DELPHICLASS TDOCRTF;
class PASCALIMPLEMENTATION TDOCRTF : public TDOCChunk 
{
	typedef TDOCChunk inherited;
	
protected:
	AnsiString __fastcall GetFileName(int AIndex);
	
public:
	__fastcall virtual TDOCRTF(void);
	virtual AnsiString __fastcall GetID(int AIndex);
public:
	#pragma option push -w-inl
	/* TDOCChunk.Destroy */ inline __fastcall virtual ~TDOCRTF(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDOCHTML;
class PASCALIMPLEMENTATION TDOCHTML : public TDOCChunk 
{
	typedef TDOCChunk inherited;
	
protected:
	AnsiString __fastcall GetFileName(int AIndex);
	
public:
	__fastcall virtual TDOCHTML(void);
	virtual AnsiString __fastcall GetID(int AIndex);
public:
	#pragma option push -w-inl
	/* TDOCChunk.Destroy */ inline __fastcall virtual ~TDOCHTML(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDOCBookmark;
class PASCALIMPLEMENTATION TDOCBookmark : public TDOCObject 
{
	typedef TDOCObject inherited;
	
private:
	int FTocID;
	AnsiString FName;
	AnsiString FTitle;
	
protected:
	AnsiString __fastcall GetName();
	
public:
	__fastcall virtual TDOCBookmark(void);
	__property int TocID = {read=FTocID, write=FTocID, nodefault};
	__property AnsiString Name = {read=FName, write=FName};
	__property AnsiString Title = {read=FTitle, write=FTitle};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TDOCBookmark(void) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TSMEBeforeWriteStreamEvent)(System::TObject* Sender, Classes::TStream* &AStream);

class DELPHICLASS TSMExportToWordX;
class PASCALIMPLEMENTATION TSMExportToWordX : public Sme2cell::TSMExportToCellFile 
{
	typedef Sme2cell::TSMExportToCellFile inherited;
	
private:
	Smezipfile::TZipArchive* fsDOCX;
	TSMEBeforeWriteStreamEvent FOnBeforeWriteStream;
	Classes::TList* lstFonts;
	Classes::TList* lstObjects;
	Classes::TStream* strmXMLDocument;
	AnsiString strColumnWidths;
	Variant arrColWidths;
	void * __fastcall GetResourceAsPointer(char * ResName, char * ResType, /* out */ int &Size);
	AnsiString __fastcall GetResourceAsString(char * ResName, char * ResType);
	
protected:
	int OpenedTRtagCount;
	virtual void __fastcall InternalBeforeProcess(void);
	virtual void __fastcall InternalAfterProcess(void);
	virtual void __fastcall InternalFileCreate(const AnsiString AFileName);
	virtual void __fastcall InternalFileClose(void);
	void __fastcall AddFileToArchive(const AnsiString FileName, unsigned FAttr, const AnsiString AValue);
	void __fastcall AddFileStreamToArchive(const AnsiString FileName, Classes::TStream* AStream);
	AnsiString __fastcall GetFontXML(Graphics::TFont* fn);
	void __fastcall WriteFontFormats(void);
	void __fastcall WriteObjects(void);
	void __fastcall WriteStringToDocument(AnsiString s);
	AnsiString __fastcall GetXMLColor(Graphics::TColor cl, bool IsBackColor, AnsiString AFormatString);
	AnsiString __fastcall GetXMLFont(Graphics::TFont* fnt, Graphics::TColor BackColor);
	AnsiString __fastcall GetRPrTag(bool IsDataArea);
	AnsiString __fastcall GetColumnProperties(int ACol, Graphics::TColor BackColor);
	AnsiString __fastcall GetTableStart();
	AnsiString __fastcall GetTableFinish();
	AnsiString __fastcall GetColSpan(int ColCount);
	AnsiString __fastcall GetShiftRow(int ShiftCount);
	
public:
	__fastcall virtual TSMExportToWordX(Classes::TComponent* AOwner);
	virtual AnsiString __fastcall Extension();
	int __fastcall AddObjectToDocument(TDOCObject* obj);
	virtual void __fastcall ApplyDefaultFont(Graphics::TFont* AFont, bool ReadOwner);
	virtual void __fastcall WriteFileBegin(void);
	virtual void __fastcall WriteFileEnd(void);
	virtual void __fastcall CloseFileStream(void);
	virtual void __fastcall WriteDataBegin(void);
	virtual void __fastcall WriteDataEnd(void);
	virtual void __fastcall WriteData(Db::TField* fld, Smeengine::TCellType &CellType, int ARow, int ACol, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	virtual void __fastcall WriteMergeData(Smeengine::TCellType &CellType, int ARow, int ACol, int AMergeCols, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	virtual void __fastcall WriteDimensions(int intRowCount, int intColCount);
	virtual void __fastcall WriteColWidth(int intCurColumn, int intColWidth);
	virtual void __fastcall WriteRowStart(void);
	virtual void __fastcall WriteRowEnd(void);
	__property TSMEBeforeWriteStreamEvent OnBeforeWriteStream = {read=FOnBeforeWriteStream, write=FOnBeforeWriteStream};
public:
	#pragma option push -w-inl
	/* TSMExportBaseComponent.Destroy */ inline __fastcall virtual ~TSMExportToWordX(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#define DocumentXMLHeader "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\""\
	"?>\r\n<w:document xmlns:ve=\"http://schemas.openxmlformats"\
	".org/markup-compatibility/2006\" xmlns:o=\"urn:schemas-mic"\
	"rosoft-com:office:office\" xmlns:r=\"http://schemas.openxm"\
	"lformats.org/officeDocument/2006/relationships\" xmlns:m=\""\
	"http://schemas.openxmlformats.org/officeDocument/2006/math"\
	"\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:wp=\"ht"\
	"tp://schemas.openxmlformats.org/drawingml/2006/wordprocess"\
	"ingDrawing\" xmlns:w10=\"urn:schemas-microsoft-com:office:"\
	"word\" xmlns:w=\"http://schemas.openxmlformats.org/wordpro"\
	"cessingml/2006/main\" xmlns:wne=\"http://schemas.microsoft"\
	".com/office/word/2006/wordml\"><w:body>"

}	/* namespace Sme2docx */
using namespace Sme2docx;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2docx
