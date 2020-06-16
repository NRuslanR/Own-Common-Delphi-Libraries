unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, Wwdbigrd, Wwdbgrid, Db, DBTables, ExportDS, SMEWiz,
  SMEEngine, SMEEngDB, SMEEngWW;

type
  TfrmMain = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    wwDBGrid1: TwwDBGrid;
    Button1: TButton;
    Table1SpeciesNo: TFloatField;
    Table1Category: TStringField;
    Table1Common_Name: TStringField;
    SMEwwDBGridDataEngine1: TSMEwwDBGridDataEngine;
    SMEWizardDlg1: TSMEWizardDlg;
    Table1Notes: TMemoField;
    procedure Button1Click(Sender: TObject);
    procedure SMEWizardDlg1GetCellParams(Sender: TObject; Field: TField;
      var Text: String; AFont: TFont; var Alignment: TAlignment;
      var Background: TColor; var CellType: TCellType);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  {link data engine with our string grid}
  SMEwwDBGridDataEngine1.DBGrid := wwDBGrid1;
  SMEWizardDlg1.DataEngine := SMEwwDBGridDataEngine1;

  SMEwwDBGridDataEngine1.ExportFooters := (dgShowFooter in wwDBGrid1.Options);

  {specify that we want to export from data engine}
  SMEWizardDlg1.ColumnSource := csDataEngine;

  {start an export}
  SMEWizardDlg1.FileName := ExtractFilePath(Application.ExeName) + 'smexport.txt';

  SMEWizardDlg1.Header.Clear;
  SMEWizardDlg1.Header.Add('Generated:'#13#10 + DateToStr(Now()));
  SMEWizardDlg1.Execute;
end;

procedure TfrmMain.SMEWizardDlg1GetCellParams(Sender: TObject;
  Field: TField; var Text: String; AFont: TFont; var Alignment: TAlignment;
  var Background: TColor; var CellType: TCellType);
begin
  if Assigned(Field) then
  begin
    if (Field.FieldName = 'Category') then
      AFont.Color := clRed;
    AFont.Style := AFont.Style + [fsBold];
  end
  else
  begin
    AFont.Color := clYellow;
    AFont.Style := AFont.Style - [fsBold];
    Background := clBlue;
  end
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  wwDBGrid1.Options := wwDBGrid1.Options + [dgShowFooter];
  wwDBGrid1.ColumnByName('Category').FooterValue := 'aaaaa';
end;

end.
