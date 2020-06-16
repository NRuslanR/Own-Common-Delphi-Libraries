unit ptest;

interface

uses
  Windows, Messages, SysUtils, {Variants, }Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExportDS, SME2OLE, SMEEngine, ExtCtrls;

type
  TfrmExportTest = class(TForm)
    BitBtn1: TBitBtn;
    SMEVirtualDataEngine1: TSMEVirtualDataEngine;
    SMExportToExcel1: TSMExportToExcel;
    Image1: TImage;
    procedure BitBtn1Click(Sender: TObject);
    procedure SMEVirtualDataEngine1Count(Sender: TObject;
      var Count: Integer);
    procedure SMEVirtualDataEngine1GetValue(Sender: TObject;
      Column: TSMEColumn; var Value: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExportTest: TfrmExportTest;

implementation

{$R *.dfm}

procedure TfrmExportTest.BitBtn1Click(Sender: TObject);
var
  strFileName : string;
begin
  strFileName := ExtractFilePath(Application.ExeName) + 'export.xls';
  SMExportToExcel1.FileName := strFileName;
  SMExportToExcel1.KeyGenerator := 'Sheet 1';
  SMExportToExcel1.Execute;
end;

procedure TfrmExportTest.SMEVirtualDataEngine1Count(Sender: TObject;
  var Count: Integer);
begin
  Count := 1;
end;

procedure TfrmExportTest.SMEVirtualDataEngine1GetValue(Sender: TObject;
  Column: TSMEColumn; var Value: Variant);
var
  strStream: TStringStream;
begin
  if Assigned(Column) then
  begin
    if (Column.FieldName = 'colChartTitle') then
      Value := 'Chart Title'
    else
    if (Column.FieldName = 'colChartImage') then
    begin
      {load bitmap to string stream}
      strStream := TStringStream.Create('');
      try
        Image1.Picture.Bitmap.SaveToStream(strStream);
        Value := strStream.DataString
      finally
        strStream.Free
      end;
    end
  end;
end;

end.
