unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, StdCtrls, Db, DBTables, ExportDS, SME2Cell, SME2XML,
  SMIBase, SMI2XML;

type
  TfrmMain = class(TForm)
    Table1: TTable;
    DataSource1: TDataSource;
    gbSource: TGroupBox;
    DBGrid1: TDBGrid;
    gbTarget: TGroupBox;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    Table2: TTable;
    btnExport: TButton;
    btnImport: TButton;
    SMExportToXML1: TSMExportToXML;
    SMImportFromXML1: TSMImportFromXML;
    procedure FormCreate(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure SMImportFromXML1CreateStructure(Sender: TObject;
      Columns: TSMIColumns);
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
  {source datase}
  Table1.DatabaseName := ExtractFilePath(Application.ExeName);
  Table1.TableName := 'CNTR1.DB';
  Table1.TableType := ttParadox;
  Table1.Open;

  {target datase}
  Table2.DatabaseName := ExtractFilePath(Application.ExeName);
  Table2.TableName := 'CNTR2.DB';
  Table2.TableType := ttParadox;
  Table2.Open;
end;

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  SMExportToXML1.ColumnSource := csDataset;
  SMExportToXML1.DataSet := Table1;
  SMExportToXML1.FileName := ExtractFilePath(Application.ExeName) + 'smexport.xml';
  SMExportToXML1.Format := xmlClientDataset;
  SMExportToXML1.AddTitle := True;
  SMExportToXML1.Execute;
end;

procedure TfrmMain.btnImportClick(Sender: TObject);
begin
  SMImportFromXML1.DataSet := Table2;
  SMImportFromXML1.SourceFileName := ExtractFilePath(Application.ExeName) + 'smexport.xml';
  SMImportFromXML1.Mappings.Clear;
  SMImportFromXML1.Mode := imCopy;
  SMImportFromXML1.XMLTags.RecordsTag := 'ROWDATA';
  SMImportFromXML1.XMLTags.RowTag := 'ROW';
  SMImportFromXML1.XMLTags.RecordTag := 'RECORD';
  SMImportFromXML1.Execute;
end;

procedure TfrmMain.SMImportFromXML1CreateStructure(Sender: TObject;
  Columns: TSMIColumns);
begin
  SMImportFromXML1.Mappings.Clear;
  SMImportFromXML1.Columns2Mapping;
end;

end.
