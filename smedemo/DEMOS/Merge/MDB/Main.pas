unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExportDS, SME2OLE, Db, DBTables, Grids, DBGrids;

type
  TfrmMain = class(TForm)
    Query1: TQuery;
    Query2: TQuery;
    Query3: TQuery;
    SMExportToAccess1: TSMExportToAccess;
    btnExport: TButton;
    lblURL: TLabel;
    MemoNote: TMemo;
    btnAbout: TButton;
    procedure btnExportClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure lblURLClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

uses ShellAPI;

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  {we export from datasets}
  SMExportToAccess1.ColumnSource := csDataset;

  {database name (mdb-file)}
  SMExportToAccess1.FileName := ExtractFilePath(Application.ExeName) + 'smexport.mdb';

  {1. export first query with COUNTRY list
  Note:
  if such table exists in mdb, will be re-created with new structure}
  SMExportToAccess1.Options := SMExportToAccess1.Options - [soMergeData];
  SMExportToAccess1.TableName := 'CLIENTS';
  SMExportToAccess1.Dataset := Query1;
  SMExportToAccess1.Execute;

  {2. export second query with clients from California
   Note:
   Table=Clients will be recreated in mdb-file}
  SMExportToAccess1.Options := SMExportToAccess1.Options - [soMergeData];
  SMExportToAccess1.TableName := 'CLIENTS';
  SMExportToAccess1.Dataset := Query1;
  SMExportToAccess1.Execute;

  {3. export third query with clients from Massachusetts
   Note:
   merge with second exported table in Table=Clients (mdb-file)}
  SMExportToAccess1.Options := SMExportToAccess1.Options + [soMergeData];
  SMExportToAccess1.TableName := 'CLIENTS';
  SMExportToAccess1.Dataset := Query2;
  SMExportToAccess1.Execute;

  ShowMessage('Export is completed')
end;

procedure TfrmMain.btnAboutClick(Sender: TObject);
begin
  SMExportToAccess1.AboutSME
end;

procedure TfrmMain.lblURLClick(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar((Sender as TLabel).Caption), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  {open all our queries}
  Query1.Open;
  Query2.Open;
  Query3.Open;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  {close all our queries}
  Query1.Open;
  Query2.Open;
  Query3.Open;
end;

end.
