unit DBTableColumnMappingsUnit;

interface

uses

  TableColumnMappingsUnit,
  SysUtils,
  Classes;

type

  TDBTableColumnMapping = class (TTableColumnMapping)

    private

      FConversionTypeName: String;
      FAliasColumnName: String;
      FTableName: String;

    public

      constructor Create; overload;
      constructor Create(
        const ColumnName, ObjectPropertyName,
              AliasColumnName, TableName: String;
        const AllowMappingOnDomainObjectProperty: Boolean = True;
        const ConversionTypeName: String = ''
      ); overload;

      property ConversionTypeName: String
      read FConversionTypeName write FConversionTypeName;
      
      property AliasColumnName: String
      read FAliasColumnName write FAliasColumnName;

      property TableName: String
      read FTableName write FTableName;

  end;

  TDBTableColumnMappings = class;

  TDBTableColumnMappingsEnumerator = class (TTableColumnMappingsEnumerator)

    private

      function GetCurrentDBColumnMapping: TDBTableColumnMapping;

      constructor Create(
        TableColumnMappings: TDBTableColumnMappings
      );

    public

      property Current: TDBTableColumnMapping read GetCurrentDBColumnMapping;

  end;

  TDBTableColumnMappings = class (TTableColumnMappings)

    protected

      function GetDBColumnMappingByIndex(Index: Integer): TDBTableColumnMapping;
      procedure SetDBColumnMappingByIndex(
        Index: Integer;
        ColumnMapping: TDBTableColumnMapping
      );

      function GetTableColumnMappingClass: TTableColumnMappingClass; override;

    public

      function GetEnumerator: TDBTableColumnMappingsEnumerator;

      property Items[Index: Integer]: TDBTableColumnMapping
      read GetDBColumnMappingByIndex write SetDBColumnMappingByIndex; default;

      function AddColumnMappingWithAlias(
        const ColumnName, ObjectPropertyName,
              AliasColumnName: String;
        const AllowMappingOnDomainObjectProperty: Boolean = True;
        const ConversionTypeName: String = ''
      ): TDBTableColumnMapping;

      function AddColumnMappingWithTableName(
        const ColumnName, ObjectPropertyName,
              TableName: String;
        const AllowMappingOnDomainObjectProperty: Boolean = True;
        const ConversionTypeName: String = ''
      ): TDBTableColumnMapping;

      function AddColumnMappingWithAliasAndTableName(
        const ColumnName, ObjectPropertyName,
              AliasColumnName, TableName: String;
        const AllowMappingOnDomainObjectProperty: Boolean = True;
        const ConversionTypeName: String = ''
      ): TDBTableColumnMapping;

      function AddColumnMapping(
        const ColumnName, ObjectPropertyName: String;
        const AllowMappingOnDomainObjectProperty: Boolean = True
      ): TTableColumnMappings; overload; override;

      function AddColumnMapping(
        const ColumnName, ObjectPropertyName: String;
        const ConversionTypeName: String;
        const AllowMappingOnDomainObjectProperty: Boolean = True
      ): TTableColumnMappings; overload;

      procedure RemoveColumnMapping(
        const ColumnName: String
      ); override;

      function FindColumnMappingByColumnName(
        const ColumnName: string
      ): TTableColumnMapping; override;

      function FindColumnMappingByObjectPropertyName(
        const ObjectPropertyName: string
      ): TTableColumnMapping; override;

  end;

implementation

{ DBTTableColumnMapping }

constructor TDBTableColumnMapping.Create;
begin

  inherited;
  
end;

constructor TDBTableColumnMapping.Create(
  const ColumnName, ObjectPropertyName,
        AliasColumnName, TableName: String;
  const AllowMappingOnDomainObjectProperty: Boolean;
  const ConversionTypeName: String
);
begin

  inherited
    Create(
      ColumnName,
      ObjectPropertyName,
      AllowMappingOnDomainObjectProperty
    );

  Self.ConversionTypeName := ConversionTypeName;
  Self.AliasColumnName := AliasColumnName;
  Self.ObjectPropertyName := ObjectPropertyName;
  
end;

{ TDBTableColumnMappingsEnumerator }

constructor TDBTableColumnMappingsEnumerator.Create(
  TableColumnMappings: TDBTableColumnMappings);
begin

  inherited Create(TableColumnMappings);
  
end;

function TDBTableColumnMappingsEnumerator.GetCurrentDBColumnMapping: TDBTableColumnMapping;
begin

  Result := TDBTableColumnMapping(GetCurrentColumnMapping);
  
end;

{ TDBTableColumnMappings }

