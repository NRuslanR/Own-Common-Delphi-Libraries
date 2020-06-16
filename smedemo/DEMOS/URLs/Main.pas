unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ExportDS, SME2Cell, SME2HTML, SMEEngine, StdCtrls, Grids, DBGrids;

type
  TfrmMain = class(TForm)
    tblTips: TTable;
    dSrcTips: TDataSource;
    DBGrid1: TDBGrid;
    btnExport: TButton;
    SaveDialog1: TSaveDialog;
    SMExportToHTML1: TSMExportToHTML;
    tblTipsID: TSmallintField;
    tblTipsTITLE: TStringField;
    tblTipsCATEGORY: TStringField;
    tblTipsCREATED: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure SMExportToHTML1GetCellParams(Sender: TObject; Field: TField;
      var Text: String; AFont: TFont; var Alignment: TAlignment;
      var Background: TColor; var CellType: TCellType);
    procedure SMExportToHTML1GetExtHTMLCellParamsEvent(Sender: TObject;
      Column: TSMEColumn; var ExtTDText: String);
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
  tblTips.DatabaseName := ExtractFilePath(Application.ExeName);
  tblTips.Open;

{  while not tblTips.Eof do
  begin
    if tblTips.FieldByName('CATEGORY1').AsInteger = 13 then
    begin
      tblTips.Edit;
      tblTips.FieldByName('CATEGORY').AsString := 'Miscellaneous';
      tblTips.Post;
    end;
    tblTips.Next
  end;
}end;

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    SMExportToHTML1.FileName := SaveDialog1.FileName;
    SMExportToHTML1.Execute
  end;
end;

procedure TfrmMain.SMExportToHTML1GetCellParams(Sender: TObject;
  Field: TField; var Text: String; AFont: TFont; var Alignment: TAlignment;
  var Background: TColor; var CellType: TCellType);
var
  strFAQID: string;
begin
  if not Assigned(Field) then
    Alignment := taCenter
  else
  if (CompareText(Field.FieldName, 'ID') = 0) then
  begin
    {to convert TipID as href}
    strFAQID := Text;
    while Length(strFAQID) < 4 do
      strFAQID := '0' + strFAQID;
    Text := '<a href="http://www.scalabium.com/faq/dct' + strFAQID +'.htm target="_new"">tip #' + Text + '</a>';
    Alignment := taCenter
  end
  else
  if (Text = '') then
    Text := '&nbsp'
end;

procedure TfrmMain.SMExportToHTML1GetExtHTMLCellParamsEvent(
  Sender: TObject; Column: TSMEColumn; var ExtTDText: String);
begin
  {to add any extended attribute for TD-tag}
  if Assigned(Column) and (CompareText(Column.FieldName, 'ID') = 0) then
    ExtTDText := ExtTDText + ' valign="top"';
end;

procedure TfrmMain.SMExportToHTML1GetExtHTMLTableParamsEvent(
  Sender: TObject; var ExtTableText: String);
begin
  {to add the extended attribute for TABLE-tag}
  ExtTableText := ExtTableText + ' cellpadding="0" cellspacing="0" width="100%" bordercolordark="#FFFFFF" bordercolorlight="#000000"'
end;

end.
