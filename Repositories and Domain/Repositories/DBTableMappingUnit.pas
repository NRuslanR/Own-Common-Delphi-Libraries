unit DBTableMappingUnit;

interface

uses

  TableMappingUnit,
  TableColumnMappingsUnit,
  DBTableColumnMappingsUnit,
  Classes;

type

  TColumnNamingMode = (
    UseFullyQualifiedColumnNaming,
    UseNonQualifiedColumnNaming
  );
  
  TDBTableMapping = class (TTableMapping)

    protected

      FAliasTableName: String;
      
      FColumnMappingsForSelect: TDBTableColumnMappings;
      FPrimaryKeyColumnMappings: TDBTableColumnMappings;

      function GetSelectList(const CustomTableNamePrefix: string = ''): String;
      function GetAliasColumnAssigningOperatorName: String; virtual;
      function GetColumnMappings: TTableColumnMappings; override;
      function GetTableNameWithAlias: String;
      function GetColumnMappingsForModification: TDBTableColumnMappings;

    public

      destructor Destroy; override;
      constructor Create;

      procedure SetTableNameMappingWithAlias(
        const TableName: String;
        ObjectClass: TClass;
        const AliasTableName: String;
        ObjectListClass: TClass = nil
      );
      
      function AddColumnMappingForSelectWithAlias(
        const ColumnName, ObjectPropertyName,
              AliasColumnName: String;
        const AllowMappingOnDomainObjectProperty: Boolean = True
      ): TDBTableColumnMapping;

      function FindSelectColumnMappingByObjectPropertyName(
        const ObjectPropertyName: string
      ): TDBTableColumnMapping; 
      
      function AddColumnMappingForSelectWithOtherTableName(
        const ColumnName, ObjectPropertyName, TableName: String;
        const AllowMappingOnDomainObjectProperty: Boolean = True
      ): TDBTableColumnMapping;

      function AddColumnMappingForSelectWithAliasAndOtherTableName(
        const ColumnName, ObjectPropertyName,
              AliasColumnName, TableName: String;
        const AllowMappingOnDomainObjectProperty: Boolean = True
      ): TDBTableColumnMapping;

      procedure AddColumnMappingForSelect(
        const ColumnName, ObjectPropertyName: String;
        const AllowMappingOnDomainObjectProperty: Boolean = True
      );

      procedure AddColumnNameForSelect(
        const ColumnName: String
      );

      procedure AddColumnNameWithAliasForSelect(
        const ColumnName, AliasColumnName: String
      );
      
      procedure AddColumnMappingForModification(
        const ColumnName, ObjectPropertyName: String;
        const ConversionTypeName: String = ''
      );

      procedure AddPrimaryKeyColumnMapping(
        const ColumnName, ObjectPropertyName: String;
        const ConversionTypeName: String = ''
      );
      
      property ColumnMappingsForSelect: TDBTableColumnMappings
      read FColumnMappingsForSelect;

      property ColumnMappingsForModification: TDBTableColumnMappings
      read GetColumnMappingsForModification;

      property PrimaryKeyColumnMappings: TDBTableColumnMappings
      read FPrimaryKeyColumnMappings;

      function GetSelectListForSelectGroup(
        const CustomTableNamePrefix: String = ''
      ): String;
      
      procedure GetSelectListForSelectByIdentity(
        var SelectList: String; var WhereClauseForSelectByIdentity: String
      );

      function GetUpdateList: String;

      procedure GetInsertList(
        var ColumnNameList: String;
        var ColumnValuePlaceholderList: String
      );

      function GetModificationColumnCommaSeparatedList: String;
      function GetSelectColumnNameListWithoutTablePrefix: String;
      function GetUniqueObjectColumnCommaSeparatedList(
        const ColumnNamingMode: TColumnNamingMode
      ): String;
      function GetWhereClauseForSelectUniqueObject: String;

    published

      property AliasTableName: String read FAliasTableName;
      property TableNameWithAlias: String read GetTableNameWithAlias;
      
  end;

implementation

uses SysUtils;

{ TDBTableMapping }

procedure TDBTableMapping.AddColumnMappingForModification(
  const ColumnName, ObjectPropertyName: String;
  const ConversionTypeName: String
);
begin

  ColumnMappingsForModification.AddColumnMapping(
    ColumnName,
    ObjectPropertyName,
    ConversionTypeName
  );

end;

procedure TDBTableMapping.AddColumnMappingForSelect(
  const ColumnName, ObjectPropertyName: String;
  const AllowMappingOnDomainObjectProperty: Boolean
);
begin

  FColumnMappingsForSelect.AddColumnMapping(
    ColumnName, ObjectPropertyName, AllowMappingOnDomainObjectProperty
  );

