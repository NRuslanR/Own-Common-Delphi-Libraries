// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2rtf.pas' rev: 10.00

#ifndef Sme2rtfHPP
#define Sme2rtfHPP

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
#include <Sme2cell.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2rtf
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSMERTFOptions;
class PASCALIMPLEMENTATION TSMERTFOptions : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FConvertPictureToJPEG;
	bool FCreateUnlikedPictureType;
	
public:
	__fastcall virtual TSMERTFOptions(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool ConvertPictureToJPEG = {read=FConvertPictureToJPEG, write=FConvertPictureToJPEG, default=1};
	__property bool CreateUnlikedPictureType = {read=FCreateUnlikedPictureType, write=FCreateUnlikedPictureType, default=0};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSMERTFOptions(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSMExportToRTF;
class PASCALIMPLEMENTATION TSMExportToRTF : public Sme2cell::TSMExportToCellFile 
{
	typedef Sme2cell::TSMExportToCellFile inherited;
	
private:
	TSMERTFOptions* FRTFOptions;
	Classes::TStrings* lstFonts;
	Classes::TStrings* lstColors;
	Variant arrColWidths;
	bool IsMemStream;
	int __fastcall GetTwips(float AValue);
	void __fastcall SetRTFOptions(TSMERTFOptions* Value);
	
protected:
	Classes::TMemoryStream* MemStream;
	virtual bool __fastcall MergeIsSupported(void);
	AnsiString __fastcall DateTimeToRTF(System::TDateTime Value);
	AnsiString __fastcall GetFontStyle(Graphics::TFontStyles fs);
	AnsiString __fastcall GetFromTable(Classes::TStrings* lstTable, int intShift, const AnsiString Value);
	AnsiString __fastcall WritePictureToRTF(Classes::TStream* AStream);
	AnsiString __fastcall WriteBitmap(Graphics::TBitmap* bmp);
	AnsiString __fastcall WriteMetafileToRTF(Graphics::TMetafile* mf);
	AnsiString __fastcall WriteBitmapContent(Graphics::TBitmap* bmp);
	
public:
	virtual void __fastcall WriteString(const AnsiString s);
	virtual void __fastcall WriteFileBegin(void);
	virtual void __fastcall WriteFileEnd(void);
	virtual void __fastcall WriteDataBegin(void);
	virtual void __fastcall WriteDataEnd(void);
	virtual void __fastcall WriteDimensions(int intRowCount, int intColCount);
	virtual void __fastcall WriteColWidth(int intCurColumn, int intColWidth);
	virtual void __fastcall WriteRowEnd(void);
	virtual void __fastcall WriteData(Db::TField* fld, Smeengine::TCellType &CellType, int ARow, int ACol, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	__fastcall virtual TSMExportToRTF(Classes::TComponent* AOwner);
	__fastcall virtual ~TSMExportToRTF(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual AnsiString __fastcall Extension();
	
__published:
	__property PageSetup ;
	__property TSMERTFOptions* RTFOptions = {read=FRTFOptions, write=SetRTFOptions};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Sme2rtf */
using namespace Sme2rtf;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2rtf
