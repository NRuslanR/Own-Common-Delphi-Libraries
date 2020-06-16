unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, StdCtrls, ComCtrls, DBCtrls, Menus,
  ExportDS, SME2Cell, SME2OLE, SMEEngine;

type
  TfrmMain = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    DBGrid1: TDBGrid;
    DBRichEdit1: TDBRichEdit;
    btnExport: TButton;
    pmRTF: TPopupMenu;
    miCopy: TMenuItem;
    miCut: TMenuItem;
    miPaste: TMenuItem;
    miSeparator1: TMenuItem;
    miLoad: TMenuItem;
    miSave: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SMExportToWord1: TSMExportToWord;
    procedure FormCreate(Sender: TObject);
    procedure miCopyClick(Sender: TObject);
    procedure miCutClick(Sender: TObject);
    procedure miPasteClick(Sender: TObject);
    procedure miLoadClick(Sender: TObject);
    procedure miSaveClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure SMExportToWord1GetCellParams(Sender: TObject; Field: TField;
      var Text: String; AFont: TFont; var Alignment: TAlignment;
      var Background: TColor; var CellType: TCellType);
    procedure SMExportToWord1AfterRecord(Sender: TObject;
      var Abort: Boolean);
  private
    { Private declarations }
    intCurRow: Integer; //current exported record index
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Table1.DatabaseName := ExtractFilePath(Application.ExeName);
  Table1.Open;
end;

procedure TfrmMain.miCopyClick(Sender: TObject);
begin
  DBRichEdit1.CopyToClipboard
end;

procedure TfrmMain.miCutClick(Sender: TObject);
begin
  DBRichEdit1.CutToClipboard
end;

procedure TfrmMain.miPasteClick(Sender: TObject);
begin
  DBRichEdit1.PasteFromClipboard
end;

procedure TfrmMain.miLoadClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Table1.Edit;
    (DBRichEdit1.Field as TBLOBField).LoadFromFile(OpenDialog1.FileName);
  end;
end;

procedure TfrmMain.miSaveClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
    (DBRichEdit1.Field as TBLOBField).SaveToFile(SaveDialog1.FileName)
end;

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  SMExportToWord1.ColumnSource := csDataset;
  SMExportToWord1.FileName := ExtractFilePath(Application.ExeName) + '\smexport.doc';

  SMExportToWord1.Options := SMExportToWord1.Options-[soDisableControls,soExportBlankValues];
  intCurRow := 0;
  SMExportToWord1.Execute;
end;

procedure TfrmMain.SMExportToWord1GetCellParams(Sender: TObject;
  Field: TField; var Text: String; AFont: TFont; var Alignment: TAlignment;
  var Background: TColor; var CellType: TCellType);
begin
  if Assigned(Field) and (Field.FieldName = 'Note') then
  begin
    Text := '';
    CellType := ctBlank;

    {copy contents into clipboard}
    DBRichEdit1.SelectAll;
    DBRichEdit1.CopyToClipboard;
  end;
end;

procedure TfrmMain.SMExportToWord1AfterRecord(Sender: TObject;
  var Abort: Boolean);
const
  wdPasteRTF = $00000001;
var
  intColIndex: Integer;
begin
  Inc(intCurRow);

  {past efrom saved clipboard}
  intColIndex := TSMExportToWord(Sender).Columns.ColumnByFieldName('Note');
  if intColIndex > -1 then
    TSMExportToWord(Sender).table.Rows.Item(intCurRow).Cells.Item(intColIndex+1).Range.{Paste;//}PasteSpecial(DataType := wdPasteRTF);
end;

end.