end;

function TDBTableMapping.AddColumnMappingForSelectWithAlias(
  const ColumnName,
  ObjectPropertyName, AliasColumnName: String;
  const AllowMappingOnDomainObjectProperty: Boolean
): TDBTableColumnMapping;
begin

  FColumnMappingsForSelect.AddColumnMappingWithAlias(
    ColumnName, ObjectPropertyName, AliasColumnName,
    AllowMappingOnDomainObjectProperty
  );
  
end;

function TDBTableMapping.AddColumnMappingForSelectWithAliasAndOtherTableName(
  const ColumnName, ObjectPropertyName, AliasColumnName, TableName: String;
  const AllowMappingOnDomainObjectProperty: Boolean
): TDBTableColumnMapping;
begin

  FColumnMappingsForSelect.AddColumnMappingWithAliasAndTableName(
    ColumnName, ObjectPropertyName, AliasColumnName, TableName,
    AllowMappingOnDomainObjectProperty
  );
  
end;

function TDBTableMapping.AddColumnMappingForSelectWithOtherTableName(
  const ColumnName, ObjectPropertyName, TableName: String;
  const AllowMappingOnDomainObjectProperty: Boolean
): TDBTableColumnMapping;
begin

  FColumnMappingsForSelect.AddColumnMappingWithTableName(
    ColumnName, ObjectPropertyName, TableName,
    AllowMappingOnDomainObjectProperty
  );
  
end;

procedure TDBTableMapping.AddColumnNameForSelect(
  const ColumnName: String
);
begin

  AddColumnMappingForSelect(
    ColumnName, '', False
  );

end;

procedure TDBTableMapping.AddColumnNameWithAliasForSelect(
  const ColumnName, AliasColumnName: String
);
begin

  AddColumnMappingForSelectWithAlias(
    ColumnName, '', AliasColumnName, False
  );

end;

procedure TDBTableMapping.AddPrimaryKeyColumnMapping(
  const ColumnName, ObjectPropertyName: String;
  const ConversionTypeName: String
);
begin

  FPrimaryKeyColumnMappings.AddColumnMapping(
    ColumnName, ObjectPropertyName, ConversionTypeName
  );

end;

constructor TDBTableMapping.Create;
begin

  inherited;

  FColumnMappingsForSelect := GetColumnMappings as TDBTableColumnMappings;
  FPrimaryKeyColumnMappings := GetColumnMappings as TDBTableColumnMappings;

end;

destructor TDBTableMapping.Destroy;
begin

  FreeAndNil(FColumnMappingsForSelect);
  FreeAndNil(FPrimaryKeyColumnMappings);
  inherited;

end;

function TDBTableMapping.FindSelectColumnMappingByObjectPropertyName(
  const ObjectPropertyName: string): TDBTableColumnMapping;
begin

  Result := FColumnMappingsForSelect.FindColumnMappingByObjectPropertyName(
              ObjectPropertyName
            ) as TDBTableColumnMapping;
            
end;

function TDBTableMapping.GetAliasColumnAssigningOperatorName: String;
begin

  Result := 'as';
  
end;

function TDBTableMapping.GetColumnMappings: TTableColumnMappings;
begin

  Result := TDBTableColumnMappings.Create;
  
end;

function TDBTableMapping.GetColumnMappingsForModification: TDBTableColumnMappings;
begin

  Result := FColumnMappings as TDBTableColumnMappings;
  
end;

procedure TDBTableMapping.GetInsertList(
  var ColumnNameList,
  ColumnValuePlaceholderList: String
);
var ColumnMapping: TTableColumnMapping;
begin

  ColumnNameList := '';
  ColumnValuePlaceholderList := '';

  for ColumnMapping in ColumnMappingsForModification do begin

    if ColumnNameList = '' then begin

      ColumnNameList := ColumnMapping.ColumnName;
      ColumnValuePlaceholderList := ':' + ColumnMapping.ObjectPropertyName;

    end

    else begin

      ColumnNameList := ColumnNameList + ',' + ColumnMapping.ColumnName;
      ColumnValuePlaceholderList := ColumnValuePlaceholderList + ', :' +
        ColumnMapping.ObjectPropertyName;
        
    end;

  end;

end;

function TDBTableMapping.GetModificationColumnCommaSeparatedList: String;
var ColumnNameList, ColumnValuePlaceholderList: String;
begin

  GetInsertList(ColumnNameList, ColumnValuePlaceholderList);

  Result := ColumnNameList;
  
end;

function TDBTableMapping.GetSelectColumnNameListWithoutTablePrefix: String;
var ColumnMapping: TDBTableColumnMapping;
    SelectListElement: String;
