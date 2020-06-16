// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Exportds.pas' rev: 10.00

#ifndef ExportdsHPP
#define ExportdsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit
#include <Smestat.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Exportds
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS ESMEInvalidPropertyException;
class PASCALIMPLEMENTATION ESMEInvalidPropertyException : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall ESMEInvalidPropertyException(const AnsiString Msg) : Sysutils::Exception(Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESMEInvalidPropertyException(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESMEInvalidPropertyException(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESMEInvalidPropertyException(int Ident, System::TVarRec const * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESMEInvalidPropertyException(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESMEInvalidPropertyException(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESMEInvalidPropertyException(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESMEInvalidPropertyException(System::PResStringRec ResStringRec, System::TVarRec const * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESMEInvalidPropertyException(void) { }
	#pragma option pop
	
};


class DELPHICLASS ESMEInvalidFileNameException;
class PASCALIMPLEMENTATION ESMEInvalidFileNameException : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall ESMEInvalidFileNameException(const AnsiString Msg) : Sysutils::Exception(Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESMEInvalidFileNameException(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESMEInvalidFileNameException(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESMEInvalidFileNameException(int Ident, System::TVarRec const * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESMEInvalidFileNameException(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESMEInvalidFileNameException(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESMEInvalidFileNameException(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESMEInvalidFileNameException(System::PResStringRec ResStringRec, System::TVarRec const * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESMEInvalidFileNameException(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TTableTypeExport { teParadox, teDBase, teText, teHTML, teXLS, teExcel, teWord, teSYLK, teDIF, teWKS, teQuattro, teSQL, teXML, teAccess, teClipboard, teRTF, teSPSS, tePDF, teLDIF, teADO, teOpenOffice, teExcel2007, teJSON, teWord2007 };
#pragma option pop

typedef Set<TTableTypeExport, teParadox, teWord2007>  TExportFormatTypes;

#pragma option push -b-
enum TCharacterSet { csANSI_WINDOWS, csASCII_MSDOS, csEBCDIC, csUTF8, csUnicode };
#pragma option pop

typedef AnsiString ExportDS__3[5];

#pragma option push -b-
enum TSMEStyle { esNormal, esPriceList, esMSMoney, esBrick, esDesert, esEggplant, esLilac, esMaple, esMarine, esRose, esSpruce, esWheat };
#pragma option pop

class DELPHICLASS TSMExportStyle;
class PASCALIMPLEMENTATION TSMExportStyle : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TSMEStyle FStyle;
	Graphics::TColor FOddColor;
	Graphics::TColor FEvenColor;
	void __fastcall SetStyle(TSMEStyle Value);
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TSMEStyle Style = {read=FStyle, write=SetStyle, nodefault};
	__property Graphics::TColor OddColor = {read=FOddColor, write=FOddColor, nodefault};
	__property Graphics::TColor EvenColor = {read=FEvenColor, write=FEvenColor, nodefault};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSMExportStyle(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TSMExportStyle(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


#pragma option push -b-
enum TSMEDateOrder { doMDY, doDMY, doYMD, doYDM, doDYM, doMYD };
#pragma option pop

class DELPHICLASS TSMEDataFormats;
class PASCALIMPLEMENTATION TSMEDataFormats : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TSMEDateOrder FDateOrder;
	char FDateSeparator;
	char FTimeSeparator;
	bool FFourDigitYear;
	bool FLeadingZerosInDate;
	char FThousandSeparator;
	char FDecimalSeparator;
	AnsiString FCurrencyString;
	AnsiString FCustomDateTimeFormat;
	AnsiString FBooleanTrue;
	AnsiString FBooleanFalse;
	bool FUseRegionalSettings;
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall LoadRegionalSettings(void);
	AnsiString __fastcall GetDateFormat();
	AnsiString __fastcall GetTimeFormat();
	AnsiString __fastcall GetDateTimeFormat();
	AnsiString __fastcall GetDTSeparator(char Value);
	
__published:
	__property TSMEDateOrder DateOrder = {read=FDateOrder, write=FDateOrder, default=0};
	__property char DateSeparator = {read=FDateSeparator, write=FDateSeparator, nodefault};
	__property char TimeSeparator = {read=FTimeSeparator, write=FTimeSeparator, nodefault};
	__property bool FourDigitYear = {read=FFourDigitYear, write=FFourDigitYear, nodefault};
	__property bool LeadingZerosInDate = {read=FLeadingZerosInDate, write=FLeadingZerosInDate, nodefault};
	__property char ThousandSeparator = {read=FThousandSeparator, write=FThousandSeparator, nodefault};
	__property char DecimalSeparator = {read=FDecimalSeparator, write=FDecimalSeparator, nodefault};
	__property AnsiString CurrencyString = {read=FCurrencyString, write=FCurrencyString};
	__property AnsiString CustomDateTimeFormat = {read=FCustomDateTimeFormat, write=FCustomDateTimeFormat};
	__property AnsiString BooleanTrue = {read=FBooleanTrue, write=FBooleanTrue};
	__property AnsiString BooleanFalse = {read=FBooleanFalse, write=FBooleanFalse};
	__property bool UseRegionalSettings = {read=FUseRegionalSettings, write=FUseRegionalSettings, nodefault};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSMEDataFormats(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TSMEDataFormats(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TSMESendTo;
class PASCALIMPLEMENTATION TSMESendTo : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FEMailRecipient;
	AnsiString FEMailCC;
	AnsiString FEMailBCC;
	AnsiString FEMailSubject;
	AnsiString FEMailBody;
	bool FEMailOpen;
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property AnsiString EMailRecipient = {read=FEMailRecipient, write=FEMailRecipient};
	__property AnsiString EMailCC = {read=FEMailCC, write=FEMailCC};
	__property AnsiString EMailBCC = {read=FEMailBCC, write=FEMailBCC};
	__property AnsiString EMailSubject = {read=FEMailSubject, write=FEMailSubject};
	__property AnsiString EMailBody = {read=FEMailBody, write=FEMailBody};
	__property bool EMailOpenBeforeSend = {read=FEMailOpen, write=FEMailOpen, default=1};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSMESendTo(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TSMESendTo(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


typedef AnsiString TSMEAbout;

typedef void __fastcall (__closure *TSMEBeforeRecordEvent)(System::TObject* Sender, bool &Accept);

typedef void __fastcall (__closure *TSMEAfterRecordEvent)(System::TObject* Sender, bool &Abort);

typedef void __fastcall (__closure *TGetRowHeightEvent)(System::TObject* Sender, int ARow, int &ARowHeight);

typedef void __fastcall (__closure *TGetCellParamsEvent)(System::TObject* Sender, Db::TField* Field, AnsiString &Text, Graphics::TFont* AFont, Classes::TAlignment &Alignment, Graphics::TColor &Background, Smeengine::TCellType &CellType);

typedef void __fastcall (__closure *TSMEGetLanguageStringEvent)(System::TObject* Sender, int id, AnsiString &Text);

typedef void __fastcall (__closure *TSMEGetNextSelected)(System::TObject* Sender, int Index, void * &Selected);

typedef void __fastcall (__closure *TSMEGetSelectedCount)(System::TObject* Sender, int &Count);

typedef void __fastcall (__closure *TSMESpecificationEvent)(System::TObject* Sender, AnsiString &AFileName);

typedef void __fastcall (__closure *TSMEGetFileName)(System::TObject* Sender, int CurFileNumber, AnsiString &AFileName);

typedef void __fastcall (__closure *TSMEProgress)(System::TObject* Sender, int CurValue, int MaxValue, bool &Abort);

#pragma option push -b-
enum TColumnSource { csDBGrid, csDataSet, csDataEngine };
#pragma option pop

#pragma option push -b-
enum TSMELayout { elColumnar, elReversedColumnar, elTabularForm };
#pragma option pop

#pragma option push -b-
enum TActionAfterExport { aeNone, aeOpenView, aeEMail };
#pragma option pop

#pragma option push -b-
enum TSMOption { soFieldMask, soShowMessage, soBlankRowAfterCaptions, soMergeData, soWaitCursor, soDisableControls, soUseFieldNameAsCaption, soColLines, soRowLines, soColorsFonts, soExportBlankValues, soExportBands, soExportInvisibleFields, soAutoCloseStatistic, soReprintTitleForEveryRow };
#pragma option pop

typedef Set<TSMOption, soFieldMask, soReprintTitleForEveryRow>  TSMOptions;

#pragma option push -b-
enum TSMEDataLevelOption { dloShowCaption, dloEmbededInParentLevel, dloOutlineLevel, dloCollapsedLevel, dloReprintTitles, dloAddTitle };
#pragma option pop

typedef Set<TSMEDataLevelOption, dloShowCaption, dloAddTitle>  TSMEDataLevelOptions;

class DELPHICLASS TSMEDataLevel;
class DELPHICLASS TSMEDataLevels;
class DELPHICLASS TSMECustomBaseComponent;
class DELPHICLASS TSMEStatistic;
#pragma option push -b-
enum TSMEResult { erInProgress, erCompleted, erCanceled, erFailed };
#pragma option pop

#pragma option push -b-
enum TSMESection { esHeader, esBand, esTitle, esData, esFooter, esDetail };
#pragma option pop

class PASCALIMPLEMENTATION TSMEStatistic : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	int FTotalCount;
	int FTotalErrors;
	int FUpdateStep;
	TSMEResult FResult;
	int FCurrentRow;
	int FCurrentCol;
	TSMESection FCurrentSection;
	int FCurrentDataLevel;
	int FCurrentRowHeight;
	
public:
	TSMEDataLevel* CurrentDetailLevel;
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property int CurrentRow = {read=FCurrentRow, write=FCurrentRow, nodefault};
	__property int CurrentCol = {read=FCurrentCol, write=FCurrentCol, nodefault};
	__property TSMESection CurrentSection = {read=FCurrentSection, write=FCurrentSection, nodefault};
	__property int CurrentDataLevel = {read=FCurrentDataLevel, write=FCurrentDataLevel, nodefault};
	
__published:
	__property int TotalCount = {read=FTotalCount, write=FTotalCount, stored=false, nodefault};
	__property int TotalErrors = {read=FTotalErrors, write=FTotalErrors, stored=false, nodefault};
	__property int UpdateStep = {read=FUpdateStep, write=FUpdateStep, default=1};
	__property TSMEResult Result = {read=FResult, write=FResult, stored=false, nodefault};
	__property int CurrentRowHeight = {read=FCurrentRowHeight, write=FCurrentRowHeight, nodefault};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSMEStatistic(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TSMEStatistic(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TSMECustomBaseComponent : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	AnsiString FAbout;
	TSMOptions FOptions;
	AnsiString FTitleStatus;
	TCharacterSet FCharacterSet;
	int FRowsPerFile;
	bool FRightToLeft;
	bool FSelectedRecord;
	bool FAddTitle;
	AnsiString FKeyGenerator;
	bool FAnimatedStatus;
	bool FBlankIfZero;
	Classes::TStrings* FHeader;
	Classes::TStrings* FFooter;
	TSMExportStyle* FExportStyle;
	TSMEDataFormats* FDataFormats;
	TSMESendTo* FSendTo;
	bool FExportIfEmpty;
	Smeengine::TSMEPageSetup* FPageSetup;
	TSMEBeforeRecordEvent FOnBeforeRecord;
	TSMEAfterRecordEvent FOnAfterRecord;
	TGetRowHeightEvent FOnGetRowHeight;
	TGetCellParamsEvent FOnGetCellParams;
	TSMEGetLanguageStringEvent FOnGetLanguageString;
	Classes::TNotifyEvent FOnBeforeExecute;
	Classes::TNotifyEvent FOnAfterExecute;
	TSMEGetFileName FOnGetFileName;
	TSMEProgress FOnProgress;
	AnsiString FSeparator;
	AnsiString FTextQualifier;
	AnsiString FRecordSeparator;
	bool FFixed;
	bool FAutoFitColumns;
	AnsiString FTableName;
	TTableTypeExport FTableType;
	TSMEStatistic* FStatistic;
	void __fastcall SetPageSetup(Smeengine::TSMEPageSetup* Value);
	void __fastcall SetExportStyle(TSMExportStyle* Value);
	void __fastcall SetSendTo(TSMESendTo* Value);
	Classes::TStrings* __fastcall GetHeader(void);
	void __fastcall SetHeader(Classes::TStrings* Value);
	Classes::TStrings* __fastcall GetFooter(void);
	void __fastcall SetFooter(Classes::TStrings* Value);
	int __fastcall GetExportedRecordCount(void);
	TSMEResult __fastcall GetExportResult(void);
	void __fastcall SetAbout(const AnsiString Value);
	
protected:
	virtual void __fastcall SetTableType(TTableTypeExport Value);
	Smeengine::TCellType __fastcall GetFieldType(Db::TField* Field, bool BlankIfZero);
	virtual int __fastcall MappingVersion(void);
	Variant __fastcall GetSysValue(const AnsiString AName);
	void __fastcall AssignStyle(int ARow, Graphics::TColor &color);
	virtual void __fastcall Prepare(void);
	AnsiString __fastcall AddZeros(const AnsiString Source, int Len, bool IsLeading);
	virtual AnsiString __fastcall GetFieldStr(Db::TField* Field);
	AnsiString __fastcall GetLanguageString(int id);
	void __fastcall WriteBOMToStream(Classes::TStream* AStream);
	__property Classes::TStrings* Header = {read=GetHeader, write=SetHeader};
	__property Classes::TStrings* Footer = {read=GetFooter, write=SetFooter};
	__property int RowsPerFile = {read=FRowsPerFile, write=FRowsPerFile, default=0};
	__property TTableTypeExport TableType = {read=FTableType, write=SetTableType, nodefault};
	
public:
	__fastcall virtual TSMECustomBaseComponent(Classes::TComponent* AOwner);
	__fastcall virtual ~TSMECustomBaseComponent(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall AboutSME(void);
	int __fastcall SendMail(const AnsiString AFileName, const AnsiString body);
	virtual AnsiString __fastcall Extension();
	int __fastcall GetTitleRowCount(void);
	__property bool AddTitle = {read=FAddTitle, write=FAddTitle, default=0};
	__property TCharacterSet CharacterSet = {read=FCharacterSet, write=FCharacterSet, nodefault};
	__property TGetRowHeightEvent OnGetRowHeight = {read=FOnGetRowHeight, write=FOnGetRowHeight};
	__property TGetCellParamsEvent OnGetCellParams = {read=FOnGetCellParams, write=FOnGetCellParams};
	__property int ExportedRecordCount = {read=GetExportedRecordCount, nodefault};
	__property TSMEResult ExportResult = {read=GetExportResult, nodefault};
	__property Smeengine::TSMEPageSetup* PageSetup = {read=FPageSetup, write=SetPageSetup};
	__property TSMExportStyle* ExportStyle = {read=FExportStyle, write=SetExportStyle};
	__property AnsiString TableName = {read=FTableName, write=FTableName};
	__property AnsiString TextQualifier = {read=FTextQualifier, write=FTextQualifier};
	__property AnsiString Separator = {read=FSeparator, write=FSeparator};
	__property AnsiString RecordSeparator = {read=FRecordSeparator, write=FRecordSeparator};
	__property bool Fixed = {read=FFixed, write=FFixed, nodefault};
	__property bool AutoFitColumns = {read=FAutoFitColumns, write=FAutoFitColumns, default=0};
	
__published:
	__property AnsiString About = {read=FAbout, write=SetAbout, stored=false};
	__property bool AnimatedStatus = {read=FAnimatedStatus, write=FAnimatedStatus, default=1};
	__property TSMEDataFormats* DataFormats = {read=FDataFormats, write=FDataFormats};
	__property AnsiString KeyGenerator = {read=FKeyGenerator, write=FKeyGenerator};
	__property bool SelectedRecord = {read=FSelectedRecord, write=FSelectedRecord, default=0};
	__property bool BlankIfZero = {read=FBlankIfZero, write=FBlankIfZero, default=0};
	__property TSMOptions Options = {read=FOptions, write=FOptions, default=8626};
	__property AnsiString TitleStatus = {read=FTitleStatus, write=FTitleStatus};
	__property bool RightToLeft = {read=FRightToLeft, write=FRightToLeft, default=0};
	__property TSMESendTo* SendTo = {read=FSendTo, write=SetSendTo};
	__property bool ExportIfEmpty = {read=FExportIfEmpty, write=FExportIfEmpty, default=1};
	__property TSMEStatistic* Statistic = {read=FStatistic, write=FStatistic};
	__property TSMEGetLanguageStringEvent OnGetLanguageString = {read=FOnGetLanguageString, write=FOnGetLanguageString};
	__property TSMEBeforeRecordEvent OnBeforeRecord = {read=FOnBeforeRecord, write=FOnBeforeRecord};
	__property TSMEAfterRecordEvent OnAfterRecord = {read=FOnAfterRecord, write=FOnAfterRecord};
	__property Classes::TNotifyEvent OnBeforeExecute = {read=FOnBeforeExecute, write=FOnBeforeExecute};
	__property Classes::TNotifyEvent OnAfterExecute = {read=FOnAfterExecute, write=FOnAfterExecute};
	__property TSMEGetFileName OnGetFileName = {read=FOnGetFileName, write=FOnGetFileName};
	__property TSMEProgress OnProgress = {read=FOnProgress, write=FOnProgress};
};


class PASCALIMPLEMENTATION TSMEDataLevels : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
public:
	TSMEDataLevel* operator[](int Index) { return Items[Index]; }
	
private:
	TSMECustomBaseComponent* FSMEControl;
	TSMEDataLevel* __fastcall GetDataLevel(int Index);
	void __fastcall SetDataLevel(int Index, TSMEDataLevel* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TSMEDataLevels(TSMECustomBaseComponent* SMECntrl);
	HIDESBASE TSMEDataLevel* __fastcall Add(void);
	__property TSMEDataLevel* Items[int Index] = {read=GetDataLevel, write=SetDataLevel/*, default*/};
	__property TSMECustomBaseComponent* SMEControl = {read=FSMEControl};
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TSMEDataLevels(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TSMEDataLevel : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool FIsWWDBGrid;
	bool FIsTMSDBGrid;
	AnsiString FCaption;
	int FShiftCount;
	Smeengine::TSMEColumns* FColumns;
	Smeengine::TSMEGroupings* FGroupings;
	Smeengine::TSMEColumnBands* FBands;
	Controls::TControl* FDBGrid;
	Db::TDataSet* FDataSet;
	Smeengine::TSMECustomDataEngine* FDataEngine;
	TColumnSource FColumnSource;
	TSMELayout FLayout;
	bool FParentLayout;
	TSMEDataLevelOptions FOptions;
	TSMEDataLevels* FDetailSources;
	void __fastcall SetColumns(Smeengine::TSMEColumns* Value);
	void __fastcall SetGroupings(Smeengine::TSMEGroupings* Value);
	void __fastcall SetBands(Smeengine::TSMEColumnBands* Value);
	void __fastcall SetDBGrid(Controls::TControl* AValue);
	void __fastcall SetDataSet(Db::TDataSet* AValue);
	void __fastcall SetDataEngine(Smeengine::TSMECustomDataEngine* AValue);
	void __fastcall SetDetailSources(TSMEDataLevels* Value);
	
protected:
	TSMECustomBaseComponent* __fastcall GetSMEComponent(void);
	
public:
	bool IsCustomColumns;
	Smeengine::TSMECustomDataEngine* SourceDataEngine;
	void __fastcall CreateSourceDataEngine(void);
	void __fastcall DestroySourceDataEngine(void);
	__fastcall virtual TSMEDataLevel(Classes::TCollection* Collection);
	__fastcall virtual ~TSMEDataLevel(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property bool IsWWDBGrid = {read=FIsWWDBGrid, nodefault};
	__property bool IsTMSDBGrid = {read=FIsTMSDBGrid, nodefault};
	__property Smeengine::TSMEGroupings* Groupings = {read=FGroupings, write=SetGroupings};
	
__published:
	__property AnsiString Caption = {read=FCaption, write=FCaption};
	__property int ShiftCount = {read=FShiftCount, write=FShiftCount, default=1};
	__property Smeengine::TSMEColumns* Columns = {read=FColumns, write=SetColumns};
	__property Smeengine::TSMEColumnBands* Bands = {read=FBands, write=SetBands};
	__property Controls::TControl* DBGrid = {read=FDBGrid, write=SetDBGrid};
	__property Db::TDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property Smeengine::TSMECustomDataEngine* DataEngine = {read=FDataEngine, write=SetDataEngine};
	__property TColumnSource ColumnSource = {read=FColumnSource, write=FColumnSource, nodefault};
	__property TSMELayout Layout = {read=FLayout, write=FLayout, default=0};
	__property bool ParentLayout = {read=FParentLayout, write=FParentLayout, default=1};
	__property TSMEDataLevelOptions Options = {read=FOptions, write=FOptions, default=54};
	__property TSMEDataLevels* DetailSources = {read=FDetailSources, write=SetDetailSources};
};


class DELPHICLASS TSMExportBaseComponent;
class PASCALIMPLEMENTATION TSMExportBaseComponent : public TSMECustomBaseComponent 
{
	typedef TSMECustomBaseComponent inherited;
	
private:
	TActionAfterExport FActionAfterExport;
	Controls::TControl* FDBGrid;
	Db::TDataSet* FDataSet;
	Smeengine::TSMECustomDataEngine* FDataEngine;
	TColumnSource FColumnSource;
	TSMEDataLevels* FDetailSources;
	Graphics::TFont* FDefaultFont;
	AnsiString FFileName;
	TSMEGetNextSelected FOnGetNextSelected;
	TSMEGetSelectedCount FOnGetSelectedCount;
	TSMESpecificationEvent FOnBeforeLoadSpecification;
	TSMESpecificationEvent FOnAfterLoadSpecification;
	TSMESpecificationEvent FOnBeforeSaveSpecification;
	TSMESpecificationEvent FOnAfterSaveSpecification;
	AnsiString FSpecificationDir;
	Smeengine::TSMEColumns* FColumns;
	Smeengine::TSMEGroupings* FGroupings;
	Smeengine::TSMEColumnBands* FBands;
	TSMELayout FLayout;
	int FLastExportColumnIndex;
	int intRecordCount;
	bool IsCustomColumns;
	bool IsAborted;
	char oldDecimalSeparator;
	char oldDateSeparator;
	char oldTimeSeparator;
	char oldThousandSeparator;
	AnsiString oldCurrencyString;
	void __fastcall SetSpecificationDir(AnsiString Value);
	void __fastcall SetColumns(Smeengine::TSMEColumns* Value);
	void __fastcall SetGroupings(Smeengine::TSMEGroupings* Value);
	void __fastcall SetBands(Smeengine::TSMEColumnBands* Value);
	void __fastcall SetDBGrid(Controls::TControl* AValue);
	void __fastcall SetDataSet(Db::TDataSet* AValue);
	void __fastcall SetDataEngine(Smeengine::TSMECustomDataEngine* AValue);
	void __fastcall SetDetailSources(TSMEDataLevels* Value);
	void __fastcall SetDefaultFont(Graphics::TFont* Value);
	
protected:
	bool boolAborted;
	Smestat::TfrmSMEProcess* frmSMEProcess;
	bool FIsWWDBGrid;
	bool FIsTMSDBGrid;
	Smeengine::TSMECustomDataEngine* SourceDataEngine;
	virtual void __fastcall CreateSourceDataEngine(void);
	virtual void __fastcall DestroySourceDataEngine(void);
	void __fastcall CreateDirIfNotExists(const AnsiString s);
	bool __fastcall DetailExists(void);
	bool __fastcall CreateProgressDlg(AnsiString strCaption, AnsiString strMessage, AnsiString strBtnCaption, int MinValue, int MaxValue, int Progress);
	bool __fastcall DestroyProgressDlg(void);
	bool __fastcall UpdateProgressDlg(AnsiString strMessage, int Progress);
	bool __fastcall ProgressCanceled(void);
	void __fastcall SetProgressCanceled(bool Value);
	virtual void __fastcall InternalBeforeProcess(void);
	virtual void __fastcall InternalAfterProcess(void);
	virtual void __fastcall SetTableType(TTableTypeExport Value);
	virtual void __fastcall AfterExport(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void * __fastcall GetNextSelected(int i);
	int __fastcall GetSelectedCount(void);
	bool __fastcall IsMemoColumnExist(void);
	bool __fastcall IsTrialCount(int i);
	__property TSMELayout Layout = {read=FLayout, write=FLayout, default=0};
	
public:
	__fastcall virtual TSMExportBaseComponent(Classes::TComponent* AOwner);
	__fastcall virtual ~TSMExportBaseComponent(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall BuildDefaultColumns(void);
	void __fastcall Execute(void);
	Db::TDataSet* __fastcall GetDS(void);
	/*         class method */ static AnsiString __fastcall GetDefExt(TMetaClass* vmt, int intIndex);
	virtual void __fastcall ApplyDefaultFont(Graphics::TFont* AFont, bool ReadOwner);
	void __fastcall LoadSpecification(AnsiString strFileName);
	void __fastcall SaveSpecification(AnsiString SpecName, AnsiString FileName, bool ShowDialog);
	virtual void __fastcall LoadSpecificationFromStrings(Classes::TStrings* lstSpec);
	virtual void __fastcall LoadSpecificationFromStream(Classes::TStream* Stream);
	virtual void __fastcall SaveSpecificationToStream(Classes::TStream* Stream, const AnsiString SpecName);
	virtual void __fastcall SaveSpecificationToStringList(Classes::TStrings* List, const AnsiString SpecName);
	__property bool IsWWDBGrid = {read=FIsWWDBGrid, nodefault};
	__property bool IsTMSDBGrid = {read=FIsTMSDBGrid, nodefault};
	__property TActionAfterExport ActionAfterExport = {read=FActionAfterExport, write=FActionAfterExport, default=0};
	__property AnsiString FileName = {read=FFileName, write=FFileName};
	__property int LastExportColumnIndex = {read=FLastExportColumnIndex, nodefault};
	__property TSMEDataLevels* DetailSources = {read=FDetailSources, write=SetDetailSources};
	__property Smeengine::TSMEGroupings* Groupings = {read=FGroupings, write=SetGroupings};
	
__published:
	__property Smeengine::TSMEColumns* Columns = {read=FColumns, write=SetColumns};
	__property Smeengine::TSMEColumnBands* Bands = {read=FBands, write=SetBands};
	__property Graphics::TFont* DefaultFont = {read=FDefaultFont, write=SetDefaultFont};
	__property Controls::TControl* DBGrid = {read=FDBGrid, write=SetDBGrid};
	__property Db::TDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property Smeengine::TSMECustomDataEngine* DataEngine = {read=FDataEngine, write=SetDataEngine};
	__property TColumnSource ColumnSource = {read=FColumnSource, write=FColumnSource, default=0};
	__property AnsiString SpecificationDir = {read=FSpecificationDir, write=SetSpecificationDir};
	__property TSMEGetNextSelected OnGetNextSelected = {read=FOnGetNextSelected, write=FOnGetNextSelected};
	__property TSMEGetSelectedCount OnGetSelectedCount = {read=FOnGetSelectedCount, write=FOnGetSelectedCount};
	__property TSMESpecificationEvent OnBeforeLoadSpecification = {read=FOnBeforeLoadSpecification, write=FOnBeforeLoadSpecification};
	__property TSMESpecificationEvent OnAfterLoadSpecification = {read=FOnAfterLoadSpecification, write=FOnAfterLoadSpecification};
	__property TSMESpecificationEvent OnBeforeSaveSpecification = {read=FOnBeforeSaveSpecification, write=FOnBeforeSaveSpecification};
	__property TSMESpecificationEvent OnAfterSaveSpecification = {read=FOnAfterSaveSpecification, write=FOnAfterSaveSpecification};
};


//-- var, const, procedure ---------------------------------------------------
#define SMEVersion "5.0 (b06)"
extern PACKAGE TExportFormatTypes AllFormats;
extern PACKAGE AnsiString GeneratorVer;
extern PACKAGE AnsiString arrCharacterSet[5];
static const Shortint SMEDefaultRowHeight = 0x14;
extern PACKAGE Graphics::TColor arrStyleColor[12][2];
static const Graphics::TColor clMoneyGreen = 12639424;
static const Graphics::TColor clSkyBlue = 16776176;
extern PACKAGE void __fastcall AboutSMExport(void);
extern PACKAGE AnsiString __fastcall GetFileNameByGraphic(const AnsiString FileName, int intCurPicFile, Graphics::TPicture* pic);
extern PACKAGE Classes::TList* __fastcall GetPropAsSelectedList(Classes::TComponent* comp);
extern PACKAGE AnsiString __fastcall Translate(const AnsiString s, bool IsEncrypt);
extern PACKAGE AnsiString __fastcall ReplaceHTMLSystemChars(const AnsiString s, TTableTypeExport ExportType);
extern PACKAGE AnsiString __fastcall TblName(Db::TDataSet* DS);
extern PACKAGE bool __fastcall IsNumericField(Db::TField* Field);
extern PACKAGE bool __fastcall IsStringField(Db::TField* Field);
extern PACKAGE AnsiString __fastcall UECode(bool WinToDOS, AnsiString s);
extern PACKAGE AnsiString __fastcall EBCDICCode(AnsiString s);
extern PACKAGE AnsiString __fastcall PadLSpace(AnsiString strStr, int intLen);
extern PACKAGE AnsiString __fastcall PadCSpace(AnsiString strStr, int intLen);
extern PACKAGE AnsiString __fastcall PadRSpace(AnsiString strStr, int intLen);

}	/* namespace Exportds */
using namespace Exportds;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Exportds
