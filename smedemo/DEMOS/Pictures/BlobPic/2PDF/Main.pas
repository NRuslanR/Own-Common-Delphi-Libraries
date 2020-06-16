unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExportDS, SME2OLE, SMEEngine, Db, DBTables, StdCtrls, DBCtrls, Grids, DBGrids,
  SME2Cell, SME2PDF;

type
  TfrmMain = class(TForm)
    dbgBLOBs: TDBGrid;
    btnExport: TButton;
    tblBLOBs: TTable;
    dSrcBLOBs: TDataSource;
    SMExportToPDF1: TSMExportToPDF;
    procedure FormCreate(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure SMExportToPDF1GetCellParams(Sender: TObject;
      Field: TField; var Text: String; AFont: TFont;
      var Alignment: TAlignment; var Background: TColor;
      var CellType: TCellType);
  private
    { Private declarations }
    procedure CreateFieldColumns;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}
uses JPEG;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  tblBLOBs.DatabaseName := ExtractFilePath(Application.ExeName);
  tblBLOBs.Open;
end;

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  {export from dataset}
  SMExportToPDF1.DataSet := tblBLOBs;
  SMExportToPDF1.ColumnSource := csDataset;
//  CreateFieldColumns;

  {target filename (pdf) and table name}
  SMExportToPDF1.FileName := ExtractFilePath(Application.ExeName) + 'sme.pdf';

  {options for export}
  SMExportToPDF1.Options := [{soFieldMask, }soShowMessage, soWaitCursor, soDisableControls, soRowLines, soColLines];

  {start export process}
  SMExportToPDF1.Execute;
end;

procedure TfrmMain.CreateFieldColumns;
var
  i: Integer;
begin
  SMExportToPDF1.Columns.Clear;

  {add all default fields}
  for i := 0 to tblBLOBs.FieldCount-1 do
  begin
    with tblBLOBs, SMExportToPDF1.Columns.Add do
    begin
      Alignment := Fields[i].Alignment;
      FieldName := Fields[i].FieldName;
      Color := clWhite;
      Width := Fields[i].DisplayWidth;
      Visible := Fields[i].Visible;
      if (Fields[i] is TFloatField) then
        Precision := TFloatField(Fields[i]).Precision;

      DataType := GetValueType(Fields[i].DataType, Fields[i].Value, False);

      Title.Caption := Fields[i].DisplayLabel;
    end
  end;

  {disable our column with file names}
  i := SMExportToPDF1.Columns.ColumnByFieldName('BLOBNAME');
  if (i > -1) then
    SMExportToPDF1.Columns[i].Visible := False;

  {add our dummy column for real picture (BLOB)}
  with SMExportToPDF1.Columns.Add do
  begin
    FieldName := 'PIC';
    DataType := ctGraphic;
    ColumnKind := ckConstant;
    Visible := True
  end;
end;

procedure TfrmMain.SMExportToPDF1GetCellParams(Sender: TObject;
  Field: TField; var Text: String; AFont: TFont; var Alignment: TAlignment;
  var Background: TColor; var CellType: TCellType);
var
  strFileName: string;
  jpg: TJPEGImage;
  bmp: TBitmap;
  strStream: TStringStream;
begin
  if (Text = 'PIC') then
  begin
    {load file from file name into blob
    PS: we must convert jpeg into bitmap}
    strFileName := tblBLOBs.FieldByName('BLOBNAME').AsString;
    if FileExists(strFileName) then
    begin
      jpg := TJPEGImage.Create;
      bmp := TBitmap.Create;
      strStream := TStringStream.Create('');
      try
        jpg.LoadFromFile(strFileName);
        bmp.Assign(jpg);
        bmp.SaveToStream(strStream);

        Text := strStream.DataString
      finally
        strStream.Free;

        jpg.Free;
        bmp.Free;
      end;
    end
    else
      Text := ''
  end
end;

end.
