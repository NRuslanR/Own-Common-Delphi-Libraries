unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, SMEEngine, ExportDS, SME2Cell, SME2XLS, SMEEngStrings;

type
  TfrmMain = class(TForm)
    btnFill: TButton;
    btnExport: TButton;
    SMExportToXLS: TSMExportToXLS;
    SMEStringsDataEngine1: TSMEStringsDataEngine;
    Memo1: TMemo;
    procedure btnFillClick(Sender: TObject);
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

procedure TfrmMain.btnFillClick(Sender: TObject);
var
  i: Integer;
begin
  Memo1.Lines.Clear;
  for i := 0 to Random(100)+5 do
    Memo1.Lines.Add('Line number ' + IntToStr(Random(1000)))
end;

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  SMEStringsDataEngine1.Strings.Assign(Memo1.Lines);

  SMExportToXLS.ColumnSource := csDataEngine;
  SMExportToXLS.DataEngine := SMEStringsDataEngine1;

  SMExportToXLS.FileName := ExtractFilePath(Application.ExeName) + 'SMExport.XLS';

  SMExportToXLS.Execute
end;

end.