begin

  for ColumnMapping in ColumnMappingsForSelect do begin

    if ColumnMapping.AliasColumnName <> '' then
      SelectListElement := ColumnMapping.AliasColumnName

    else SelectListElement := ColumnMapping.ColumnName;

    if Result = '' then
      Result := SelectListElement

    else Result := Result + ',' + SelectListElement;
    
  end;

end;

function TDBTableMapping.GetSelectList(
  const CustomTableNamePrefix: String
): String;

var ColumnMapping: TDBTableColumnMapping;
    SelectListElement, UsedTableName: String;

begin

  for ColumnMapping in ColumnMappingsForSelect do begin

    if CustomTableNamePrefix <> '' then
      UsedTableName := CustomTableNamePrefix
    
    else if ColumnMapping.TableName <> '' then
      UsedTableName := ColumnMapping.TableName

    else if AliasTableName = ''then
      UsedTableName := TableName

    else UsedTableName := AliasTableName;
    
    SelectListElement :=
      UsedTableName + '.' + ColumnMapping.ColumnName;

    if ColumnMapping.AliasColumnName <> '' then
      SelectListElement :=
        SelectListElement + ' ' +
        GetAliasColumnAssigningOperatorName + ' ' +
        ColumnMapping.AliasColumnName;
      
    if Result = '' then
      Result := SelectListElement

    else Result := Result + ',' + SelectListElement;

  end;

end;

procedure TDBTableMapping.GetSelectListForSelectByIdentity(
  var SelectList,
  WhereClauseForSelectByIdentity: String
);
var PrimaryKeyColumnMapping: TTableColumnMapping;
    PrimaryKetColumnComparisonExpression: String;
begin

  SelectList := GetSelectList;
  WhereClauseForSelectByIdentity := GetWhereClauseForSelectUniqueObject;

end;

function TDBTableMapping.GetSelectListForSelectGroup(
  const CustomTableNamePrefix: String
): String;
begin

  Result := GetSelectList(CustomTableNamePrefix);
  
end;

function TDBTableMapping.GetTableNameWithAlias: String;
begin

  Result := FTableName;

  if FAliasTableName <> '' then
    Result := Result + ' as ' + FAliasTableName;
  
end;

function TDBTableMapping.GetUniqueObjectColumnCommaSeparatedList(
  const ColumnNamingMode: TColumnNamingMode
): String;
var 
    PrimaryKeyColumnMapping: TTableColumnMapping;
    UniqueColumnExpression: String;
begin

  for PrimaryKeyColumnMapping in FPrimaryKeyColumnMappings do begin

    if ColumnNamingMode = UseFullyQualifiedColumnNaming then
      UniqueColumnExpression :=
        TableName + '.' + PrimaryKeyColumnMapping.ColumnName

    else UniqueColumnExpression := PrimaryKeyColumnMapping.ColumnName;
      
    if Result = '' then
      Result := UniqueColumnExpression

    else
      Result := Result + ',' + UniqueColumnExpression;

  end;

end;

function TDBTableMapping.GetUpdateList: String;
var ColumnMapping: TTableColumnMapping;
    ColumnSetValueString: String;
begin

  for ColumnMapping in ColumnMappingsForModification do begin

    ColumnSetValueString :=
      ColumnMapping.ColumnName + '=:' +
      ColumnMapping.ObjectPropertyName;

    if Result = '' then
      Result := ColumnSetValueString

    else Result := Result + ',' + ColumnSetValueString;

  end;

end;

function TDBTableMapping.GetWhereClauseForSelectUniqueObject: String;
var PrimaryKeyColumnMapping: TDBTableColumnMapping;
    PrimaryKeyColumnComparisonExpression: String;
    UsedTableName: String;
begin

  Result := '';

  if AliasTableName <> '' then
    UsedTableName := AliasTableName

  else UsedTableName := TableName;

  for PrimaryKeyColumnMapping in FPrimaryKeyColumnMappings do begin

    PrimaryKeyColumnComparisonExpression :=
      UsedTableName + '.' +
      PrimaryKeyColumnMapping.ColumnName + '=:' +
      PrimaryKeyColumnMapping.ObjectPropertyName;

    if Result = '' then
      Result := PrimaryKeyColumnComparisonExpression

    else
      Result := Result + ' AND ' + PrimaryKeyColumnComparisonExpression;

  end;

end;

procedure TDBTableMapping.SetTableNameMappingWithAlias(
  const TableName: String;
  ObjectClass: TClass;
  const AliasTableName: String;
  ObjectListClass: TClass
);
begin

  SetTableNameMapping(TableName, ObjectClass, ObjectListClass);

  FAliasTableName := AliasTableName;
  
end;

end.
