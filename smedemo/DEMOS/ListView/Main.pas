unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, SMEEngine, ExportDS, SME2Cell, SME2XLS,
  ComCtrls, SMEEngLV, SME2HTML;

type
  TfrmMain = class(TForm)
    btnFill: TButton;
    btnExport: TButton;
    ListView1: TListView;
    SMEListViewDataEngine: TSMEListViewDataEngine;
    SMExportToHTML: TSMExportToHTML;
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
  li: TListItem;
begin
  for i := 0 to Random(100)+4 do
  begin
    li := ListView1.Items.Add;
    li.Caption := IntToStr(i+1);
    li.SubItems.Add('Code' + li.Caption);
    li.SubItems.Add('Name ' + li.Caption);
    li.SubItems.Add(IntToStr(Random(1000)));
    li.SubItems.Add(IntToStr(Random(1000)));
  end;
end;

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  SMExportToHTML.FileName := ExtractFilePath(Application.ExeName) + 'SMExport.html';
  SMExportToHTML.Execute
end;

end.
