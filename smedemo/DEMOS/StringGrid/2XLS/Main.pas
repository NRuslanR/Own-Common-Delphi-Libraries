unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, SMEEngine, SMEEngSG, ExportDS, SME2Cell, SME2XML,
  ExtCtrls, SME2XLS;

type
  TfrmMain = class(TForm)
    StringGrid1: TStringGrid;
    btnExport: TButton;
    btnAbout: TButton;
    btnClose: TButton;
    SMEStringGridDataEngine1: TSMEStringGridDataEngine;
    SMExportToXLS1: TSMExportToXLS;
    procedure btnCloseClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Close
end;

procedure TfrmMain.btnAboutClick(Sender: TObject);
begin
  SMExportToXLS1.AboutSME
end;

procedure TfrmMain.btnExportClick(Sender: TObject);
var
  i: Integer;
begin
  {export from string grid}
  SMExportToXLS1.ColumnSource := csDataEngine;

  SMExportToXLS1.FileName := ExtractFilePath(Application.ExeName) + 'smexport.xls';

  {add header and footer}
  SMExportToXLS1.Header.Clear;
  SMExportToXLS1.Header.Add(Caption);
  SMExportToXLS1.Header.Add('');

  SMExportToXLS1.Footer.Clear;
  SMExportToXLS1.Footer.Add('');
  SMExportToXLS1.Footer.Add('Generated by SMExport suite: http://www.scalabium.com');

  {start}
  SMExportToXLS1.Execute;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i, j: Integer;
begin
  {fill random values for StringGrid}
  with StringGrid1 do
  begin
    ColCount := Random(100)+5;
    RowCount := Random(1000)+7;
    FixedCols := 1;
    FixedRows := 1;
    for j := 0 to ColCount-1 do
    begin
      ColWidths[j] := Random(150);
      for i := 0 to RowCount-1 do
        Cells[j, i] := 'Random' + IntToStr(Random(10000));
    end;
  end;
end;

end.