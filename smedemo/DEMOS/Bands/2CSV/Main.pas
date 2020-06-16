unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, StdCtrls, ExportDS, SME2Cell, SME2TXT;

type
  TfrmMain = class(TForm)
    dSrcCountry: TDataSource;
    tblCountry: TTable;
    dbgCountry: TDBGrid;
    btnExport: TButton;
    SMExportToCSV1: TSMExportToText;
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
  {1. fill band list}
  SMExportToCSV1.Bands.Clear;
  with SMExportToCSV1.Bands.Add do
  begin
    Caption := 'General information';
    Alignment := taCenter;
    Visible := True;
    Font.Style := [fsBold, fsUnderline];
    Font.Color := clRed;
    Color := clYellow;
  end;
  with SMExportToCSV1.Bands.Add do
  begin
    Caption := 'Details';
    Visible := True;
    Font.Style := [fsBold, fsUnderline];
    Font.Color := clBlue;
    Alignment := taRightJustify;
    Color := clYellow;
  end;

  {2. fill columns/fields (+link to band)}
  SMExportToCSV1.Columns.Clear;
  with SMExportToCSV1.Columns.Add do
  begin
    FieldName := 'Name';
    Title.Caption := 'Name';
    Title.Font.Style := [fsBold];
    Title.Color := cl3DLight;
    Visible := True;
    BandIndex := 0;
  end;

  with SMExportToCSV1.Columns.Add do
  begin
    FieldName := 'Capital';
    Title.Caption := 'Capital';
    Title.Font.Style := [fsBold];
    Title.Color := cl3DLight;
    Visible := True;
    BandIndex := 0;
  end;

  with SMExportToCSV1.Columns.Add do
  begin
    FieldName := 'Continent';
    Title.Caption := 'Continent';
    Title.Font.Style := [fsBold];
    Title.Color := cl3DLight;
    Visible := True;
    BandIndex := 1;
  end;

  with SMExportToCSV1.Columns.Add do
  begin
    FieldName := 'Area';
    Title.Caption := 'Area';
    Title.Font.Style := [fsBold];
    Title.Color := cl3DLight;
    Visible := True;
    Alignment := taRightJustify;
    BandIndex := 1;
  end;

  with SMExportToCSV1.Columns.Add do
  begin
    FieldName := 'Population';
    Title.Caption := 'Population';
    Title.Font.Style := [fsBold];
    Title.Color := cl3DLight;
    Visible := True;
    Alignment := taRightJustify;
    BandIndex := 1;
  end;

  SMExportToCSV1.Options := SMExportToCSV1.Options + [soExportBands];
  SMExportToCSV1.FileName := ExtractFilePath(Application.ExeName) + 'country.csv';
  SMExportToCSV1.Execute
end;

end.
