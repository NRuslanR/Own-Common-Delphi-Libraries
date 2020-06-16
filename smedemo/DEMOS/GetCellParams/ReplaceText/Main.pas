unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Db, DBTables, ExportDS, SMEWiz, SMEEngine;

type
  TfrmMain = class(TForm)
    Table1: TTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    btnExport: TButton;
    SMEWizardDlg1: TSMEWizardDlg;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure SMEWizardDlg1GetCellParams(Sender: TObject; Field: TField;
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
  SMEWizardDlg1.FileName := ExtractFilePath(Application.ExeName) + SMEWizardDlg1.FileName;
  Table1.DatabaseName := ExtractFilePath(Application.ExeName);
  Table1.Open;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  Table1.Close;
end;

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  SMEWizardDlg1.Execute
end;

procedure TfrmMain.SMEWizardDlg1GetCellParams(Sender: TObject; Field: TField;
  var Text: String; AFont: TFont; var Alignment: TAlignment;
  var Background: TColor; var CellType: TCellType);
begin
  if Assigned(Field) and
     (Field.FieldName = 'Name') and
     (Text = 'Brazil') then
  begin
    Alignment := taCenter;
    Text := Text + '  (custom added text for cell from event)';
  end;
end;

end.
