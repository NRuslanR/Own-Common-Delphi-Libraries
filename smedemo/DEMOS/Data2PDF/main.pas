unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExportDS, SME2Cell, SME2XLS, Grids, DBGrids, Db, DBTables, StdCtrls,
  ExtCtrls, ComCtrls, SME2PDF;

type
  TfrmPDFExport = class(TForm)
    pnlTop: TPanel;
    btnExport: TButton;
    tblSource: TTable;
    dSrcSource: TDataSource;
    DBGridSource: TDBGrid;
    lblFilter: TLabel;
    DateTimePicker: TDateTimePicker;
    SMExportToPDF1: TSMExportToPDF;
    procedure btnExportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DateTimePickerExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPDFExport: TfrmPDFExport;

implementation

{$R *.DFM}


procedure TfrmPDFExport.btnExportClick(Sender: TObject);
begin
  SMExportToPDF1.Execute
end;

procedure TfrmPDFExport.FormCreate(Sender: TObject);
begin
  tblSource.DatabaseName := ExtractFilePath(Application.ExeName);
  tblSource.Open;
  DateTimePicker.Date := tblSource.FieldByName('SaleDate').AsDateTime;
end;

procedure TfrmPDFExport.DateTimePickerExit(Sender: TObject);
var
  PureDateWithoutTime: TDateTime;
begin
  {re switch a filter}
  tblSource.DisableControls;
  tblSource.Filtered := False;

  {the field can contain a date AND time but in TDateTimePicker we entered a pure date only
   so we must filter a data by '(Field => day) AND (Field < day+1)'}

  {1. read an entered date}
  PureDateWithoutTime := Trunc(DateTimePicker.Date);
  {set filter}
  tblSource.Filter := '(SaleDate = ''' + FormatDateTime('dd/mm/yyyy', PureDateWithoutTime) + ''')' +
                      ' AND ' +
                      '(SaleDate < ''' + FormatDateTime('dd/mm/yyyy', PureDateWithoutTime+1) + ''')';

  tblSource.Filtered := True;
  tblSource.EnableControls;
end;

end.
