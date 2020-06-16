// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Smeengine.pas' rev: 10.00

#ifndef SmeengineHPP
#define SmeengineHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smeengine
{
//-- type declarations -------------------------------------------------------
typedef AnsiString TSMEString;

typedef char TSMEChar;

class DELPHICLASS ESMENotSupportedClassException;
class PASCALIMPLEMENTATION ESMENotSupportedClassException : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall ESMENotSupportedClassException(const AnsiString Msg) : Sysutils::Exception(Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESMENotSupportedClassException(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESMENotSupportedClassException(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESMENotSupportedClassException(int Ident, System::TVarRec const * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESMENotSupportedClassException(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESMENotSupportedClassException(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESMENotSupportedClassException(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESMENotSupportedClassException(System::PResStringRec ResStringRec, System::TVarRec const * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESMENotSupportedClassException(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSMEColumnBand;
class PASCALIMPLEMENTATION TSMEColumnBand : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Classes::TAlignment FAlignment;
	AnsiString FCaption;
	bool FVisible;
	Graphics::TColor FColor;
	Graphics::TFont* FFont;
	void __fastcall SetFont(Graphics::TFont* Value);
	
public:
	__fastcall virtual TSMEColumnBand(Classes::TCollection* Collection);
	__fastcall virtual ~TSMEColumnBand(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Classes::TAlignment Alignment = {read=FAlignment, write=FAlignment, default=2};
	__property AnsiString Caption = {read=FCaption, write=FCaption};
	__property bool Visible = {read=FVisible, write=FVisible, default=1};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor Color = {read=FColor, write=FColor, default=12632256};
};


class DELPHICLASS TSMEColumnBands;
class PASCALIMPLEMENTATION TSMEColumnBands : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
public:
	TSMEColumnBand* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TComponent* FSMEControl;
	TSMEColumnBand* __fastcall GetColumnBand(int Index);
	void __fastcall SetColumnband(int Index, TSMEColumnBand* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TSMEColumnBands(Classes::TComponent* SMECntrl);
	HIDESBASE TSMEColumnBand* __fastcall Add(void);
	__property TSMEColumnBand* Items[int Index] = {read=GetColumnBand, write=SetColumnband/*, default*/};
	__property Classes::TComponent* SMEControl = {read=FSMEControl};
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TSMEColumnBands(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSMEColumnTitle;
class PASCALIMPLEMENTATION TSMEColumnTitle : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FCaption;
	Graphics::TColor FColor;
	Classes::TAlignment FAlignment;
	Graphics::TFont* FFont;
	void __fastcall SetFont(Graphics::TFont* Value);
	
public:
	__fastcall TSMEColumnTitle(void);
	__fastcall virtual ~TSMEColumnTitle(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property AnsiString Caption = {read=FCaption, write=FCaption};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=FAlignment, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor Color = {read=FColor, write=FColor, default=12632256};
};


#pragma option push -b-
enum TSMEFieldDisplayFormat { dfFull, dfFieldCaption, dfFieldName };
#pragma option pop

#pragma option push -b-
enum TSMEColumnKind { ckField, ckConstant, ckSysVar };
#pragma option pop

#pragma option push -b-
enum TCellType { ctBlank, ctInteger, ctDouble, ctString, ctDateTime, ctDate, ctCurrency, ctTime, ctMEMO, ctGraphic, ctBoolean, ctBLOB };
#pragma option pop

class DELPHICLASS TSMEColumn;
class PASCALIMPLEMENTATION TSMEColumn : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	AnsiString FFieldName;
	Graphics::TColor FColor;
	int FWidth;
	int FPrecision;
	Graphics::TFont* FFont;
	Classes::TAlignment FAlignment;
	bool FVisible;
	TSMEColumnTitle* FTitle;
	TCellType FDataType;
	TSMEColumnKind FColumnKind;
	int FBandIndex;
	void __fastcall SetFont(Graphics::TFont* Value);
	void __fastcall SetTitle(TSMEColumnTitle* Value);
	
public:
	Db::TField* Field;
	__fastcall virtual TSMEColumn(Classes::TCollection* Collection);
	__fastcall virtual ~TSMEColumn(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	AnsiString __fastcall GetItemCaption(TSMEFieldDisplayFormat FieldDisplayFormat);
	
__published:
	__property Classes::TAlignment Alignment = {read=FAlignment, write=FAlignment, default=0};
	__property Graphics::TColor Color = {read=FColor, write=FColor, default=16777215};
	__property AnsiString FieldName = {read=FFieldName, write=FFieldName};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property int Width = {read=FWidth, write=FWidth, default=0};
	__property int Precision = {read=FPrecision, write=FPrecision, default=0};
	__property bool Visible = {read=FVisible, write=FVisible, nodefault};
	__property TSMEColumnTitle* Title = {read=FTitle, write=SetTitle};
	__property TCellType DataType = {read=FDataType, write=FDataType, default=3};
	__property TSMEColumnKind ColumnKind = {read=FColumnKind, write=FColumnKind, default=0};
	__property int BandIndex = {read=FBandIndex, write=FBandIndex, default=-1};
};


class DELPHICLASS TSMEColumns;
class PASCALIMPLEMENTATION TSMEColumns : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
public:
	TSMEColumn* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TComponent* FSMEControl;
	TSMEColumn* __fastcall GetColumn(int Index);
	void __fastcall SetColumn(int Index, TSMEColumn* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TSMEColumns(Classes::TComponent* SMECntrl);
	HIDESBASE TSMEColumn* __fastcall Add(void);
	int __fastcall ColumnByFieldName(const AnsiString AFieldName);
	int __fastcall MergedColStart(int BandIndex);
	int __fastcall MergedColCount(int BandIndex, int StartColIndex);
	void __fastcall ClearFields(void);
	__property TSMEColumn* Items[int Index] = {read=GetColumn, write=SetColumn/*, default*/};
	__property Classes::TComponent* SMEControl = {read=FSMEControl};
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TSMEColumns(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSMEGrouping;
class PASCALIMPLEMENTATION TSMEGrouping : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	AnsiString FCaption;
	Graphics::TColor FColor;
	Graphics::TFont* FFont;
	AnsiString FExpression;
	void __fastcall SetFont(Graphics::TFont* Value);
	
protected:
	Variant FPrevValue;
	Variant FCurrValue;
	
public:
	__fastcall virtual TSMEGrouping(Classes::TCollection* Collection);
	__fastcall virtual ~TSMEGrouping(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	bool __fastcall GroupIsChanged(void);
	
__published:
	__property AnsiString Caption = {read=FCaption, write=FCaption};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor Color = {read=FColor, write=FColor, default=12632256};
	__property AnsiString Expression = {read=FExpression, write=FExpression};
};


class DELPHICLASS TSMEGroupings;
class PASCALIMPLEMENTATION TSMEGroupings : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
public:
	TSMEGrouping* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TComponent* FSMEControl;
	TSMEGrouping* __fastcall GetGrouping(int Index);
	void __fastcall SetGrouping(int Index, TSMEGrouping* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TSMEGroupings(Classes::TComponent* SMECntrl);
	HIDESBASE TSMEGrouping* __fastcall Add(void);
	void __fastcall InitPrevDataValues(void);
	__property TSMEGrouping* Items[int Index] = {read=GetGrouping, write=SetGrouping/*, default*/};
	__property Classes::TComponent* SMEControl = {read=FSMEControl};
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TSMEGroupings(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TSMEMeasure { emPoint, emInch, emCentimeters, emPicas };
#pragma option pop

#pragma option push -b-
enum TSMEOrientation { emDefault, emPortrait, emLandscape };
#pragma option pop

class DELPHICLASS TSMEPageSetup;
class PASCALIMPLEMENTATION TSMEPageSetup : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TSMEMeasure FMeasure;
	bool FUseDefault;
	float FTopMargin;
	float FBottomMargin;
	float FLeftMargin;
	float FRightMargin;
	int FZoom;
	int FFitToPagesWide;
	int FFitToPagesTall;
	float FTableWidth;
	TSMEOrientation FOrientation;
	
public:
	__fastcall virtual TSMEPageSetup(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TSMEMeasure Measure = {read=FMeasure, write=FMeasure, default=0};
	__property bool UseDefault = {read=FUseDefault, write=FUseDefault, default=1};
	__property float TopMargin = {read=FTopMargin, write=FTopMargin};
	__property float BottomMargin = {read=FBottomMargin, write=FBottomMargin};
	__property float LeftMargin = {read=FLeftMargin, write=FLeftMargin};
	__property float RightMargin = {read=FRightMargin, write=FRightMargin};
	__property int Zoom = {read=FZoom, write=FZoom, default=100};
	__property int FitToPagesWide = {read=FFitToPagesWide, write=FFitToPagesWide, default=1};
	__property int FitToPagesTall = {read=FFitToPagesTall, write=FFitToPagesTall, default=1};
	__property float TableWidth = {read=FTableWidth, write=FTableWidth};
	__property TSMEOrientation Orientation = {read=FOrientation, write=FOrientation, default=0};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSMEPageSetup(void) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TSMEGetNext)(System::TObject* Sender, bool &Abort);

typedef void __fastcall (__closure *TSMEGetCount)(System::TObject* Sender, int &Count);

typedef void __fastcall (__closure *TSMEGetValue)(System::TObject* Sender, TSMEColumn* Column, Variant &Value);

typedef TMetaClass* TSMECustomDataEngineClass;

class DELPHICLASS TSMECustomDataEngine;
class PASCALIMPLEMENTATION TSMECustomDataEngine : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	bool FSelectedRecords;
	Classes::TNotifyEvent FOnFirst;
	TSMEGetNext FOnNext;
	TSMEGetCount FOnCount;
	Classes::TNotifyEvent FOnBeforeExecute;
	Classes::TNotifyEvent FOnAfterExecute;
	Classes::TNotifyEvent FOnFillColumns;
	TSMEGetValue FOnGetValue;
	int FLevel;
	
protected:
	bool IsCanceled;
	
public:
	virtual bool __fastcall SelectedRecordIsSupported(void);
	virtual void __fastcall EnableControls(void);
	virtual void __fastcall DisableControls(void);
	virtual void __fastcall SavePosition(void);
	virtual void __fastcall RestorePosition(void);
	virtual void __fastcall FillColumns(TSMEColumns* Columns, TSMEColumnBands* Bands, bool RightToLeft);
	virtual bool __fastcall IsDataRow(int Index);
	virtual bool __fastcall Eof(void);
	virtual void __fastcall First(void);
	virtual void __fastcall Next(void);
	virtual Variant __fastcall GetFieldValue(TSMEColumn* Column);
	virtual void __fastcall ApplyCellColors(int ARow, int ACol, Classes::TAlignment &al, Graphics::TFont* &fnt, Graphics::TColor &AColor);
	virtual int __fastcall RecordCount(void);
	virtual Db::TFieldType __fastcall DataTypeByColumn(TSMEColumn* Column);
	virtual bool __fastcall RequiredByColumn(TSMEColumn* Column);
	virtual bool __fastcall ReadOnlyByColumn(TSMEColumn* Column);
	virtual Db::TField* __fastcall FindFieldByColumn(TSMEColumn* Column);
	__property bool SelectedRecords = {read=FSelectedRecords, write=FSelectedRecords, nodefault};
	__property int Level = {read=FLevel, write=FLevel, default=0};
	
__published:
	__property Classes::TNotifyEvent OnFirst = {read=FOnFirst, write=FOnFirst};
	__property TSMEGetNext OnNext = {read=FOnNext, write=FOnNext};
	__property TSMEGetCount OnCount = {read=FOnCount, write=FOnCount};
	__property Classes::TNotifyEvent OnBeforeExecute = {read=FOnBeforeExecute, write=FOnBeforeExecute};
	__property Classes::TNotifyEvent OnAfterExecute = {read=FOnAfterExecute, write=FOnAfterExecute};
	__property Classes::TNotifyEvent OnFillColumns = {read=FOnFillColumns, write=FOnFillColumns};
	__property TSMEGetValue OnGetValue = {read=FOnGetValue, write=FOnGetValue};
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TSMECustomDataEngine(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TSMECustomDataEngine(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSMEVirtualDataEngine;
class PASCALIMPLEMENTATION TSMEVirtualDataEngine : public TSMECustomDataEngine 
{
	typedef TSMECustomDataEngine inherited;
	
private:
	int intCurRow;
	
public:
	virtual void __fastcall First(void);
	virtual void __fastcall Next(void);
	virtual bool __fastcall Eof(void);
	virtual Variant __fastcall GetFieldValue(TSMEColumn* Column);
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TSMEVirtualDataEngine(Classes::TComponent* AOwner) : TSMECustomDataEngine(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TSMEVirtualDataEngine(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TCellType __fastcall GetValueType(Db::TFieldType DataType, const Variant &Value, bool BlankIfZero);
extern PACKAGE Db::TFieldType __fastcall CellType2FieldType(TCellType ct);

}	/* namespace Smeengine */
using namespace Smeengine;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Smeengine
