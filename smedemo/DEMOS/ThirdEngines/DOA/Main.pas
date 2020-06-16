unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExportDS, SME2OLE, Oracle, Grids, DBGrids, Db, OracleData;

type
  TForm1 = class(TForm)
    OracleSession1: TOracleSession;
    OracleDataSet1: TOracleDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    OracleLogon1: TOracleLogon;
    SMExportToExcel1: TSMExportToExcel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
uses SMEEngine;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if not OracleSession1.Connected then
  begin
    if OracleLogon1.Execute then
      OracleSession1.Connected := True;
  end;

  OracleDataSet1.Open;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  {specify a filename}
  SMExportToExcel1.FileName := ExtractFilePath(Application.ExeName) + 'smexport.xls';

  {fill a column list}
  with SMExportToExcel1.Columns.Add do
  begin
    FieldName := 'Loader_ID';
    Title.Caption := 'Loader_ID';
    DataType := ctInteger;
    Width := 10;
    Visible := True;
  end;
  with SMExportToExcel1.Columns.Add do
  begin
    FieldName := 'Question';
    Title.Caption := 'Question';
    DataType := ctString;
    Width := 100;
    Visible := True;
  end;
  with SMExportToExcel1.Columns.Add do
  begin
    FieldName := 'Query';
    Title.Caption := 'Query';
    DataType := ctString;
    Width := 100;
    Visible := True;
  end;
  with SMExportToExcel1.Columns.Add do
  begin
    FieldName := 'Remark';
    Title.Caption := 'Remark';
    DataType := ctString;
    Width := 100;
    Visible := True;
  end;

  {start an export process}
  SMExportToExcel1.AddTitle := True;
  SMExportToExcel1.Execute
end;

end.
