unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, StdCtrls, ExportDS, SME2Cell, SME2PDF;

type
  TfrmMain = class(TForm)
    dSrcCountry: TDataSource;
    tblCountry: TTable;
    dbgCountry: TDBGrid;
    btnExport: TButton;
    SMExportToPDF1: TSMExportToPDF;
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
  SMExportToPDF1.BuildDefaultColumns;

  {2. create band list}
  SMExportToPDF1.Bands.Clear;
  with SMExportToPDF1.Bands.Add do
  begin
    Caption := 'General information';
    Visible := True;
    Font.Style := [fsBold];
    Font.Color := clRed;
    Color := clWindow;
  end;
  with SMExportToPDF1.Bands.Add do
  begin
    Caption := 'Details';
    Visible := True;
    Font.Style := [fsBold];
    Font.Color := clBlue;
    Color := clWindow;
  end;

  {3. link columns to bands}
  SMExportToPDF1.Columns[0].BandIndex := 0;
  SMExportToPDF1.Columns[1].BandIndex := 0;
  SMExportToPDF1.Columns[2].BandIndex := 1;
  SMExportToPDF1.Columns[3].BandIndex := 1;
  SMExportToPDF1.Columns[4].BandIndex := 1;

  SMExportToPDF1.Options := SMExportToPDF1.Options + [soExportBands];
  SMExportToPDF1.FileName := ExtractFilePath(Application.ExeName) + 'country.pdf';
  SMExportToPDF1.Execute
end;

end.
