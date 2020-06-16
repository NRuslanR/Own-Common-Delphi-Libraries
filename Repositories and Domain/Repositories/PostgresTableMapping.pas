unit PostgresTableMapping;

interface

uses

  DBTableMappingUnit,
  TableMappingUnit,
  TableColumnMappingsUnit;

type

  TPostgresTableMapping = class (TDBTableMapping)

    public

      function GetUpdateListForMultipleUpdates(
        const VALUESRowsLayoutName: String
      ): String;

  end;

implementation

{ TPostgresTableMapping }


function TPostgresTableMapping.GetUpdateListForMultipleUpdates(
  const VALUESRowsLayoutName: String
): String;
var ColumnMapping: TTableColumnMapping;
    ColumnValueSetExpression: String;
begin

  for ColumnMapping in ColumnMappingsForModification do begin

    ColumnValueSetExpression :=
      ColumnMapping.ColumnName +
      '=' +
      VALUESRowsLayoutName + '.' + ColumnMapping.ColumnName;

    if Result = '' then
      Result := ColumnValueSetExpression

    else Result := Result + ',' + ColumnValueSetExpression;

  end;

end;

end.
