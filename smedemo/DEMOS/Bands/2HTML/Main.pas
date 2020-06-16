unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, StdCtrls, ExportDS, SME2Cell, SME2HTML;

type
  TfrmMain = class(TForm)
    dSrcCountry: TDataSource;
    tblCountry: TTable;
    dbgCountry: TDBGrid;
    btnExport: TButton;
    SMExportToHTML1: TSMExportToHTML;
    procedure FormCreate(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure SMExportToHTML1GetExtHTMLTableParamsEvent(Sender: TObject;
      var ExtTableText: String);
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
  SMExportToHTML1.Bands.Clear;
  with SMExportToHTML1.Bands.Add do
  begin
    Caption := 'General information';
    Alignment := taCenter;
    Visible := True;
    Font.Style := [fsBold, fsUnderline];
    Font.Color := clRed;
    Color := clYellow;
  end;
  with SMExportToHTML1.Bands.Add do
  begin
    Caption := 'Details';
    Visible := True;
    Font.Style := [fsBold, fsUnderline];
    Font.Color := clBlue;
    Alignment := taRightJustify;
    Color := clYellow;
  end;

  {2. fill columns/fields (+link to band)}
  SMExportToHTML1.Columns.Clear;
  with SMExportToHTML1.Columns.Add do
  begin
    FieldName := 'Name';
    Title.Caption := 'Name';
    Title.Font.Style := [fsBold];
    Title.Color := cl3DLight;
    Visible := True;
    BandIndex := 0;
  end;

  with SMExportToHTML1.Columns.Add do
  begin
    FieldName := 'Capital';
    Title.Caption := 'Capital';
    Title.Font.Style := [fsBold];
    Title.Color := cl3DLight;
    Visible := True;
    BandIndex := 0;
  end;

  with SMExportToHTML1.Columns.Add do
  begin
    FieldName := 'Continent';
    Title.Caption := 'Continent';
    Title.Font.Style := [fsBold];
    Title.Color := cl3DLight;
    Visible := True;
    BandIndex := 1;
  end;

  with SMExportToHTML1.Columns.Add do
  begin
    FieldName := 'Area';
    Title.Caption := 'Area';
    Title.Font.Style := [fsBold];
    Title.Color := cl3DLight;
    Visible := True;
    Alignment := taRightJustify;
    BandIndex := 1;
  end;

  with SMExportToHTML1.Columns.Add do
  begin
    FieldName := 'Population';
    Title.Caption := 'Population';
    Title.Font.Style := [fsBold];
    Title.Color := cl3DLight;
    Visible := True;
    Alignment := taRightJustify;
    BandIndex := 1;
  end;

  SMExportToHTML1.Options := SMExportToHTML1.Options + [soExportBands];
  SMExportToHTML1.FileName := ExtractFilePath(Application.ExeName) + 'country.htm';
  SMExportToHTML1.Execute
end;

procedure TfrmMain.SMExportToHTML1GetExtHTMLTableParamsEvent(
  Sender: TObject; var ExtTableText: String);
begin
  {to center our table}
  ExtTableText := ExtTableText + ' align="center"'
end;

end.
