unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, StdCtrls, ExportDS, SME2Cell, SME2DBF, SMEEngine;

type
  TfrmMain = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    DBGrid1: TDBGrid;
    Button1: TButton;
    SMExportToDBF1: TSMExportToDBF;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
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

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  Table1.Close;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  i: Integer;
begin
  SMExportToDBF1.FileName := ExtractFilePath(Application.ExeName) + 'smexport.dbf';

  {fill custom columns collection}
  SMExportToDBF1.Columns.Clear;
  for i := 0 to Table1.FieldCount-1 do
  begin
    with SMExportToDBF1.Columns.Add do
    begin
      FieldName := Table1.Fields[i].FieldName;
      Title.Caption := Table1.Fields[i].DisplayName;
      Alignment := Table1.Fields[i].Alignment;
      Width := Table1.Fields[i].Size;
      if (Table1.Fields[i] is TFloatField) then
        Precision := TFloatField(Table1.Fields[i]).Precision;

      DataType := GetValueType(Table1.Fields[i].DataType, Table1.Fields[i].Value, False);
      ColumnKind := ckField;

      if (FieldName = 'BMP') then
      begin
        DataType := ctMemo;
      end;
    end;
  end;
  {add dummy exported column}
  with SMExportToDBF1.Columns.Add do
  begin
    FieldName := '5';
    Title.Caption := 'Dummy';
    Alignment := taRightJustify;
    Width := 10;
    DataType := ctInteger;
    ColumnKind := ckConstant;
  end;

  {start the export process}
  SMExportToDBF1.Execute;
  ShowMessage('DBF-file created succesfully. '#13#10'Open file' + SMExportToDBF1.FileName)
end;

end.
