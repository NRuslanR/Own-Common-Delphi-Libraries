unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, SMEEngine, ExportDS, SME2Cell, SME2OLE;

type
  TfrmMain = class(TForm)
    SMExportToWord1: TSMExportToWord;
    SMEVirtualDataEngine1: TSMEVirtualDataEngine;
    pnlAction: TPanel;
    btnExport: TButton;
    lblURL: TLabel;
    btnGenerate: TButton;
    procedure btnExportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGenerateClick(Sender: TObject);
    procedure SMEVirtualDataEngine1Count(Sender: TObject;
      var Count: Integer);
    procedure SMEVirtualDataEngine1First(Sender: TObject);
    procedure SMEVirtualDataEngine1Next(Sender: TObject;
      var Abort: Boolean);
    procedure SMEVirtualDataEngine1FillColumns(Sender: TObject);
    procedure SMEVirtualDataEngine1GetValue(Sender: TObject;
      Column: TSMEColumn; var Value: Variant);
  private
    { Private declarations }
    {list of dynamic pictures}
    lstPictures: TList;
    CurrentPictureNo: Integer;

    procedure ClearPictures;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}
{$R winxp.res}

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  SMExportToWord1.FileName := ExtractFilePath(Application.ExeName) + 'smexport.doc';
  SMExportToWord1.Execute;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  lstPictures := TList.Create;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  ClearPictures;
  lstPictures.Free;
end;

procedure TfrmMain.ClearPictures;
var
  i: Integer;
begin
  for i := lstPictures.Count-1 downto 0 do
    TBitmap(lstPictures[i]).Free;
  lstPictures.Clear;
end;

procedure TfrmMain.btnGenerateClick(Sender: TObject);
var
  i: Integer;
  bmp: TBitmap;
begin
  ClearPictures;

  for i := 0 to Random(10)+5 do
  begin
    {add new bitmap (random sizes)}
    bmp := TBitmap.Create;
    bmp.Width := 50+Random(100);
    bmp.Height := 50+Random(100);

    {fill by random color and draw any text}
    bmp.Canvas.Brush.Color := RGB(64+Random(191), 64+Random(191), 64+Random(191));
    bmp.Canvas.FillRect(Rect(0, 0, bmp.Width-1, bmp.Height-1));
    bmp.Canvas.Font.Style := [fsBold];
    bmp.Canvas.TextOut(5, 5, 'Any text');

    lstPictures.Add(bmp)
  end;
end;

procedure TfrmMain.SMEVirtualDataEngine1Count(Sender: TObject;
  var Count: Integer);
begin
  {we must say how many rows we want to export}
  Count := lstPictures.Count;
end;

procedure TfrmMain.SMEVirtualDataEngine1First(Sender: TObject);
begin
  {here we must initialize some our internal structures.
  For example, we'll initialize the counter}
  CurrentPictureNo := 0;
end;

procedure TfrmMain.SMEVirtualDataEngine1Next(Sender: TObject;
  var Abort: Boolean);
begin
  {here we must prepare a next "row"
  We'll increase the counter}
  CurrentPictureNo := CurrentPictureNo + 1
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
    FieldName := 'Name';
    Caption := 'Picture name';
    DataType := ctString;
    Alignment := taCenter;
    Width := 20
  end;

  {add second virtual column}
  with SMExportToWord1.Columns.Add do
  begin
    FieldName := 'Graphic';
    Caption := 'Random picture';
    DataType := ctGraphic;
    Width := 30
  end;
end;

procedure TfrmMain.SMEVirtualDataEngine1GetValue(Sender: TObject;
  Column: TSMEColumn; var Value: Variant);
var
  strStream: TStringStream;
begin
  {here we must return a value for current row for Column}
  if Assigned(Column) then
  begin
    if (Column.FieldName = 'Name') then
      Value := 'Any text for row#' + IntToStr(CurrentPictureNo+1)
    else
    if (Column.FieldName = 'Graphic') then
    begin
      {load bitmap to string stream}
      strStream := TStringStream.Create('');
      try
        TBitmap(lstPictures[CurrentPictureNo]).SaveToStream(strStream);
        Value := strStream.DataString
      finally
        strStream.Free
      end;
    end
  end;
end;

end.
