unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Db, DBTables, ComCtrls, ExportDS, SME2OLE, SMEEngine,
  SME2Cell;

type
  TfrmMain = class(TForm)
    pcDatasets: TPageControl;
    tsCountry: TTabSheet;
    tsIndustry: TTabSheet;
    tblCountry: TTable;
    dSrcCountry: TDataSource;
    tblIndustry: TTable;
    dSrcIndustry: TDataSource;
    dbgCountry: TDBGrid;
    dbgIndustry: TDBGrid;
    btnExport: TButton;
    SMExportToExcel1: TSMExportToExcel;
    tsCustomer: TTabSheet;
    tblCustomer: TTable;
    dSrcCustomer: TDataSource;
    dbgCustomer: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure SMExportToExcel1GetCellParams(Sender: TObject; Field: TField;
      var Text: String; AFont: TFont; var Alignment: TAlignment;
      var Background: TColor; var CellType: TCellType);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  SMExportToExcel1.FileName := ExtractFilePath(Application.ExeName) + 'smexport.xls';
end;

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  {1. export the Country list on first sheet}
  SMExportToExcel1.Header.Clear;
  SMExportToExcel1.Header.Add('Country list');
  SMExportToExcel1.DBGrid := dbgCountry;
  SMExportToExcel1.DataSet := tblCountry;
  SMExportToExcel1.KeyGenerator := 'Countries and Industries';
  SMExportToExcel1.Options := SMExportToExcel1.Options - [soMergeData];
  SMExportToExcel1.Execute;

  {2. export the Customer list on another sheet}
  SMExportToExcel1.Header.Clear;
  SMExportToExcel1.Header.Add('Customer list');
  SMExportToExcel1.DBGrid := dbgCustomer;
  SMExportToExcel1.DataSet := tblCustomer;
  SMExportToExcel1.KeyGenerator := 'Customers';
  SMExportToExcel1.Options := SMExportToExcel1.Options + [soMergeData];
  SMExportToExcel1.Execute;

  {3. export the Industry list on same sheet where Country list exported}
  SMExportToExcel1.Header.Clear;
  SMExportToExcel1.Header.Add('');
  SMExportToExcel1.Header.Add('Industry list');
  SMExportToExcel1.DBGrid := dbgIndustry;
  SMExportToExcel1.DataSet := tblIndustry;
  SMExportToExcel1.KeyGenerator := 'Countries and Industries';
  SMExportToExcel1.Options := SMExportToExcel1.Options + [soMergeData];
  SMExportToExcel1.Execute;
end;

procedure TfrmMain.SMExportToExcel1GetCellParams(Sender: TObject;
  Field: TField; var Text: String; AFont: TFont; var Alignment: TAlignment;
  var Background: TColor; var CellType: TCellType);
begin
  {change the font for header rows}
  if not Assigned(Field) and
     (TSMExportToExcel(Sender).Statistic.CurrentRow = 0) then
  begin
    AFont.Size := 14;
    AFont.Style := AFont.Style + [fsBold];
    AFont.Color := clRed;
  end;
end;

end.
