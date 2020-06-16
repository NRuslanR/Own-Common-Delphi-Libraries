unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  StdCtrls, DBTables, ExportDS, SME2Cell, SME2DBF, SMEEngine, SMEEngCX,
  SMEWiz;

type
  TForm1 = class(TForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    SMEcxCustomGridTableViewDataEngine1: TSMEcxCustomGridTableViewDataEngine;
    SMExportToDBF1: TSMExportToDBF;
    DataSource1: TDataSource;
    Table1: TTable;
    Button1: TButton;
    cxGrid1DBTableView1Name: TcxGridDBColumn;
    cxGrid1DBTableView1Capital: TcxGridDBColumn;
    cxGrid1DBTableView1Continent: TcxGridDBColumn;
    cxGrid1DBTableView1Area: TcxGridDBColumn;
    cxGrid1DBTableView1Population: TcxGridDBColumn;
    SMEWizardDlg1: TSMEWizardDlg;
    btnWizard: TButton;
    procedure Button1Click(Sender: TObject);
    procedure btnWizardClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  {we'll copy records from cxGrid}
  SMExportToDBF1.ColumnSource := csDataEngine;

  {set a source dbgrid and dataset}
  SMExportToDBF1.DataEngine := SMEcxCustomGridTableViewDataEngine1;

  {set a target dbf-file}
  SMExportToDBF1.FileName := ExtractFilePath(Application.ExeName) + '\smexport.dbf';

  {if some records in grid are selected then copy only selected rows}
  SMExportToDBF1.SelectedRecord := (cxGrid1DBTableView1.DataController.GetSelectedCount > 1);

  {specify what columns will be exported}
  SMExportToDBF1.Columns.Clear;
  with SMExportToDBF1.Columns.Add do
  begin
    FieldName := 'Name';
    Caption := 'Country';
    Width := 50;
    Visible := True;
    Alignment := taLeftJustify
  end;

  {start an export process}
  SMExportToDBF1.Execute
end;

procedure TForm1.btnWizardClick(Sender: TObject);
begin
  {we'll copy records from cxGrid}
  SMEWizardDlg1.ColumnSource := csDataEngine;

  {set a source dbgrid and dataset}
  cxGrid1DBTableView1.DataController.DataSource := DataSource1;
  SMEWizardDlg1.DataEngine := SMEcxCustomGridTableViewDataEngine1;

  {set a target dbf-file}
  SMEWizardDlg1.FileName := ExtractFilePath(Application.ExeName) + '\smexport';

  {if some records in grid are selected then copy only selected rows}
  SMEWizardDlg1.SelectedRecord := (cxGrid1DBTableView1.DataController.GetSelectedCount > 1);

  {start an export process}
  SMEWizardDlg1.Execute
end;

end.
