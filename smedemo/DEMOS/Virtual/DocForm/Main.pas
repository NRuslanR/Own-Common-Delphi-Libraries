unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SMEEngine, ExportDS, SME2OLE, DB
  {$IFDEF VER140} , Variants, SME2Cell {$ENDIF};

type
  TfrmMain = class(TForm)
    SMEVirtualDataEngine1: TSMEVirtualDataEngine;
    btnExport: TButton;
    btnAbout: TButton;
    gbCompany: TGroupBox;
    lblName: TLabel;
    lblCountry: TLabel;
    lblPostAddress: TLabel;
    lblBezoekAdres: TLabel;
    lblPlace: TLabel;
    edName: TEdit;
    cbCountry: TComboBox;
    edPostAddress: TEdit;
    edBezoekAdres: TEdit;
    edPlace: TEdit;
    lblZipCode: TLabel;
    edZipCode: TEdit;
    SMExportToWord1: TSMExportToWord;
    procedure btnExportClick(Sender: TObject);
    procedure SMEVirtualDataEngine1Count(Sender: TObject;
      var Count: Integer);
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
  SMExportToWord1.FileName := ExtractFilePath(Application.ExeName) + 'SMExport.doc';
  SMExportToWord1.Execute;
end;

procedure TfrmMain.SMEVirtualDataEngine1Count(Sender: TObject;
  var Count: Integer);
begin
  {we must say how many rows we want to export}
  Count := 6;
end;

procedure TfrmMain.SMEVirtualDataEngine1FillColumns(Sender: TObject);
begin
  {we must define columns which will be exported.
  As alternative you can define a same Columns directly in TSMExportToWord.Columns

  IMPORTANT:
  Must be defined at least one column}

  SMExportToWord1.Columns.Clear;

  {add first virtual column}
  with SMExportToWord1.Columns.Add do
  begin
    FieldName := 'DataFromControls';
    Width := 60
  end;

  {add second virtual column}
  with SMExportToWord1.Columns.Add do
  begin
    FieldName := 'CurDate';
    Width := 20
  end;
end;

procedure TfrmMain.SMEVirtualDataEngine1GetValue(Sender: TObject;
  Column: TSMEColumn; var Value: Variant);
begin
  Value := '';

  {here we must return a value for current row for Column}
  if Assigned(Column) then
  begin
    if (Column.FieldName = 'DataFromControls') then
    begin
      case SMExportToWord1.Statistic.CurrentRow of
        0: Value := edName.Text;
        1: Value := cbCountry.Text;
        2: Value := edPostAddress.Text;
        3: Value := edBezoekAdres.Text;
        4: Value := edPlace.Text + ', ' + edZipCode.Text;
      end
    end
    else
    if (Column.FieldName = 'CurDate') then
    begin
      if (SMExportToWord1.ExportedRecordCount = 6) then
        Value := Date();
    end
  end;
end;

procedure TfrmMain.btnAboutClick(Sender: TObject);
begin
  SMExportToWord1.AboutSME
end;

procedure TfrmMain.SMEWizardDlg1GetCellParams(Sender: TObject;
  Field: TField; var Text: String; AFont: TFont; var Alignment: TAlignment;
  var Background: TColor; var CellType: TCellType);
begin
  BackGround := clWhite
end;

end.
