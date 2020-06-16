unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExportDS, SME2Cell, SME2HTML, Grids, DBGrids, Db, DBTables, StdCtrls;

type
  TfrmMain = class(TForm)
    btnExport: TButton;
    DataSource1: TDataSource;
    Table1: TTable;
    DBGrid1: TDBGrid;
    SMExportToHTML1: TSMExportToHTML;
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
uses SMEEngine;

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  {build all default columns}
  SMExportToHTML1.BuildDefaultColumns;

  {add new column with record number}
  with SMExportToHTML1.Columns.Add do
  begin
    Index := 0;
    ColumnKind := ckSysVar;
    FieldName := 'ROWNO';
    Title.Caption := 'Row#';
    DataType := ctInteger;
    Alignment := taRightJustify;
    Width := 5;
  end;

  {start an export process}
  SMExportToHTML1.Execute;
end;

end.
