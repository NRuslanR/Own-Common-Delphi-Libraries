unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, DBGrids, Db, ExportDS, SME2DS, DBISAMTb;

type
  TForm1 = class(TForm)
    DBISAMTable1: TDBISAMTable;
    DBISAMTable2: TDBISAMTable;
    DBISAMDatabase1: TDBISAMDatabase;
    SMExportToDataset1: TSMExportToDataset;
    Panel1: TPanel;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    DBGrid2: TDBGrid;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  {read tables from application directory}
  DBISAMDatabase1.Directory := ExtractFilePath(Application.ExeName);

  {open tables}
  DBISAMTable1.Open;
  DBISAMTable2.Open;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: Integer;
begin
  {we'll copy records from dataset}
  SMExportToDataset1.ColumnSource := csDBGrid;

  {set a source dbgrid and dataset}
  SMExportToDataset1.DBGrid := DBGrid1;
  SMExportToDataset1.Dataset := DBISAMTable1;

  {set a target dataset}
  SMExportToDataset1.Destination := DBISAMTable2;

  {if some records in grid are selected then copy only selected rows}
  SMExportToDataset1.SelectedRecord := (DBGrid1.SelectedRows.Count > 0);

  {specify what columns will be copied.
  PS: in sample we have tables with same structure so we'll copy all fields}
  SMExportToDataset1.Mappings.Clear;
  for i := 0 to DBISAMTable1.FieldCount-1 do
    SMExportToDataset1.Mappings.Add(DBISAMTable1.Fields[i].FieldName + '=' + DBISAMTable1.Fields[i].FieldName);

  {start a copy process}
  SMExportToDataset1.Execute
end;

end.
