unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, ExportDS, SME2OLE, StdCtrls;

type
  TfrmMain = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    DBGrid1: TDBGrid;
    btnExport: TButton;
    SMExportToAccess1: TSMExportToAccess;
    procedure FormCreate(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
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
  Table1.Open
end;

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  {export from table}
  SMExportToAccess1.DataSet := Table1;
  SMExportToAccess1.ColumnSource := csDataset;

  {target MS Access table}
  SMExportToAccess1.FileName := ExtractFilePath(Application.ExeName) + 'orders.mdb';
  SMExportToAccess1.TableName := 'reservat';
  SMExportToAccess1.MSAccessVersion := avAccess97;

  {export with original field types}
  SMExportToAccess1.Options := SMExportToAccess1.Options - [soFieldMask];

  {start process}
  SMExportToAccess1.Execute
end;

end.
