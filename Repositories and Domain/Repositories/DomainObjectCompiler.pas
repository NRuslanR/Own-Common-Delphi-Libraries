unit DomainObjectCompiler;

interface

uses

  DataReader,
  TableColumnMappingsUnit,
  DomainObjectBaseUnit;

type

  TDomainObjectCompiler = class

    protected

      FColumnMappings: TTableColumnMappings;

      function CanBeValueAssignedToObjectProperty(
        const ObjectPropertyName: String;
        Value: Variant;
        const FieldName: String;
        DataReader: IDataReader
      ): Boolean; virtual;

      function GetFieldNameFromColumnMapping(
        ColumnMapping: TTableColumnMapping
      ): String; virtual;

    public

      constructor Create; overload;
      constructor Create(ColumnMappings: TTableColumnMappings); overload;

      procedure CompileDomainObject(
        DomainObject: TDomainObjectBase;
        DataReader: IDataReader
      ); virtual;

      property ColumnMappings: TTableColumnMappings
      read FColumnMappings write FColumnMappings;
      
  end;

implementation

uses

  Variants,
  ReflectionServicesUnit,
  AuxDebugFunctionsUnit,
  DBTableColumnMappingsUnit,
  Classes;

{ TDomainObjectCompiler }

constructor TDomainObjectCompiler.Create;
begin
                  
  inherited;

end;

function TDomainObjectCompiler.CanBeValueAssignedToObjectProperty(
  const ObjectPropertyName: String;
  Value: Variant;
  const FieldName: String;
  DataReader: IDataReader
): Boolean;
begin

  Result := True;

end;

constructor TDomainObjectCompiler.Create(
  ColumnMappings: TTableColumnMappings);
begin

  inherited Create;

  Self.ColumnMappings := ColumnMappings;

end;

function TDomainObjectCompiler.GetFieldNameFromColumnMapping(
  ColumnMapping: TTableColumnMapping
): String;
begin

  if ColumnMapping is TDBTableColumnMapping then begin

    with ColumnMapping as TDBTableColumnMapping do begin

      if AliasColumnName <> '' then
        Result := AliasColumnName

      else Result := ColumnName;

    end;

  end

  else Result := ColumnMapping.ColumnName;
    
end;

procedure TDomainObjectCompiler.CompileDomainObject(
  DomainObject: TDomainObjectBase;
  DataReader: IDataReader
);
var ColumnMapping: TTableColumnMapping;
    FieldName: String;
    PropertyValue: Variant;
begin

  for ColumnMapping in ColumnMappings do begin

    if not ColumnMapping.AllowMappingOnObjectProperty then
      Continue;
    
    FieldName := GetFieldNameFromColumnMapping(ColumnMapping);

    PropertyValue := DataReader.GetValue(FieldName);

    if  CanBeValueAssignedToObjectProperty(
          ColumnMapping.ObjectPropertyName,
          PropertyValue,
          FieldName,
          DataReader
        )

    then begin
    
      TReflectionServices.SetObjectPropertyValue(
        DomainObject,
        ColumnMapping.ObjectPropertyName,
        PropertyValue
      );
      
    end;

  end;

end;

end.
