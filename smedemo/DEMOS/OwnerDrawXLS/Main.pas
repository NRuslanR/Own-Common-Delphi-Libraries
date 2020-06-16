unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExportDS, SME2Cell, SME2XLS, SMEEngine, StdCtrls, Grids, DBGrids, Db, DBTables;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    DBGrid1: TDBGrid;
    Button1: TButton;
    SMExportToXLS1: TSMExportToXLS;
    procedure Button1Click(Sender: TObject);
    procedure SMExportToXLS1GetCellParams(Sender: TObject; Field: TField;
      var Text: String; AFont: TFont; var Alignment: TAlignment;
      var Background: TColor; var CellType: TCellType);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  {define custom columns for data export}
  SMExportToXLS1.Columns.Clear;

  with SMExportToXLS1.Columns.Add do
  begin
    FieldName := 'Name';
    Alignment := taLeftJustify;
    Width := 20;
    Title.Caption := 'Country name';
  end;

  with SMExportToXLS1.Columns.Add do
  begin
    FieldName := 'Area';
    Alignment := taRightJustify;
    Width := 15;
    Title.Caption := 'Area';
  end;

  {start an export process}
  SMExportToXLS1.Execute
end;

procedure TForm1.SMExportToXLS1GetCellParams(Sender: TObject;
  Field: TField; var Text: String; AFont: TFont; var Alignment: TAlignment;
  var Background: TColor; var CellType: TCellType);
begin
  {change alignment and font style for some cells}
  if Assigned(Field) and (Field.FieldName = 'Area') then
  begin
    if (Field.AsFloat > 8000000) then
    begin
      Alignment := taCenter;
      AFont.Style := [fsBold]
    end;
  end;
end;

end.
