unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExportDS, SME2Cell, SME2OLE, StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids,
  Db, DBTables;

type
  TfrmMain = class(TForm)
    dSrcAnimals: TDataSource;
    tblAnimals: TTable;
    dbgAnimals: TDBGrid;
    dbiPicture: TDBImage;
    pnlAction: TPanel;
    btnExport: TButton;
    SMExportToWord1: TSMExportToWord;
    SaveDialog: TSaveDialog;
    tblAnimalsNAME: TStringField;
    tblAnimalsSIZE: TSmallintField;
    tblAnimalsWEIGHT: TSmallintField;
    tblAnimalsAREA: TStringField;
    tblAnimalsBMP: TBlobField;
    lblURL: TLabel;
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
{$R winxp.res}

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    SMExportToWord1.FileName := SaveDialog.FileName;
    SMExportToWord1.Execute;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  SaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
end;

end.
