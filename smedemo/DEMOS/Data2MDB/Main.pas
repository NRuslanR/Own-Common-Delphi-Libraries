unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExportDS, SME2OLE, StdCtrls, DBCtrls, Grids, DBGrids, Db, DBTables;

type
  TgtmMain = class(TForm)
    tblAnimals: TTable;
    dSrcAnimals: TDataSource;
    dbgAnimals: TDBGrid;
    dbiAnimalImage: TDBImage;
    btnExport: TButton;
    SMExportToAccess1: TSMExportToAccess;
    procedure btnExportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  gtmMain: TgtmMain;

implementation

{$R *.DFM}

procedure TgtmMain.btnExportClick(Sender: TObject);
begin
  {export from dataset}
  SMExportToAccess1.DataSet := tblAnimals;
  SMExportToAccess1.ColumnSource := csDataset;

  {target filename (mdb) and table name}
  SMExportToAccess1.FileName := ExtractFilePath(Application.ExeName) + 'sme.mdb';
  SMExportToAccess1.TableName := 'Animals';

  {options for export}
  SMExportToAccess1.Options := [{soFieldMask, }soShowMessage, soWaitCursor, soDisableControls];
  
  {start export process}
  SMExportToAccess1.Execute;
end;

end.
