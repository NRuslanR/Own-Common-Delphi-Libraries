unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SMEEngine, ExportDS, SME2Cell, SME2XLS, DB
  {$IFDEF VER140} , Variants {$ENDIF};

type
  TfrmMain = class(TForm)
    SMExportToXLS1: TSMExportToXLS;
    SMEVirtualDataEngine1: TSMEVirtualDataEngine;
    btnExport: TButton;
    memoNote: TMemo;
    btnAbout: TButton;
    procedure btnExportClick(Sender: TObject);
    procedure SMEVirtualDataEngine1Count(Sender: TObject;
      var Count: Integer);
    procedure SMEVirtualDataEngine1First(Sender: TObject);
    procedure SMEVirtualDataEngine1Next(Sender: TObject;
      var Abort: Boolean);
    procedure SMEVirtualDataEngine1GetValue(Sender: TObject;
      Column: TSMEColumn; var Value: Variant);
    procedure SMEVirtualDataEngine1FillColumns(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure SMEWizardDlg1GetCellParams(Sender: TObject; Field: TField;
      var Text: String; AFont: TFont; var Alignment: TAlignment;
      var Background: TColor; var CellType: TCellType);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  SMExportToXLS1.Execute;
end;

procedure TfrmMain.SMEVirtualDataEngine1Count(Sender: TObject;
  var Count: Integer);
begin
  {we must say how many rows we want to export}
  Count := 10;
end;

procedure TfrmMain.SMEVirtualDataEngine1First(Sender: TObject);
begin
  {here we must initialize some our internal structures.
  For example, retrive some data}
end;

procedure TfrmMain.SMEVirtualDataEngine1Next(Sender: TObject;
  var Abort: Boolean);
begin
  {here we must prepare a next "row"}
end;

procedure TfrmMain.SMEVirtualDataEngine1FillColumns(Sender: TObject);
begin
  {we must define columns which will be exported.
  As alternative you can define a same Columns directly in TSMExportToXLS.Columns

  IMPORTANT:
  Must be defined at least one column}

  SMExportToXLS1.Columns.Clear;

  {add first virtual column}
  with SMExportToXLS1.Columns.Add do
  begin
    FieldName := 'First column';
    Width := 20
  end;

  {add second virtual column}
  with SMExportToXLS1.Columns.Add do
  begin
    FieldName := 'Second column';
    Width := 30
  end;

  with SMExportToXLS1.Columns.Add do
  begin
    FieldName := 'Third column';
    Width := 10
  end;
end;

procedure TfrmMain.SMEVirtualDataEngine1GetValue(Sender: TObject;
  Column: TSMEColumn; var Value: Variant);
begin
  {here we must return a value for current row for Column}
  if Assigned(Column) then
  begin
    if (Column.FieldName = 'First column') then
      Value := 'Value for 1st col'
    else
    if (Column.FieldName = 'Second column') then
      Value := 'Value for 2st col'
    else
    if (Column.FieldName = 'Third column') then
      Value := 'Value for 3st col'
    else
      Value := '3'
  end;
end;


procedure TfrmMain.btnAboutClick(Sender: TObject);
begin
  SMExportToXLS1.AboutSME
end;

procedure TfrmMain.SMEWizardDlg1GetCellParams(Sender: TObject;
  Field: TField; var Text: String; AFont: TFont; var Alignment: TAlignment;
  var Background: TColor; var CellType: TCellType);
begin
  BackGround := clWhite
end;

end.
