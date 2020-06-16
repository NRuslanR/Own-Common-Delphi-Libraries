// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Smewiz.pas' rev: 10.00

#ifndef SmewizHPP
#define SmewizHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Checklst.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Exportds.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit
#include <Sme2sql.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smewiz
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TSMEFileCategory { fceDocument, fceDatabase, fceSpreadsheet, fceWEB, fceOther };
#pragma option pop

class DELPHICLASS TSMECategories;
class PASCALIMPLEMENTATION TSMECategories : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FShowCategories;
	Graphics::TColor FBackColor;
	Graphics::TFont* FTextFont;
	Exportds::TExportFormatTypes FDocumentFormats;
	Exportds::TExportFormatTypes FDatabaseFormats;
	Exportds::TExportFormatTypes FSpreadsheetFormats;
	Exportds::TExportFormatTypes FWEBFormats;
	Exportds::TExportFormatTypes FOtherFormats;
	
protected:
	Graphics::TFont* __fastcall GetTextFont(void);
	void __fastcall SetTextFont(Graphics::TFont* Value);
	
public:
	__fastcall virtual TSMECategories(void);
	__fastcall virtual ~TSMECategories(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool ShowCategories = {read=FShowCategories, write=FShowCategories, default=1};
	__property Graphics::TColor BackColor = {read=FBackColor, write=FBackColor, default=12935473};
	__property Graphics::TFont* TextFont = {read=GetTextFont, write=SetTextFont};
	__property Exportds::TExportFormatTypes DocumentFormats = {read=FDocumentFormats, write=FDocumentFormats, default=9617476};
	__property Exportds::TExportFormatTypes DatabaseFormats = {read=FDatabaseFormats, write=FDatabaseFormats, default=534531};
	__property Exportds::TExportFormatTypes SpreadsheetFormats = {read=FSpreadsheetFormats, write=FSpreadsheetFormats, default=2164272};
	__property Exportds::TExportFormatTypes WEBFormats = {read=FWEBFormats, write=FWEBFormats, default=4198408};
	__property Exportds::TExportFormatTypes OtherFormats = {read=FOtherFormats, write=FOtherFormats, default=262528};
};


typedef void __fastcall (__closure *TSMEGetSpecificationsEvent)(System::TObject* Sender, Classes::TStrings* lstFiles);

typedef void __fastcall (__closure *TSMESaveSpecNotifyEvent)(System::TObject* Sender, const AnsiString Caption, const AnsiString FileName);

typedef void __fastcall (__closure *TSMECloseEvent)(System::TObject* Sender, Controls::TModalResult &Action);

typedef void __fastcall (__closure *TSMEStepChangeEvent)(System::TObject* Sender, bool &Allow);

#pragma option push -b-
enum TSMEDirection { edForward, edBackward };
#pragma option pop

typedef AnsiString SMEWiz__3[10];

typedef AnsiString SMEWiz__4[10];

class DELPHICLASS TfrmSMEWizard;
class DELPHICLASS TSMEWizardDlg;
class DELPHICLASS TSMEUserAccess;
#pragma option push -b-
enum TSMERestriction { erDisabled, erReadOnly, erReadWrite };
#pragma option pop

class PASCALIMPLEMENTATION TSMEUserAccess : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FSpecification;
	bool FSpecificationSave;
	bool FSpecificationLoad;
	bool FSpecificationDelete;
	TSMERestriction FTableType;
	TSMERestriction FSourceFileName;
	TSMERestriction FFieldMapping;
	TSMERestriction FActionAfter;
	TSMERestriction FTextType;
	TSMERestriction FFieldDelimiter;
	TSMERestriction FTextQualifier;
	TSMERestriction FRecordSeparator;
	TSMERestriction FHeader;
	TSMERestriction FFooter;
	TSMERestriction FLayout;
	TSMERestriction FColorStyle;
	TSMERestriction FAccessVersion;
	TSMERestriction FKeyGenerator;
	TSMERestriction FSQLOptions;
	TSMERestriction FDataFormats;
	TSMERestriction FPageOrientation;
	TSMERestriction FPageMargins;
	
