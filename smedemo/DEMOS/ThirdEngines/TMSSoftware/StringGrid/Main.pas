unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, SMEEngine, SMEEngSG, ExportDS, SMEWiz, Grids, AdvGrid;

type
  TfrmMain = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    SMEWizardDlg1: TSMEWizardDlg;
    SMEStringGridDataEngine1: TSMEStringGridDataEngine;
    btnFillCells: TButton;
    btnExport: TButton;
    procedure btnFillCellsClick(Sender: TObject);
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

procedure TfrmMain.btnFillCellsClick(Sender: TObject);
var
  i, j: Integer;
begin
  with AdvStringGrid1 do
  begin
    ColCount := 2+Random(5);
    RowCount := 10+Random(100);
    if ColCount > 1 then
      FixedCols := 1;
    if RowCount > 1 then
      FixedRows := 1;
    for j := 0 to ColCount-1 do
    begin
      ColWidths[j] := Random(100);
      for i := 0 to RowCount-1 do
        Cells[j, i] := 'Random' + IntToStr(Random(10000));
    end;
  end;
end;

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  {link data engine with our string grid}
  SMEStringGridDataEngine1.StringGrid := AdvStringGrid1;
  SMEWizardDlg1.DataEngine := SMEStringGridDataEngine1;

  {specify that we want to export from data engine}
  SMEWizardDlg1.ColumnSource := csDataEngine;

  {start an export}
  SMEWizardDlg1.FileName := ExtractFilePath(Application.ExeName) + 'smexport.pdf';
  SMEWizardDlg1.TableType := tePDF;
  SMEWizardDlg1.Execute
end;

initialization
  Randomize;
  
end.
