unit TableMappingUnit;

interface

uses SysUtils, Classes, TableColumnMappingsUnit;

type

  TTableMapping = class


    protected

      FTableName: String;
      FObjectClass: TClass;
      FObjectListClass: TClass;

      FColumnMappings: TTableColumnMappings;

      procedure SetObjectClass(const Value: TClass);
      procedure SetObjectListClass(const Value: TClass);
      procedure SetTableName(const Value: String);

      function GetColumnMappings: TTableColumnMappings; virtual;
      function GetTableName: String;
      function GetObjectClass: TClass;
      function GetObjectListClass: TClass;
      
    public

      destructor Destroy; override;
      constructor Create;

      procedure SetTableNameMapping(
        const TableName: String;
        ObjectClass: TClass;
        ObjectListClass: TClass = nil
      );

      procedure AddColumnMapping(
        const ColumnName, ObjectPropertyName: String
      );

      property ColumnMappings: TTableColumnMappings read FColumnMappings;

      property TableName: String read GetTableName write SetTableName;
      property ObjectClass: TClass read GetObjectClass write SetObjectClass;
      property ObjectListClass: TClass read GetObjectListClass write SetObjectListClass;

  end;

implementation

{ TTableMapping }

procedure TTableMapping.AddColumnMapping(
  const ColumnName,
  ObjectPropertyName: String
);
begin

  FColumnMappings.AddColumnMapping(
    ColumnName, ObjectPropertyName
  );
  
end;

constructor TTableMapping.Create;
begin

  inherited;

  FColumnMappings := GetColumnMappings;

end;

destructor TTableMapping.Destroy;
begin

  FreeAndNil(FColumnMappings);
  inherited;

end;

function TTableMapping.GetColumnMappings: TTableColumnMappings;
begin

  Result := TTableColumnMappings.Create;
  
end;

function TTableMapping.GetObjectClass: TClass;
begin

  Result := FObjectClass;
  
end;

function TTableMapping.GetObjectListClass: TClass;
begin

  Result := FObjectListClass;
  
end;

function TTableMapping.GetTableName: String;
begin

  Result := FTableName;
  
end;

procedure TTableMapping.SetObjectClass(const Value: TClass);
begin

  FObjectClass := Value;
  
end;

procedure TTableMapping.SetObjectListClass(const Value: TClass);
begin

  FObjectListClass := Value;
  
end;

procedure TTableMapping.SetTableName(const Value: String);
begin

  FTableName := Value;
  
end;

procedure TTableMapping.SetTableNameMapping(
  const TableName: String;
  ObjectClass: TClass;
  ObjectListClass: TClass
);
begin

  FTableName := TableName;
  FObjectClass := ObjectClass;
  FObjectListClass := ObjectListClass;
  
end;

end.