public:
	__fastcall virtual TSMEUserAccess(Classes::TComponent* AOwner);
	
__published:
	__property bool Specification = {read=FSpecification, write=FSpecification, nodefault};
	__property TSMERestriction TableType = {read=FTableType, write=FTableType, default=2};
	__property TSMERestriction SourceFileName = {read=FSourceFileName, write=FSourceFileName, default=2};
	__property TSMERestriction FieldMapping = {read=FFieldMapping, write=FFieldMapping, default=2};
	__property TSMERestriction ActionAfter = {read=FActionAfter, write=FActionAfter, default=2};
	__property TSMERestriction TextType = {read=FTextType, write=FTextType, default=2};
	__property TSMERestriction FieldDelimiter = {read=FFieldDelimiter, write=FFieldDelimiter, default=2};
	__property TSMERestriction TextQualifier = {read=FTextQualifier, write=FTextQualifier, default=2};
	__property TSMERestriction RecordSeparator = {read=FRecordSeparator, write=FRecordSeparator, default=2};
	__property TSMERestriction Header = {read=FHeader, write=FHeader, default=2};
	__property TSMERestriction Footer = {read=FFooter, write=FFooter, default=2};
	__property TSMERestriction Layout = {read=FLayout, write=FLayout, default=2};
	__property TSMERestriction ColorStyle = {read=FColorStyle, write=FColorStyle, default=2};
	__property TSMERestriction AccessVersion = {read=FAccessVersion, write=FAccessVersion, default=0};
	__property TSMERestriction DataFormats = {read=FDataFormats, write=FDataFormats, default=2};
	__property TSMERestriction SQLOptions = {read=FSQLOptions, write=FSQLOptions, default=2};
	__property TSMERestriction KeyGenerator = {read=FKeyGenerator, write=FKeyGenerator, default=0};
	__property TSMERestriction PageOrientation = {read=FPageOrientation, write=FPageOrientation, default=2};
	__property TSMERestriction PageMargins = {read=FPageMargins, write=FPageMargins, default=2};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSMEUserAccess(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TSMEWizardStyle { wsWindows95, wsWindows2000 };
#pragma option pop

class PASCALIMPLEMENTATION TSMEWizardDlg : public Exportds::TSMExportBaseComponent 
{
	typedef Exportds::TSMExportBaseComponent inherited;
	
private:
	Classes::THelpContext FHelpContext;
	TfrmSMEWizard* FfrmSMEWizard;
	Smeengine::TSMEFieldDisplayFormat FFieldDisplayFormat;
	bool FVisibleColumnsOnly;
	Exportds::TExportFormatTypes FFormats;
	AnsiString FTitle;
	Graphics::TPicture* FPicture;
	bool FShowPicture;
	Graphics::TIcon* FIcon;
	TSMECategories* FCategories;
	TSMEUserAccess* FUserAccess;
	bool FConfirmCancelExit;
	bool FConfirmFileOverwrite;
	bool FConfirmExecuteStart;
	AnsiString FInitialDir;
	TSMEGetSpecificationsEvent FOnGetSpecifications;
	TSMECloseEvent FCloseEvent;
	TSMEWizardStyle FWizardStyle;
	bool FSetupSpecificationOnly;
	Classes::TNotifyEvent FOnShow;
	TSMEStepChangeEvent FOnStepChange;
	Sme2sql::TSMESQLOptions* FSQLOptions;
	AnsiString FFilterName;
	Sme2sql::TSMESQLOptions* __fastcall GetSQLOptions(void);
	void __fastcall SetSQLOptions(Sme2sql::TSMESQLOptions* Value);
	TSMECategories* __fastcall GetCategories(void);
	void __fastcall SetCategories(TSMECategories* Value);
	TSMEUserAccess* __fastcall GetUserAccess(void);
	void __fastcall SetUserAccess(TSMEUserAccess* Value);
	void __fastcall SaveSpecClick(System::TObject* Sender, const AnsiString Caption, const AnsiString FileName);
	void __fastcall LoadSpecClick(System::TObject* Sender);
	Graphics::TPicture* __fastcall GetPicture(void);
	void __fastcall SetPicture(Graphics::TPicture* Value);
	Graphics::TIcon* __fastcall GetIcon(void);
	void __fastcall SetIcon(Graphics::TIcon* Value);
	AnsiString __fastcall GetCaptionForFormat(Exportds::TTableTypeExport te);
	
protected:
	void __fastcall SetRestrictionToControls(void);
	void __fastcall PropertiesToControls(void);
	void __fastcall CreateCategories(void);
	
public:
	__fastcall virtual TSMEWizardDlg(Classes::TComponent* AOwner);
	__fastcall virtual ~TSMEWizardDlg(void);
	HIDESBASE Controls::TModalResult __fastcall Execute(void);
	void __fastcall ExecuteWithoutDialog(void);
	virtual void __fastcall LoadSpecificationFromStrings(Classes::TStrings* lstSpec);
	virtual void __fastcall SaveSpecificationToStream(Classes::TStream* Stream, const AnsiString SpecName);
	void __fastcall ControlsToProperties(void);
	
__published:
	__property Smeengine::TSMEFieldDisplayFormat FieldDisplayFormat = {read=FFieldDisplayFormat, write=FFieldDisplayFormat, default=0};
	__property bool VisibleColumnsOnly = {read=FVisibleColumnsOnly, write=FVisibleColumnsOnly, default=0};
	__property Classes::THelpContext HelpContext = {read=FHelpContext, write=FHelpContext, default=0};
	__property Exportds::TExportFormatTypes Formats = {read=FFormats, write=FFormats, nodefault};
	__property AnsiString Title = {read=FTitle, write=FTitle};
	__property Graphics::TPicture* Picture = {read=GetPicture, write=SetPicture};
	__property bool ShowPicture = {read=FShowPicture, write=FShowPicture, default=1};
	__property Graphics::TIcon* Icon = {read=GetIcon, write=SetIcon};
	__property TSMECategories* Categories = {read=GetCategories, write=SetCategories};
	__property bool ConfirmCancelExit = {read=FConfirmCancelExit, write=FConfirmCancelExit, default=1};
	__property bool ConfirmFileOverwrite = {read=FConfirmFileOverwrite, write=FConfirmFileOverwrite, default=0};
	__property bool ConfirmExecuteStart = {read=FConfirmExecuteStart, write=FConfirmExecuteStart, default=0};
	__property AnsiString InitialDir = {read=FInitialDir, write=FInitialDir};
	__property TSMEWizardStyle WizardStyle = {read=FWizardStyle, write=FWizardStyle, default=1};
	__property Layout  = {default=0};
	__property RowsPerFile  = {default=0};
	__property TextQualifier ;
	__property Separator ;
	__property RecordSeparator ;
	__property Fixed ;
	__property AutoFitColumns  = {default=0};
	__property TableName ;
	__property TableType ;
	__property ActionAfterExport  = {default=0};
	__property FileName ;
	__property AddTitle  = {default=0};
	__property CharacterSet ;
	__property ExportStyle ;
	__property Header ;
	__property Footer ;
	__property TSMEUserAccess* UserAccess = {read=GetUserAccess, write=SetUserAccess};
	__property bool SetupSpecificationOnly = {read=FSetupSpecificationOnly, write=FSetupSpecificationOnly, default=0};
	__property Sme2sql::TSMESQLOptions* SQLOptions = {read=GetSQLOptions, write=SetSQLOptions};
	__property AnsiString FilterName = {read=FFilterName, write=FFilterName};
	__property OnGetCellParams ;
	__property TSMEGetSpecificationsEvent OnGetSpecifications = {read=FOnGetSpecifications, write=FOnGetSpecifications};
	__property TSMECloseEvent OnClose = {read=FCloseEvent, write=FCloseEvent};
	__property Classes::TNotifyEvent OnShow = {read=FOnShow, write=FOnShow};
	__property TSMEStepChangeEvent OnStepChange = {read=FOnStepChange, write=FOnStepChange};
};


class PASCALIMPLEMENTATION TfrmSMEWizard : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TButton* btnPrev;
	Stdctrls::TButton* btnNext;
	Stdctrls::TButton* btnCancel;
	Stdctrls::TLabel* lblStep;
	Stdctrls::TButton* btnSpecs;
	Extctrls::TImage* imgLogo;
	Menus::TPopupMenu* pmColumns;
	Menus::TMenuItem* miSelectAll;
	Menus::TMenuItem* miUnselectAll;
	Menus::TMenuItem* miInvertSelection;
	Stdctrls::TButton* btnFirst;
	Stdctrls::TButton* btnLast;
	Extctrls::TPanel* pnlDescription;
	Stdctrls::TLabel* lblCaption;
	Stdctrls::TLabel* lblDescription;
	Extctrls::TImage* imgBackground;
	Extctrls::TImage* imgDescription;
	Stdctrls::TLabel* lblStepInfo;
	Menus::TMenuItem* miSeparator;
	Menus::TMenuItem* miInsertSysVar;
	Menus::TMenuItem* miSVRowNo;
	Menus::TMenuItem* miSVColNo;
	Menus::TMenuItem* miSVRecCount;
	Menus::TMenuItem* miSVErrCount;
	Menus::TMenuItem* miSVKeyGenerator;
	Extctrls::TPaintBox* pbLogo;
	Extctrls::TPanel* pnlStep1;
	Extctrls::TRadioGroup* rgTableType;
	Extctrls::TPanel* pnlCategory;
	Forms::TScrollBox* sbCategory;
	Extctrls::TPanel* pnlStep2;
	Stdctrls::TLabel* lblFileOrigin;
	Stdctrls::TComboBox* cbCharacterSet;
	Stdctrls::TCheckBox* cbSelectedRecord;
	Stdctrls::TCheckBox* cbAddTitle;
	Stdctrls::TCheckBox* cbAddBlankRow;
	Stdctrls::TCheckBox* cbBlankIfZero;
	Stdctrls::TCheckBox* cbWithoutFieldMask;
	Extctrls::TPanel* pnlStep3;
	Stdctrls::TRadioButton* rbText1;
	Stdctrls::TRadioButton* rbText2;
	Extctrls::TRadioGroup* rgSeparator;
	Stdctrls::TEdit* edSymbol;
	Stdctrls::TLabel* lblRecSeparator;
	Stdctrls::TComboBox* cbRecSeparator;
	Stdctrls::TComboBox* cbQualifier;
	Stdctrls::TLabel* lblQualifier;
	Extctrls::TPanel* pnlStep4;
	Stdctrls::TCheckBox* chkAddCreateTable;
	Stdctrls::TCheckBox* chkMultiRowInsert;
	Stdctrls::TLabel* lblFieldNameCharset;
	Stdctrls::TComboBox* cbFieldNameCharset;
	Stdctrls::TGroupBox* gbSQL;
	Stdctrls::TLabel* lblCommit;
	Stdctrls::TLabel* lblSQLQuote;
	Stdctrls::TLabel* lblSQLTerm;
	Stdctrls::TEdit* edCommit;
	Stdctrls::TComboBox* cbSQLQuote;
	Stdctrls::TComboBox* cbSQLTerm;
	Stdctrls::TLabel* lblAddCommit;
	Stdctrls::TEdit* edAddCommit;
	Extctrls::TPanel* pnlStep5;
	Stdctrls::TGroupBox* gbFormat;
	Stdctrls::TLabel* lblDateOrder;
	Stdctrls::TLabel* lblDateDelimiter;
	Stdctrls::TLabel* lblTimeDelimiter;
	Stdctrls::TLabel* lblDecimalSymbol;
	Stdctrls::TLabel* lblThousandSymbol;
	Stdctrls::TLabel* lblCurrencyString;
	Stdctrls::TLabel* lblLogical;
	Stdctrls::TComboBox* cbDateOrder;
	Stdctrls::TEdit* edDateDelimiter;
	Stdctrls::TEdit* edTimeDelimiter;
	Stdctrls::TCheckBox* cbFourDigitYear;
	Stdctrls::TCheckBox* cbLeadingZerosInDate;
	Stdctrls::TEdit* edDecimalSymbol;
	Stdctrls::TEdit* edThousandSymbol;
	Stdctrls::TEdit* edCurrencyString;
	Stdctrls::TEdit* edTrue;
	Stdctrls::TEdit* edFalse;
	Extctrls::TPanel* pnlStep6;
	Checklst::TCheckListBox* clbFields;
	Stdctrls::TLabel* lblWidth;
	Stdctrls::TEdit* edWidth;
	Stdctrls::TLabel* lblWidthFix;
	Stdctrls::TGroupBox* gbTitle;
	Stdctrls::TLabel* lblTitleCaption;
	Stdctrls::TLabel* lblTitleAlignment;
	Stdctrls::TLabel* lblTitleColor;
	Stdctrls::TLabel* lblTitleFont;
	Stdctrls::TEdit* edTitleCaption;
	Stdctrls::TEdit* edTitleFont;
	Stdctrls::TComboBox* cbTitleAlignment;
	Stdctrls::TComboBox* SMColorsCBTitle;
	Stdctrls::TButton* btnTitleFont;
	Stdctrls::TGroupBox* gbData;
	Stdctrls::TLabel* lblDataAlignment;
	Stdctrls::TLabel* lblDataColor;
	Stdctrls::TLabel* lblDataFont;
	Stdctrls::TEdit* edDataFont;
	Stdctrls::TComboBox* cbDataAlignment;
	Stdctrls::TComboBox* SMColorsCBData;
	Stdctrls::TButton* btnDataFont;
	Extctrls::TPanel* pnlStep7;
	Stdctrls::TCheckBox* chkHeader;
	Stdctrls::TMemo* memoHeader;
	Stdctrls::TCheckBox* chkFooter;
	Stdctrls::TMemo* memoFooter;
	Extctrls::TPanel* pnlStep8;
	Stdctrls::TGroupBox* gbOrientation;
	Extctrls::TImage* imgOrientation;
	Stdctrls::TRadioButton* rbOrientDefault;
	Stdctrls::TRadioButton* rbOrientPortrait;
	Stdctrls::TRadioButton* rbOrientLandscape;
	Stdctrls::TCheckBox* chkAutofit;
	Stdctrls::TGroupBox* gbMargin;
	Stdctrls::TLabel* lblLeft;
	Stdctrls::TLabel* lblTop;
	Stdctrls::TLabel* lblRight;
	Stdctrls::TLabel* lblBottom;
	Stdctrls::TEdit* edMarginTop;
	Stdctrls::TEdit* edMarginLeft;
	Stdctrls::TEdit* edMarginRight;
	Stdctrls::TEdit* edMarginBottom;
	Extctrls::TPanel* pnlStep9;
	Stdctrls::TRadioButton* rbColorsFonts;
	Stdctrls::TRadioButton* rbDataOnly;
	Extctrls::TRadioGroup* rgLayout;
	Stdctrls::TLabel* lblStyle;
	Stdctrls::TComboBox* cbColorStyle;
	Stdctrls::TGroupBox* gbPreview;
	Extctrls::TPaintBox* pbLayout;
	Extctrls::TPanel* pnlStep10;
	Stdctrls::TLabel* lblFileName;
	Stdctrls::TEdit* edFileName;
	Stdctrls::TButton* btnFileName;
	Stdctrls::TCheckBox* cbMerged;
	Stdctrls::TCheckBox* cbRowsPerFile;
	Stdctrls::TEdit* edRowsPerFile;
	Extctrls::TRadioGroup* rbActionAfterExport;
	Stdctrls::TLabel* lblKeyGenerator;
	Stdctrls::TEdit* edKeyGenerator;
	Stdctrls::TComboBox* cbTableNames;
	Stdctrls::TComboBox* cbAccessVersion;
	Stdctrls::TComboBox* cbOOFileFilter;
	Stdctrls::TLabel* lblTableName;
	Stdctrls::TLabel* lblOOFileFilter;
	void __fastcall btnNextClick(System::TObject* Sender);
	void __fastcall btnPrevClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall btnFileNameClick(System::TObject* Sender);
	void __fastcall rgSeparatorClick(System::TObject* Sender);
	void __fastcall edSymbolChange(System::TObject* Sender);
	void __fastcall rgTableTypeClick(System::TObject* Sender);
	void __fastcall btnCancelClick(System::TObject* Sender);
	void __fastcall PropertyExit(System::TObject* Sender);
	void __fastcall SMColorsCBTitleDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall btnTitleFontClick(System::TObject* Sender);
	void __fastcall clbFieldsDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall clbFieldsDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall clbFieldsClick(System::TObject* Sender);
	void __fastcall cbTableNamesDropDown(System::TObject* Sender);
	void __fastcall edFileNameChange(System::TObject* Sender);
	void __fastcall btnSpecsClick(System::TObject* Sender);
	void __fastcall rgLayoutClick(System::TObject* Sender);
	void __fastcall pbLayoutPaint(System::TObject* Sender);
	void __fastcall miSelectAllClick(System::TObject* Sender);
	void __fastcall cbAddTitleClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, Word &Key, Classes::TShiftState Shift);
	void __fastcall btnFirstClick(System::TObject* Sender);
	void __fastcall btnLastClick(System::TObject* Sender);
	void __fastcall rbText2Click(System::TObject* Sender);
	void __fastcall pnlDescriptionResize(System::TObject* Sender);
	void __fastcall cbColorsFontsClick(System::TObject* Sender);
	void __fastcall rbOrientDefaultClick(System::TObject* Sender);
	void __fastcall miSVRowNoClick(System::TObject* Sender);
	void __fastcall pmColumnsPopup(System::TObject* Sender);
	void __fastcall clbFieldsClickCheck(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall sbCategoryResize(System::TObject* Sender);
	void __fastcall chkHeaderClick(System::TObject* Sender);
	void __fastcall chkFooterClick(System::TObject* Sender);
	void __fastcall pbLogoPaint(System::TObject* Sender);
	void __fastcall cbTableNamesExit(System::TObject* Sender);
	
private:
	int intCurStep;
	int intCountStep;
	bool IsRun;
	TSMESaveSpecNotifyEvent OnSaveSpec;
	Classes::TNotifyEvent OnLoadSpec;
	TSMEGetSpecificationsEvent OnGetSpecifications;
	AnsiString DefExt;
	AnsiString FilterExt;
	AnsiString TitleExt;
	TSMEDirection FDirection;
	int frmHeightMin;
	int frmHeightMax;
	int frmWidthMin;
	int frmWidthMax;
	bool __fastcall IsValidCurStep(void);
	void __fastcall UpdateButtons(void);
	void __fastcall UpdateMergeStatus(void);
	
protected:
	AnsiString StepHeader[10];
	AnsiString StepInfo[10];
	MESSAGE void __fastcall WMMinMaxInfo(Messages::TWMGetMinMaxInfo &Msg);
	
public:
	bool IsCanceled;
	AnsiString sCancel;
	AnsiString sExecute;
	AnsiString sStep;
	AnsiString sAbort;
	TSMEWizardDlg* WizardDlg;
	Exportds::TTableTypeExport __fastcall GetTableTypeIndex(void);
	__property TSMEDirection Direction = {read=FDirection, nodefault};
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TfrmSMEWizard(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmSMEWizard(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmSMEWizard(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TfrmSMEWizard(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


typedef Set<TSMERestriction, erDisabled, erReadWrite>  TSMERestrictions;

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Smewiz */
using namespace Smewiz;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Smewiz
