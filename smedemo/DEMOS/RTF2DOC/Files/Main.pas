unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ToolWin, SMEEngine, SMEEngStrings, ExportDS,
  SME2Cell, SME2OLE, DB;

type
  TfrmMain = class(TForm)
    ToolBar1: TToolBar;
    btnLoadRTF: TToolButton;
    btnSaveDoc: TToolButton;
    ToolButton1: TToolButton;
    btnExit: TToolButton;
    ImageList1: TImageList;
    RichEdit1: TRichEdit;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SMExportToWord1: TSMExportToWord;
    SMEStringsDataEngine1: TSMEStringsDataEngine;
    procedure btnLoadRTFClick(Sender: TObject);
    procedure btnSaveDocClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.btnLoadRTFClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    RichEdit1.Lines.LoadFromFile(OpenDialog1.FileName)
end;

procedure TfrmMain.btnSaveDocClick(Sender: TObject);
begin
  SaveDialog1.FileName := ChangeFileExt(OpenDialog1.FileName, '.doc');
  if SaveDialog1.Execute then
  begin
    SMExportToWord1.PageSetup.UseDefault := False;
    SMExportToWord1.PageSetup.Measure := emInch;
//    SMExportToWord1.PageSetup.TableWidth := 9;
    SMExportToWord1.PageSetup.LeftMargin := 0.5;
    SMExportToWord1.PageSetup.RightMargin := 0.5;

    SMExportToWord1.FileName := SaveDialog1.FileName;
    SMEStringsDataEngine1.Strings.Assign(RichEdit1.Lines);
    SMExportToWord1.Execute
  end
end;

procedure TfrmMain.btnExitClick(Sender: TObject);
begin
  Close
end;

end.
