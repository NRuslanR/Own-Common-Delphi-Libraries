unit ZDataSetReader;

interface

uses

  DataSetDataReader,
  DB,
  SysUtils,
  Classes;

type

  TZDataSetReader = class (TDataSetDataReader)

    public

      function ToDataSet: TDataSet; override;

  end;

implementation

uses

  ZDataset,
  ZSqlUpdate;

{ TZDataSetReader }

function TZDataSetReader.ToDataSet: TDataSet;
begin

  Result := inherited ToDataSet;

  with Result as TZQuery do
    UpdateObject := TZUpdateSQL.Create(Result);
    
end;

end.
