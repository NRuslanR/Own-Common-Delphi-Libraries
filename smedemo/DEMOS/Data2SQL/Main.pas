unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, StdCtrls, ExportDS, SME2Cell, SME2SQL;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    DBGrid1: TDBGrid;
    SMExportToSQL1: TSMExportToSQL;
    Button1: TButton;
    cbCreateTable: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Table1.DatabaseName := ExtractFilePath(Application.ExeName);
  Table1.Open;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Table1.Close;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  SMExportToSQL1.FileName := ExtractFilePath(Application.ExeName) + 'customer.sql';
  SMExportToSQL1.AddCreateTable := cbCreateTable.Checked;

  SMExportToSQL1.Execute;
  ShowMessage('SQL-script is generated. '#13#10'Open file' + SMExportToSQL1.FileName)
end;

end.
