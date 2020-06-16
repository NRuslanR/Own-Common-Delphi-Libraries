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
    SMExportToWord1: TSMExportToWord;
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
  SMExportToWord1.Bands.Clear;
  with SMExportToWord1.Bands.Add do
  begin
    Caption := 'General information';
    Visible := True;
    Font.Style := [fsBold];
    Font.Color := clRed;
    Color := clWindow;
  end;
  with SMExportToWord1.Bands.Add do
  begin
    Caption := 'Details';
    Visible := True;
    Font.Style := [fsBold];
    Font.Color := clBlue;
    Color := clWindow;
  end;

  {2. fill columns/fields (+link to band)}
  SMExportToWord1.Columns.Clear;
  with SMExportToWord1.Columns.Add do
  begin
    FieldName := 'Name';
    Title.Caption := 'Name';
    Title.Font.Style := [fsBold];
    Title.Color := clWindow;
    Visible := True;
    BandIndex := 0;
  end;

  with SMExportToWord1.Columns.Add do
  begin
    FieldName := 'Capital';
    Title.Caption := 'Capital';
    Title.Font.Style := [fsBold];
    Title.Color := clWindow;
    Visible := True;
    BandIndex := 0;
  end;

  with SMExportToWord1.Columns.Add do
  begin
    FieldName := 'Continent';
    Title.Caption := 'Continent';
    Title.Font.Style := [fsBold];
    Title.Color := clWindow;
    Visible := True;
    BandIndex := -1;
  end;

  with SMExportToWord1.Columns.Add do
  begin
    FieldName := 'Area';
    Title.Caption := 'Area';
    Title.Font.Style := [fsBold];
    Title.Color := clWindow;
    Visible := True;
    Alignment := taRightJustify;
    BandIndex := 1;
  end;

  with SMExportToWord1.Columns.Add do
  begin
    FieldName := 'Population';
    Title.Caption := 'Population';
    Title.Font.Style := [fsBold];
    Title.Color := clWindow;
    Visible := True;
    Alignment := taRightJustify;
    BandIndex := 1;
  end;

  SMExportToWord1.Options := SMExportToWord1.Options + [soExportBands];
  SMExportToWord1.FileName := ExtractFilePath(Application.ExeName) + 'country.doc';
  SMExportToWord1.Execute
end;

end.
