unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, SMIBase, SMI2TXT, DB, DBClient, StdCtrls, ExportDS, SME2Cell,
  SME2OLE, Grids, DBGrids;

type
  TfrmMain = class(TForm)
    btnWrite: TButton;
    SaveDialog1: TSaveDialog;
    tbl1: TClientDataSet;
    lblWWW: TLabel;
    SMExportToAccess1: TSMExportToAccess;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    procedure btnWriteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnWriteClick(Sender: TObject);
begin
  SaveDialog1.FileName := SMExportToAccess1.FileName;
  if SaveDialog1.Execute then
  begin
    SMExportToAccess1.FileName := SaveDialog1.FileName;
    SMExportToAccess1.Execute
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i: Integer;
  j: int64;
begin
  {create a temporary dataset for txt loading}
  tbl1.FieldDefs.Add('TXT', ftString, 30, False);
  tbl1.FieldDefs.Add('IDX', {ftInteger}ftLargeint, 0, False);
  tbl1.CreateDataSet;
  tbl1.Open;

  {fill random values}
  for i := 0 to 100 do
  begin
    tbl1.Append;
    tbl1.FieldByName('TXT').AsString := 'any text ' + IntToStr(i+1);
    j := 500000000+i+1;
    tbl1.FieldByName('IDX').AsString{Integer} := '123456789012345';//j;
    tbl1.Post;
  end;
end;

end.
