unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, ExportDS, SMEWiz, Grids, AdvGrid, dbadvgrd,
  SMEEngine, SMEEngDB, SMEEngWW;

type
  TfrmMain = class(TForm)
    DBAdvStringGrid1: TDBAdvStringGrid;
    SMEWizardDlg1: TSMEWizardDlg;
    DataSource1: TDataSource;
    Table1: TTable;
    btnExport: TButton;
    SMEDBAdvStringGridDataEngine1: TSMEDBAdvStringGridDataEngine;
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

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
//  showmessage(inttostr(DBAdvStringGrid1.Fields.Count));
//  exit;
  
  {link data engine with our string grid}
  SMEDBAdvStringGridDataEngine1.DBGrid := DBAdvStringGrid1;
  SMEWizardDlg1.DataEngine := SMEDBAdvStringGridDataEngine1;

  {specify that we want to export from data engine}
  SMEWizardDlg1.ColumnSource := csDataEngine;

  {start an export}
  SMEWizardDlg1.FileName := ExtractFilePath(Application.ExeName) + 'smexport.pdf';
  SMEWizardDlg1.TableType := tePDF;
  SMEWizardDlg1.Execute
end;

end.
