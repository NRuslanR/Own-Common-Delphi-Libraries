unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExportDS, SME2Cell, SME2XLS, Grids, DBGrids, Db, DBTables, StdCtrls,
  ExtCtrls, ComCtrls;

type
  TfrmXLSExport = class(TForm)
    pnlTop: TPanel;
    btnExport: TButton;
    tblSource: TTable;
    dSrcSource: TDataSource;
    DBGridSource: TDBGrid;
    SMExportToXLS1: TSMExportToXLS;
    lblFilter: TLabel;
    DateTimePicker: TDateTimePicker;
    procedure btnExportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DateTimePickerExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmXLSExport: TfrmXLSExport;

implementation

{$R *.DFM}


procedure TfrmXLSExport.btnExportClick(Sender: TObject);
begin
  SMExportToXLS1.Execute
end;

procedure TfrmXLSExport.FormCreate(Sender: TObject);
begin
  DateTimePicker.Date := tblSource.FieldByName('SaleDate').AsDateTime;
end;

procedure TfrmXLSExport.DateTimePickerExit(Sender: TObject);
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
