unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExportDS, SME2Cell, SME2OLE, StdCtrls, Grids, DBGrids, ExtCtrls, Db,
  DBTables;

type
  TfrmMain = class(TForm)
    tblIndustry: TTable;
    dSrcIndustry: TDataSource;
    tblCountry: TTable;
    dSrcCountry: TDataSource;
    pnlToolbar: TPanel;
    gbIndustry: TGroupBox;
    gbCountry: TGroupBox;
    Splitter: TSplitter;
    dbgIndustry: TDBGrid;
    dbgCountry: TDBGrid;
    btnExport: TButton;
    SMExportToWord1: TSMExportToWord;
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
  SMExportToWord1.FileName := ExtractFilePath(Application.ExeName) + 'mergeexport.doc';

  {export first dataset}
  SMExportToWord1.DBGrid := dbgIndustry;
  SMExportToWord1.DataSet := tblIndustry;
  SMExportToWord1.Options := SMExportToWord1.Options - [soMergeData];
  SMExportToWord1.Header.Text := 'Industry table:';
  SMExportToWord1.Execute;

  {export second dataset (merged to same file)}
  SMExportToWord1.DBGrid := dbgCountry;
  SMExportToWord1.DataSet := tblCountry;
  SMExportToWord1.Options := SMExportToWord1.Options + [soMergeData];
  SMExportToWord1.Header.Text := 'Country table:';
  SMExportToWord1.Execute;
end;

end.