function TDBTableColumnMappings.AddColumnMapping(
  const ColumnName,
  ObjectPropertyName: String;
  const AllowMappingOnDomainObjectProperty: Boolean
): TTableColumnMappings;
var ColumnMapping: TTableColumnMapping;
begin

  Result :=
    inherited
    AddColumnMapping(
      ColumnName,
      ObjectPropertyName,
      AllowMappingOnDomainObjectProperty
    );

end;

function TDBTableColumnMappings.AddColumnMapping(
  const ColumnName, ObjectPropertyName: String;
  const ConversionTypeName: String;
  const AllowMappingOnDomainObjectProperty: Boolean
): TTableColumnMappings;
var ColumnMapping: TTableColumnMapping;
begin

  AddColumnMapping(
    ColumnName,
    ObjectPropertyName,
    AllowMappingOnDomainObjectProperty
  );

  ColumnMapping := FindColumnMappingByColumnName(ColumnName);

  if Assigned(ColumnMapping) then
    (ColumnMapping as TDBTableColumnMapping)
      .ConversionTypeName := ConversionTypeName;
  
end;

function TDBTableColumnMappings.AddColumnMappingWithAlias(
  const ColumnName,
  ObjectPropertyName,
  AliasColumnName: String;
  const AllowMappingOnDomainObjectProperty: Boolean;
  const ConversionTypeName: String
): TDBTableColumnMapping;
begin

  if Assigned(FindColumnMappingByObjectPropertyName(ObjectPropertyName))
  then Exit;

  Add(
    TDBTableColumnMapping.Create(
        ColumnName,
        ObjectPropertyName,
        AliasColumnName,
        '',
        AllowMappingOnDomainObjectProperty,
        ConversionTypeName
      )
  );

end;

function TDBTableColumnMappings.AddColumnMappingWithAliasAndTableName(
  const ColumnName, ObjectPropertyName, AliasColumnName, TableName: String;
  const AllowMappingOnDomainObjectProperty: Boolean;
  const ConversionTypeName: String
): TDBTableColumnMapping;
begin

  if Assigned(FindColumnMappingByObjectPropertyName(ObjectPropertyName))
  then Exit;

  Add(
    TDBTableColumnMapping.Create(
        ColumnName,
        ObjectPropertyName,
        AliasColumnName,
        TableName,
        AllowMappingOnDomainObjectProperty,
        ConversionTypeName
    )
  );
  
end;

function TDBTableColumnMappings.AddColumnMappingWithTableName(
  const ColumnName,
  ObjectPropertyName,
  TableName: String;
  const AllowMappingOnDomainObjectProperty: Boolean;
  const ConversionTypeName: String
): TDBTableColumnMapping;
begin

  if Assigned(FindColumnMappingByObjectPropertyName(ObjectPropertyName))
  then Exit;

  Add(
    TDBTableColumnMapping.Create(
        ColumnName,
        ObjectPropertyName,
        '',
        TableName,
        AllowMappingOnDomainObjectProperty,
        ConversionTypeName
    )
  );

end;

function TDBTableColumnMappings.FindColumnMappingByColumnName(
  const ColumnName: string): TTableColumnMapping;
var DBTableColumnMapping: TDBTableColumnMapping;
begin

  for DBTableColumnMapping in Self do
    if
        (DBTableColumnMapping.ColumnName = ColumnName) and
        (DBTableColumnMapping.TableName = '')

    then begin

      Result := DBTableColumnMapping;
      Exit;
      
    end;

  Result := nil;
    
end;

function TDBTableColumnMappings.FindColumnMappingByObjectPropertyName(
  const ObjectPropertyName: string): TTableColumnMapping;
begin

  Result := inherited FindColumnMappingByObjectPropertyName(ObjectPropertyName);

end;

function TDBTableColumnMappings.GetDBColumnMappingByIndex(
  Index: Integer): TDBTableColumnMapping;
begin

  Result := TDBTableColumnMapping(GetColumnMappingByIndex(Index));
  
end;

function TDBTableColumnMappings.GetEnumerator: TDBTableColumnMappingsEnumerator;
begin

  Result := TDBTableColumnMappingsEnumerator.Create(Self);
  
end;

function TDBTableColumnMappings.GetTableColumnMappingClass: TTableColumnMappingClass;
begin

  Result := TDBTableColumnMapping;
  
end;

procedure TDBTableColumnMappings.RemoveColumnMapping(const ColumnName: String);
begin

  inherited;

end;

procedure TDBTableColumnMappings.SetDBColumnMappingByIndex(Index: Integer;
  ColumnMapping: TDBTableColumnMapping);
begin

  SetColumnMappingByIndex(Index, ColumnMapping);
  
end;

end.
