unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, ExtCtrls, ExportDS, SME2OLE, StdCtrls;

type
  TfrmMain = class(TForm)
    dSrcOfferte: TDataSource;
    tblOfferte: TTable;
    tblItems: TTable;
    dSrcItems: TDataSource;
    dbgOfferte: TDBGrid;
    dbgItems: TDBGrid;
    Splitter: TSplitter;
    pnlTop: TPanel;
    btnExport: TButton;
    smeOfferte: TSMExportToExcel;
    smeItem: TSMExportToExcel;
    procedure FormCreate(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
  private
    { Private declarations }
    procedure MasterRecordChanged(DataSet: TDataSet);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  tblOfferte.DatabaseName := ExtractFilePath(Application.ExeName);
  tblItems.DatabaseName := ExtractFilePath(Application.ExeName);

  tblOfferte.Open;
  tblItems.Open;

  smeOfferte.FileName := ExtractFilePath(Application.ExeName) + smeOfferte.FileName;
  smeItem.FileName := ExtractFilePath(Application.ExeName) + smeItem.FileName;
end;

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  {master dataset}
  tblOfferte.AfterScroll := MasterRecordChanged;
  smeOfferte.KeyGenerator := 'Offerte'; {sheet name}
  smeOfferte.Execute;
  tblOfferte.AfterScroll := nil;
end;

procedure TfrmMain.MasterRecordChanged(DataSet: TDataSet);
begin
  {detail dataset}
  smeItem.KeyGenerator := 'items'; {sheet name}
  smeItem.Options := smeItem.Options + [soMergeData];
  smeItem.Execute
end;

end.
