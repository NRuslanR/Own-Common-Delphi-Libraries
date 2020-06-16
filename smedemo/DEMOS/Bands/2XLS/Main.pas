unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, StdCtrls, ExportDS, SME2Cell, SME2OLE;

type
  TfrmMain = class(TForm)
    dSrcCountry: TDataSource;
    tblCountry: TTable;
    dbgCountry: TDBGrid;
    btnExport: TButton;
    SMExportToExcel1: TSMExportToExcel;
    procedure FormCreate(Sender: TObject);
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

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  tblCountry.DatabaseName := ExtractFilePath(Application.ExeName);
  tblCountry.Open;
end;

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  {1. fill default columns}
  SMExportToExcel1.BuildDefaultColumns;

  {2. create band list}
  SMExportToExcel1.Bands.Clear;
  with SMExportToExcel1.Bands.Add do
  begin
    Caption := 'General information';
    Alignment := taCenter;
    Visible := True;
    Font.Style := [fsBold, fsUnderline];
    Font.Color := clRed;
    Color := clLime;
  end;
  with SMExportToExcel1.Bands.Add do
  begin
    Caption := 'Details';
    Visible := True;
    Font.Style := [fsBold, fsUnderline];
    Font.Color := clBlue;
    Alignment := taRightJustify;
    Color := clYellow;
  end;

  {3. link columns to bands}
  SMExportToExcel1.Columns[0].BandIndex := 0;
  SMExportToExcel1.Columns[1].BandIndex := 0;
  SMExportToExcel1.Columns[2].BandIndex := 1;
  SMExportToExcel1.Columns[3].BandIndex := 1;
  SMExportToExcel1.Columns[4].BandIndex := 1;

  SMExportToExcel1.Options := SMExportToExcel1.Options + [soExportBands];
  SMExportToExcel1.FileName := ExtractFilePath(Application.ExeName) + 'country.xls';
  SMExportToExcel1.Execute
end;

end.
