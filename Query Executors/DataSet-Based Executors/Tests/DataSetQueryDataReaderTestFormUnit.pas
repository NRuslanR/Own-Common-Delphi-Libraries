unit DataSetQueryDataReaderTestFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataSetQueryDataReader, QueryDataReader, DB, dxmdaset;

type
  TDataSetQueryDataReaderTestForm = class(TForm)
    dxMemData1: TdxMemData;
    dxMemData1test: TIntegerField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataSetQueryDataReaderTestForm: TDataSetQueryDataReaderTestForm;

implementation

uses

  AuxDebugFunctionsUnit;

{$R *.dfm}

procedure TDataSetQueryDataReaderTestForm.FormCreate(Sender: TObject);
var Reader: IQueryDataReader;
begin

  Reader := TDataSetQueryDataReader.Create(dxMemData1);

  while Reader.Next do begin

    DebugOutput(Reader['test']);
    
  end;

end;

end.
