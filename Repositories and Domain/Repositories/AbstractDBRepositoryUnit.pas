unit AbstractDBRepositoryUnit;

interface

  uses Windows, Classes, DB, SysUtils, Variants,
  AbstractRepositoryUnit, DomainObjectUnit, ZDbcIntfs, ZDataset,
  ZAbstractRODataset, ZConnection, RegExpr,
  AbstractRepositoryCriteriaUnit, ConstRepositoryCriterionUnit,
  AbstractNegativeRepositoryCriterionUnit,
  ArithmeticRepositoryCriterionOperationsUnit,
  BoolLogicalNegativeRepositoryCriterionUnit,
  TableColumnMappingsUnit,
  BoolLogicalRepositoryCriterionBindingsUnit,
  UnaryRepositoryCriterionUnit, BinaryRepositoryCriterionUnit,
  UnitingRepositoryCriterionUnit, DomainObjectListUnit,
  DBTableMappingUnit, DomainObjectCompiler,
  DBTableColumnMappingsUnit,
  ContainsRepositoryCriterionOperationUnit,
  QueryExecutor,
  DataReader,
  ReflectionServicesUnit,
  VariantListUnit;

  type

    TDBRepositoryError = class (TRepositoryError)
    
    end;

    TUnknownDBRepositoryError = class (TDBRepositoryError)
    
    end;

    TDBRepositoryErrorCreator = class(TRepositoryErrorCreator)

      protected

        FRegExpr: TRegExpr;

        function CreateDefaultErrorFromException(
          const SourceException: Exception
        ): TRepositoryError; override;

      public

        destructor Destroy; override;
        constructor Create(AAbstractRepository: TAbstractRepository);

        function CreateErrorFromException(
          const SourceException: Exception;
          ExceptionalDomainObject: TDomainObject
        ): TRepositoryError; override;

    end;

    TDatabaseOperationUnknownFailException = class (Exception)

    end;

    TAbstractDBRepository = class abstract(TAbstractRepository)

      private

        FQueryExecutor: IQueryExecutor;
        
      protected

        type

          TDomainObjectDatabaseOperationType =
            procedure(DomainObject: TDomainObject) of object;

          TVALUESRowsLayoutCreatingMode = (

            UsePrimaryKeyColumns,
            DontUsePrimaryKeyColumns

          );
          
      protected

        FIsAddingTransactional: Boolean;
        FIsUpdatingTransactional: Boolean;
        FIsRemovingTransactional: Boolean;
        FIdentityColumnsModificationEnabled: Boolean;
        FReturnSurrogateIdOfDomainObjectAfterAdding: Boolean;

        FDBTableMapping: TDBTableMapping;
        FDomainObjectCompiler: TDomainObjectCompiler;
        
        procedure Initialize; override;

        function CreateDBTableMapping: TDBTableMapping; virtual;
        function CreateDomainObjectCompiler(
          ColumnMappings: TTableColumnMappings
        ): TDomainObjectCompiler; virtual;
        
        procedure MarkAllModificationOperationsAsTransactional;
        procedure MarkAllModificationOperationsAsNonTransactional;

        procedure CustomizeTableMapping(
          TableMapping: TDBTableMapping
        ); virtual;

        constructor Create; overload;
        constructor Create(RepositoryErrorCreator: TRepositoryErrorCreator); overload;
        constructor Create(QueryExecutor: IQueryExecutor); overload;

        procedure StartTransaction; virtual;
        procedure CommitTransaction; virtual;
        procedure RollbackTransaction; virtual;

        function CreateDefaultRepositoryErrorCreator: TRepositoryErrorCreator; override;

        procedure ExecuteDomainObjectDatabaseOperation(
          DomainObjectDatabaseOperation: TDomainObjectDatabaseOperationType;
          DomainObject: TDomainObject;
          const UseTransaction: Boolean
        );

        procedure CheckSelectionQueryResults(DataReader: IDataReader);
        procedure CheckModificationQueryResults(const AffectedRecordCount: Integer);

        function CheckThatSingleRecordSelected(
          DataReader: IDataReader
        ): Boolean; virtual;

        function CheckThatRecordGroupSelected(
          DataReader: IDataReader
        ): Boolean; virtual;
        
        function CheckAffectedRecordCount(const AffectedRecordCount: Integer): Boolean; virtual;

        procedure GenerateExceptionAboutDatabaseOperationUnknownFail; virtual;

        function ExecuteSelectionQueryAndCheckResults(
          const QueryPattern: String;
          const QueryParams: TQueryParams
        ): IDataReader;

        function ExecuteModificationQueryAndCheckResults(
          const QueryPattern: String;
          const QueryParams: TQueryParams
        ): Integer;
        
      protected

        procedure SetSurrogateIdForDomainObject(
          DomainObject: TDomainObject;
          DataReader: IDataReader
        ); virtual;

        procedure SetSurrogateIdForDomainObjects(
          DomainObjectList: TDomainObjectList;
          DataReader: IDataReader
        ); virtual;

      protected

        procedure PrepareAddDomainObjectQuery(
          DomainObject: TDomainObject;
          var QueryPattern: String;
          var QueryParams: TQueryParams
        ); virtual;

        procedure PrepareAddDomainObjectListQuery(
          DomainObjectList: TDomainObjectList;
          var QueryPattern: String;
          var QueryParams: TQueryParams
        ); virtual;
        
        procedure PrepareUpdateDomainObjectQuery(
          DomainObject: TDomainObject;
          var QueryPattern: String;
          var QueryParams: TQueryParams
        ); virtual;

        procedure PrepareUpdateDomainObjectListQuery(
          DomainObjectList: TDomainObjectList;
          var QueryPattern: String;
          var QueryParams: TQueryParams
        ); virtual;
        
        procedure PrepareRemoveDomainObjectQuery(
          DomainObject: TDomainObject;
          var QueryPattern: String;
          var QueryParams: TQueryParams
        ); virtual;

        procedure PrepareRemoveDomainObjectListQuery(
          DomainObjectList: TDomainObjectList;
          var QueryPattern: String;
          var QueryParams: TQueryParams
        ); virtual;
        
        procedure PrepareFindDomainObjectByIdentityQuery(
          Identity: Variant;
          var QueryPattern: String;
          var QueryParams: TQueryParams
        ); virtual;

        procedure PrepareFindDomainObjectsByIdentitiesQuery(
          const Identities: TVariantList;
          var QueryPattern: String;
          var QueryParams: TQueryParams
        ); virtual;

        procedure PrepareFindDomainObjectsByCriteria(
          Criteria: TAbstractRepositoryCriterion;
          var QueryPattern: String;
          var QueryParams: TQueryParams
        ); virtual;

        procedure PrepareLoadAllDomainObjectsQuery(
          var QueryPattern: String;
          var QueryParams: TQueryParams
        ); virtual;
        
      protected

        procedure GetSelectListFromTableMappingForSelectByIdentity(
          var SelectList: String;
          var WhereClauseForSelectIdentity: String
        ); virtual;

        function CreateVALUESRowsLayoutStringFromDomainObjectList(
          DomainObjectList: TDomainObjectList;
          const Mode: TVAlUESRowsLayoutCreatingMode
        ): String; virtual;

        function GetSelectListFromTableMappingForSelectGroup: String; virtual;
        function GetTableNameFromTableMappingForSelect: String; virtual;
        function GetCustomWhereClauseForSelect: String; virtual;
        function GetCustomWhereClauseForDelete: String; virtual;
        function GetCustomTrailingSelectQueryTextPart: String; virtual;
        function GetCustomTrailingInsertQueryTextPart: String; virtual;
        function GetCustomTrailingUpdateQueryTextPart: String; virtual;
        function GetCustomTrailingDeleteQueryTextPart: String; virtual;

      protected
      
        procedure PrepareAndExecuteAddDomainObjectQuery(DomainObject: TDomainObject); virtual;
        procedure PrepareAndExecuteAddDomainObjectListQuery(DomainObjectList: TDomainObjectList); virtual;
        procedure PrepareAndExecuteUpdateDomainObjectQuery(DomainObject: TDomainObject); virtual;
        procedure PrepareAndExecuteUpdateDomainObjectListQuery(DomainObjectList: TDomainObjectList); virtual;
        procedure PrepareAndExecuteRemoveDomainObjectQuery(DomainObject: TDomainObject); virtual;
        procedure PrepareAndExecuteRemoveDomainObjectListQuery(DomainObjectList: TDomainObjectList); virtual;
        function PrepareAndExecuteFindDomainObjectByIdentityQuery(Identity: Variant): IDataReader; virtual;
        function PrepareAndExecuteFindDomainObjectsByIdentitiesQuery(const Identities: TVariantList): IDataReader; virtual;
        function PrepareAndExecuteFindDomainObjectsByCriteria(
          Criteria: TAbstractRepositoryCriterion
        ): IDataReader; virtual;
        function PrepareAndExecuteLoadAllDomainObjectsQuery: IDataReader; virtual;

        function InternalAdd(DomainObject: TDomainObject): Boolean; override;
        function InternalAddDomainObjectList(DomainObjectList: TDomainObjectList): Boolean; override;
        function InternalUpdate(DomainObject: TDomainObject): Boolean; override;
        function InternalUpdateDomainObjectList(DomainObjectList: TDomainObjectList): Boolean; override;
        function InternalRemove(DomainObject: TDomainObject): Boolean; override;
        function InternalRemoveDomainObjectList(DomainObjectList: TDomainObjectList): Boolean; override;
        function InternalFindDomainObjectsByIdentities(const Identities: TVariantList): TDomainObjectList; override;
        function InternalFindDomainObjectByIdentity(Identity: Variant): TDomainObject; override;
        function InternalFindDomainObjectsByCriteria(Criteria: TAbstractRepositoryCriterion): TDomainObjectList; override;
        function InternalLoadAll: TDomainObjectList; override;

      protected

        procedure FillDomainObjectListFromDataReader(
          DomainObjects: TDomainObjectList;
          DataReader: IDataReader
        ); override;

        procedure OnEventRaisedAboutDomainObjectWasLoadedEarlier(
          DomainObject: TDomainObject;
          DataReader: IDataReader
        ); virtual;
        
        procedure FillDomainObjectFromDataReader(
          DomainObject: TDomainObject;
          DataReader: IDataReader
        ); override;

        function CreateDomainObject: TDomainObject; override;
        function CreateDomainObjectList: TDomainObjectList; override;
        
        function AsSQLDateTime(const DateTime: TDateTime): String;
        function AsSQLFloat(const Float: Single): String;
        
        function SafeQueryExecutor: IQueryExecutor;

        function CreateQueryParamsFromDomainObjectAndColumnMappings(
          DomainObject: TDomainObject;
          ColumnMappings: TTableColumnMappings
        ): TQueryParams; virtual;

        function CreateParamValuesFromDomainObjectIdentityAndPrimaryKeyColumnMappings(
          const DomainObjectIdentity: Variant;
          PrimaryKeyColumnMappings: TTableColumnMappings
        ): TQueryParams;

        function GetQueryParameterValueFromDomainObject(
          DomainObject: TDomainObject;
          const DomainObjectPropertyName: String
        ): Variant; virtual;
        
      public

        destructor Destroy; override;

        function GetContainsRepositoryCriterionOperationClass:
          TContainsRepositoryCriterionOperationClass; override;

        function GetNegativeRepositoryCriterionClass:
          TBoolNegativeRepositoryCriterionClass; override;

        function GetConstRepositoryCriterionClass:
          TConstRepositoryCriterionClass; override;

        function GetEqualityRepositoryCriterionOperationClass:
          TEqualityRepositoryCriterionOperationClass; override;

        function GetLessRepositoryCriterionOperationClass:
          TLessRepositoryCriterionOperationClass; override;

        function GetGreaterRepositoryCriterionOperationClass:
          TGreaterRepositoryCriterionOperationClass; override;

        function GetLessOrEqualRepositoryCriterionOperationClass:
          TLessOrEqualRepositoryCriterionOperationClass; override;

        function GetGreaterOrEqualRepositoryCriterionOperationClass:
          TGreaterOrEqualRepositoryCriterionOperationClass; override;

        function GetAndBindingRepositoryCriterionClass:
          TBoolAndBindingClass; override;

        function GetOrBindingRepositoryCriterionClass:
          TBoolOrBindingClass; override;

        function GetUnaryRepositoryCriterionClass:
          TUnaryRepositoryCriterionClass; override;

        function GetBinaryRepositoryCriterionClass:
          TBinaryRepositoryCriterionClass; override;

        function GetUnitingRepositoryCriterionClass:
          TUnitingRepositoryCriterionClass; override;

        procedure ThrowExceptionIfErrorIsNotUnknown;
        
        property IdentityColumnsModificationEnabled: Boolean
        read FIdentityColumnsModificationEnabled
        write FIdentityColumnsModificationEnabled;

        property TableMapping: TDBTableMapping read FDBTableMapping;

        property QueryExecutor: IQueryExecutor
        read FQueryExecutor write FQueryExecutor;
        
    end;

    TAbstractDecoratingDBRepository = class (TAbstractDBRepository)

      protected

        FDecoratedDBRepository: TAbstractDBRepository;

        constructor Create; overload;
        constructor Create(QueryExecutor: IQueryExecutor); overload;
        constructor Create(
          QueryExecutor: IQueryExecutor;
          DecoratedDBRepository: TAbstractDBRepository
        ); overload;

        procedure FillDomainObjectFromDataReader(
          DomainObject: TDomainObject;
          DataReader: IDataReader
        ); override;

      public

        destructor Destroy; override;

        procedure PrepareAndExecuteAddDomainObjectQuery(DomainObject: TDomainObject); override;
        procedure PrepareAndExecuteUpdateDomainObjectQuery(DomainObject: TDomainObject); override;
        procedure PrepareAndExecuteRemoveDomainObjectQuery(DomainObject: TDomainObject); override;

        property DecoratedDBRepository: TAbstractDBRepository
        read FDecoratedDBRepository write FDecoratedDBRepository;

    end;

implementation

uses
     AuxZeosFunctions,
     StrUtils,
     AuxDebugFunctionsUnit,
     AuxiliaryStringFunctions,
     BinaryDBRepositoryCriterionUnit,
     ConstDBRepositoryCriterionUnit,
     BoolLogicalNegativeDBRepositoryCriterionUnit,
     UnaryDBRepositoryCriterionUnit,
     ContainsDBRepositoryCriterionOperationUnit;


type

  TFindDomainObjectsByIdentitiesCriterion = class (TAbstractRepositoryCriterion)

    private

      FRepository: TAbstractDBRepository;
      FIdentities: TVariantList;

    protected

      function GetExpression: String; override;

    public

      constructor Create(
        const Identities: TVariantList;
        Repository: TAbstractDBRepository
      );

  end;
  
{ TDBRepositoryErrorCreator }

constructor TDBRepositoryErrorCreator.Create(
  AAbstractRepository: TAbstractRepository);
begin

  inherited;

  FRegExpr := TRegExpr.Create;

end;

function TDBRepositoryErrorCreator.CreateDefaultErrorFromException(
  const SourceException: Exception): TRepositoryError;
var QueryExecutingError: TQueryExecutingError;
begin

  if SourceException is TQueryExecutingError then begin

    QueryExecutingError := SourceException as TQueryExecutingError;

    Result :=
      TRepositoryError.Create(
        QueryExecutingError.Message,
        QueryExecutingError.Message,
        QueryExecutingError.Code
      );

  end

  else Result := inherited CreateDefaultErrorFromException(SourceException);

end;

function TDBRepositoryErrorCreator.CreateErrorFromException(
          const SourceException: Exception;
          ExceptionalDomainObject: TDomainObject
        ): TRepositoryError;
begin

  if SourceException is TDatabaseOperationUnknownFailException then begin

    Result :=
      TUnknownDBRepositoryError.Create(
        SourceException.Message, SourceException.Message, Null
      );
      
  end

  else begin

    Result :=
      inherited CreateErrorFromException(SourceException, ExceptionalDomainObject);

  end;

end;

destructor TDBRepositoryErrorCreator.Destroy;
begin

  FreeAndNil(FRegExpr);
  inherited;

end;

{ TAbstractDBRepository }

function TAbstractDBRepository.AsSQLDateTime(const DateTime: TDateTime): String;
begin

  Result :=
    QuotedStr(
      FormatDateTime(
        'yyyy-MM-dd hh:mm:ss',
        DateTime
      )
    );
    
end;

function TAbstractDBRepository.AsSQLFloat(const Float: Single): String;
var FormatSettings: TFormatSettings;
begin

  GetLocaleFormatSettings(GetThreadLocale, FormatSettings);

  FormatSettings.DecimalSeparator := '.';

  Result := Format('%g', [Float], FormatSettings);
  
end;

function TAbstractDBRepository.CheckAffectedRecordCount(
  const AffectedRecordCount: Integer): Boolean;
begin

  Result := AffectedRecordCount > 0;

end;

procedure TAbstractDBRepository.CheckModificationQueryResults(
  const AffectedRecordCount: Integer);
begin

  if not CheckAffectedRecordCount(AffectedRecordCount) then
    GenerateExceptionAboutDatabaseOperationUnknownFail;
    
end;

procedure TAbstractDBRepository.CheckSelectionQueryResults(
  DataReader: IDataReader
);
var QuerySuccessCompleted: Boolean;
begin

  if FLastOperation = roSelectSingle then
    QuerySuccessCompleted := CheckThatSingleRecordSelected(DataReader)

  else if FLastOperation in [roSelectGroup, roSelectAll] then
    QuerySuccessCompleted := CheckThatRecordGroupSelected(DataReader);

  if not QuerySuccessCompleted then
    GenerateExceptionAboutDatabaseOperationUnknownFail;
  
end;

function TAbstractDBRepository.CheckThatRecordGroupSelected(
  DataReader: IDataReader): Boolean;
begin

  Result := DataReader.RecordCount > 0;

end;

function TAbstractDBRepository.CheckThatSingleRecordSelected(
  DataReader: IDataReader): Boolean;
begin

  Result := DataReader.RecordCount = 1;

end;

constructor TAbstractDBRepository.Create;
begin

  inherited Create;

  Initialize;

end;

constructor TAbstractDBRepository.Create(
  RepositoryErrorCreator: TRepositoryErrorCreator
);
begin

  inherited Create(RepositoryErrorCreator);

  Initialize;

end;

constructor TAbstractDBRepository.Create(QueryExecutor: IQueryExecutor);
begin

  inherited Create;

  Initialize;
  
  FQueryExecutor := QueryExecutor;
  
end;

function TAbstractDBRepository.CreateDBTableMapping: TDBTableMapping;
begin

  Result := TDBTableMapping.Create;
  
end;

function TAbstractDBRepository.CreateDefaultRepositoryErrorCreator: TRepositoryErrorCreator;
begin

  Result := TDBRepositoryErrorCreator.Create(Self);
  
end;

function TAbstractDBRepository.CreateDomainObject: TDomainObject;
begin

  Result := TDomainObjectClass(FDBTableMapping.ObjectClass).Create;

end;

function TAbstractDBRepository.CreateDomainObjectCompiler(
  ColumnMappings: TTableColumnMappings
): TDomainObjectCompiler;
begin

  Result := TDomainObjectCompiler.Create(ColumnMappings);
  
end;

function TAbstractDBRepository.CreateDomainObjectList: TDomainObjectList;
begin

  if not Assigned(FDBTableMapping.ObjectListClass) then
    Result := TDomainObjectList.Create
  
  else
    Result := TDomainObjectListClass(FDBTableMapping.ObjectListClass).Create;

end;

function TAbstractDBRepository.
  CreateParamValuesFromDomainObjectIdentityAndPrimaryKeyColumnMappings(
    const DomainObjectIdentity: Variant;
    PrimaryKeyColumnMappings: TTableColumnMappings
  ): TQueryParams;
var PrimaryKeyColumnMapping: TTableColumnMapping;
    PrimaryKeyColumnIndex: Integer;
begin

  Result := TQueryParams.Create;

  try

    if not VarIsType(DomainObjectIdentity, varArray) then begin

      Result.Add(
        PrimaryKeyColumnMappings[0].ObjectPropertyName,
        DomainObjectIdentity
      );

      Exit;

    end;

    for PrimaryKeyColumnIndex := 0 to PrimaryKeyColumnMappings.Count - 1
    do begin

      PrimaryKeyColumnMapping :=
        PrimaryKeyColumnMappings[PrimaryKeyColumnIndex];

      Result.Add(
        PrimaryKeyColumnMapping.ObjectPropertyName,
        DomainObjectIdentity[PrimaryKeyColumnIndex]
      );

    end;

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;
  
end;

function TAbstractDBRepository.
  CreateQueryParamsFromDomainObjectAndColumnMappings(
    DomainObject: TDomainObject;
    ColumnMappings: TTableColumnMappings
  ): TQueryParams;
var ColumnMapping: TTableColumnMapping;
    ParameterName: String;
    ParameterValue: Variant;
begin

  Result := TQueryParams.Create;

  try

    for ColumnMapping in ColumnMappings
    do begin

      ParameterName := ColumnMapping.ObjectPropertyName;

      ParameterValue :=
        GetQueryParameterValueFromDomainObject(
          DomainObject, ParameterName
        );

      Result.Add(ParameterName, ParameterValue);

    end;

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;

    end;

  end;

end;

function TAbstractDBRepository.CreateVALUESRowsLayoutStringFromDomainObjectList(
  DomainObjectList: TDomainObjectList;
  const Mode: TVAlUESRowsLayoutCreatingMode
): String;
var DomainObject: TDomainObject;
    DomainObjectIdentityPropertyValueStringList,
    DomainObjectRestPropertyValueStringList: String;
    DomainObjectPropertyValueStringList: String;

    function GetDomainObjectPropertyValueString(
      DomainObject: TDomainObject;
      const PropertyName: String
    ): String;
    var DomainObjectPropertyValue: Variant;
    begin

      DomainObjectPropertyValue :=
        GetQueryParameterValueFromDomainObject(
          DomainObject, PropertyName
        );

      if VarIsNull(DomainObjectPropertyValue) or
         VarIsEmpty(DomainObjectPropertyValue)
      then
        Result := 'null'

      else begin

        if
           VarIsType(DomainObjectPropertyValue, varDate)
        then begin

          Result := AsSQLDateTime(DomainObjectPropertyValue);

        end

        else if 
                VarIsType(DomainObjectPropertyValue, varDouble) or
                VarIsType(DomainObjectPropertyValue, varSingle)
        then begin

          Result := AsSQLFloat(DomainObjectPropertyValue);
          
        end

        else begin

          Result := VarToStr(DomainObjectPropertyValue);

          if VarIsType(DomainObjectPropertyValue, varString) then begin

            Result := QuotedStr(Result);

          end;

        end;

      end;
      
    end;

    function GetDomainObjectPropertyValueStringList(
      DomainObject: TDomainObject;
      ColumnMappings: TDBTableColumnMappings
    ): String;
    var DomainObjectPropertyValueString: String;
        ColumnMapping: TDBTableColumnMapping;
        ConversionTypeName: String;
    begin

      Result := '';

      for ColumnMapping in ColumnMappings do begin

        ConversionTypeName := ColumnMapping.ConversionTypeName;

        DomainObjectPropertyValueString :=
          GetDomainObjectPropertyValueString(
            DomainObject, ColumnMapping.ObjectPropertyName
          );

        if ConversionTypeName <> '' then begin
        
          DomainObjectPropertyValueString :=
            Format(
              'CAST (%s AS %s)',
              [
                DomainObjectPropertyValueString,
                ConversionTypeName
              ]
            );

        end;

        if Result = ''  then
          Result := DomainObjectPropertyValueString

        else
          Result := Result + ',' + DomainObjectPropertyValueString

      end;

    end;
    
begin

  Result := '';

  for DomainObject in DomainObjectList do begin

    DomainObjectIdentityPropertyValueStringList := '';

    if Mode = UsePrimaryKeyColumns then begin

      DomainObjectIdentityPropertyValueStringList :=
        GetDomainObjectPropertyValueStringList(
          DomainObject, FDBTableMapping.PrimaryKeyColumnMappings
        );

    end;

    DomainObjectRestPropertyValueStringList :=
      GetDomainObjectPropertyValueStringList(
        DomainObject, FDBTableMapping.ColumnMappingsForModification
      );

    DomainObjectPropertyValueStringList :=
      '(' +
      DomainObjectIdentityPropertyValueStringList +

      IfThen(
        DomainObjectIdentityPropertyValueStringList <> '',
        ','
      ) +

      DomainObjectRestPropertyValueStringList
      + ')';

    if Result = '' then
      Result := DomainObjectPropertyValueStringList

    else Result := Result + ',' + DomainObjectPropertyValueStringList;

  end;
  
end;

procedure TAbstractDBRepository.CustomizeTableMapping(
  TableMapping: TDBTableMapping
);
begin


end;

destructor TAbstractDBRepository.Destroy;
begin

  FreeAndNil(FDomainObjectCompiler);
  FreeAndNil(FDBTableMapping);
  inherited;

end;

procedure TAbstractDBRepository.ExecuteDomainObjectDatabaseOperation(
  DomainObjectDatabaseOperation: TDomainObjectDatabaseOperationType;
  DomainObject: TDomainObject;
  const UseTransaction: Boolean
);
begin

  try

    if UseTransaction then
      StartTransaction;

    DomainObjectDatabaseOperation(DomainObject);

    if UseTransaction then
      CommitTransaction;

  except

    on e: Exception do begin

      if UseTransaction then
        RollbackTransaction;

      raise;

    end;

  end;

end;


function TAbstractDBRepository.ExecuteModificationQueryAndCheckResults(
  const QueryPattern: String;
  const QueryParams: TQueryParams
): Integer;
begin

  Result := SafeQueryExecutor.ExecuteModificationQuery(QueryPattern, QueryParams);

  CheckModificationQueryResults(Result);
  
end;

function TAbstractDBRepository.ExecuteSelectionQueryAndCheckResults(
  const QueryPattern: String;
  const QueryParams: TQueryParams
): IDataReader;
begin

  Result := SafeQueryExecutor.ExecuteSelectionQuery(QueryPattern, QueryParams);

  CheckSelectionQueryResults(Result);
  
end;

procedure TAbstractDBRepository.FillDomainObjectFromDataReader(
  DomainObject: TDomainObject;
  DataReader: IDataReader
);
begin

  FDomainObjectCompiler.CompileDomainObject(
    DomainObject,
    DataReader
  );

end;

procedure TAbstractDBRepository.FillDomainObjectListFromDataReader(
  DomainObjects: TDomainObjectList;
  DataReader: IDataReader
);
var PrimaryKeyField: String;
    LoadedIdForDomainObject: Variant;
    AlreadyLoadedDomainObject: TDomainObject;
begin

  { to multiple keys in future }
  PrimaryKeyField := FDBTableMapping.PrimaryKeyColumnMappings[0].ColumnName;

  DataReader.Restart;
  
  while DataReader.Next do begin

    LoadedIdForDomainObject := DataReader[PrimaryKeyField];
      
    AlreadyLoadedDomainObject :=
      DomainObjects.FindByIdentity(LoadedIdForDomainObject);

    if AlreadyLoadedDomainObject <> nil then begin

      OnEventRaisedAboutDomainObjectWasLoadedEarlier(
        AlreadyLoadedDomainObject,
        DataReader
      )

    end

    else begin

      DomainObjects.AddDomainObject(
        CreateAndFillDomainObjectFromDataReader(DataReader)
      );

    end;

  end;
  
end;

procedure TAbstractDBRepository.GenerateExceptionAboutDatabaseOperationUnknownFail;
var ErrorMessage: String;
begin

  case FLastOperation of
    
    roAdding:

      ErrorMessage := '�� ������� �������� ������ �� ������� � ��';

    roChanging:

      ErrorMessage := '�� ������� �������� ������ �� ������� � ��';

    roRemoving:

      ErrorMessage := '�� ������� ������� ������ �� ������� �� ��';

    roSelectSingle:

      ErrorMessage := '�� ������� ������� ������ �� ������� �� ��';

    roSelectAll, roSelectGroup:

      ErrorMessage := '�� ������� ������� ������ �� �������� �� ��';

  end;

  raise TDatabaseOperationUnknownFailException.Create(ErrorMessage);
  
end;

function TAbstractDBRepository.GetAndBindingRepositoryCriterionClass: TBoolAndBindingClass;
begin

  Result := inherited GetAndBindingRepositoryCriterionClass;

end;

function TAbstractDBRepository.GetBinaryRepositoryCriterionClass: TBinaryRepositoryCriterionClass;
begin

  Result := TBinaryDBRepositoryCriterion;

end;

function TAbstractDBRepository.GetConstRepositoryCriterionClass: TConstRepositoryCriterionClass;
begin

  Result := TConstDBRepositoryCriterion;

end;

function TAbstractDBRepository.GetContainsRepositoryCriterionOperationClass: TContainsRepositoryCriterionOperationClass;
begin

  Result := TContainsDBRepositoryCriterionOperation;

end;

function TAbstractDBRepository.GetCustomTrailingDeleteQueryTextPart: String;
begin

  Result := '';

end;

function TAbstractDBRepository.GetCustomTrailingInsertQueryTextPart: String;
begin

  Result := '';
  
end;

function TAbstractDBRepository.GetCustomTrailingSelectQueryTextPart: String;
begin

  Result := '';
  
end;

function TAbstractDBRepository.GetCustomTrailingUpdateQueryTextPart: String;
begin

  Result := '';
  
end;

function TAbstractDBRepository.GetCustomWhereClauseForDelete: String;
begin

  Result := FDBTableMapping.GetWhereClauseForSelectUniqueObject;
  
end;

function TAbstractDBRepository.GetCustomWhereClauseForSelect: String;
begin

  Result := '';

end;

function TAbstractDBRepository.GetEqualityRepositoryCriterionOperationClass: TEqualityRepositoryCriterionOperationClass;
begin

  Result := inherited GetEqualityRepositoryCriterionOperationClass;

end;

function TAbstractDBRepository.GetGreaterOrEqualRepositoryCriterionOperationClass: TGreaterOrEqualRepositoryCriterionOperationClass;
begin

  Result := inherited GetGreaterOrEqualRepositoryCriterionOperationClass;

end;

function TAbstractDBRepository.GetGreaterRepositoryCriterionOperationClass: TGreaterRepositoryCriterionOperationClass;
begin

  Result := inherited GetGreaterRepositoryCriterionOperationClass;

end;

function TAbstractDBRepository.GetLessOrEqualRepositoryCriterionOperationClass: TLessOrEqualRepositoryCriterionOperationClass;
begin

  Result := inherited GetLessOrEqualRepositoryCriterionOperationClass;

end;

function TAbstractDBRepository.GetLessRepositoryCriterionOperationClass: TLessRepositoryCriterionOperationClass;
begin

  Result := inherited GetLessRepositoryCriterionOperationClass;

end;

function TAbstractDBRepository.GetNegativeRepositoryCriterionClass: TBoolNegativeRepositoryCriterionClass;
begin

  Result := TBoolNegativeDBRepositoryCriterion;

end;

function TAbstractDBRepository.GetOrBindingRepositoryCriterionClass: TBoolOrBindingClass;
begin

  Result := inherited GetOrBindingRepositoryCriterionClass;

end;

function TAbstractDBRepository.GetSelectListFromTableMappingForSelectGroup: String;
begin

  Result := FDBTableMapping.GetSelectListForSelectGroup;
  
end;

procedure TAbstractDBRepository.GetSelectListFromTableMappingForSelectByIdentity(
  var SelectList, WhereClauseForSelectIdentity: String
);
begin

  FDBTableMapping.GetSelectListForSelectByIdentity(
    SelectList, WhereClauseForSelectIdentity
  );

end;

function TAbstractDBRepository.GetTableNameFromTableMappingForSelect: String;
begin

  Result := FDBTableMapping.TableNameWithAlias;

end;

function TAbstractDBRepository.GetUnaryRepositoryCriterionClass: TUnaryRepositoryCriterionClass;
begin

  Result := TUnaryDBRepositoryCriterion;

end;

function TAbstractDBRepository.GetUnitingRepositoryCriterionClass: TUnitingRepositoryCriterionClass;
begin

  Result := inherited GetUnitingRepositoryCriterionClass;

end;

function TAbstractDBRepository.GetQueryParameterValueFromDomainObject(
  DomainObject: TDomainObject;
  const DomainObjectPropertyName: String
): Variant;
begin

  Result := TReflectionServices.GetObjectPropertyValue(
              DomainObject, DomainObjectPropertyName
            );
end;

procedure TAbstractDBRepository.PrepareAddDomainObjectListQuery(
  DomainObjectList: TDomainObjectList;
  var QueryPattern: String;
  var QueryParams: TQueryParams
);
var ColumnNameList, ColumnValuePlaceholderList: String;
    VALUESRowsLayoutString: String;
begin

  FDBTableMapping.GetInsertList(ColumnNameList, ColumnValuePlaceholderList);

  VALUESRowsLayoutString :=
    CreateVALUESRowsLayoutStringFromDomainObjectList(
      DomainObjectList, DontUsePrimaryKeyColumns
    );

  QueryPattern :=
    Format(
      'INSERT INTO %s (%s) VALUES %s',
      [
        FDBTableMapping.TableName,
        ColumnNameList,
        VALUESRowsLayoutString
      ]
    ) + ' ' + GetCustomTrailingInsertQueryTextPart;

  QueryParams := nil;

end;

procedure TAbstractDBRepository.PrepareAddDomainObjectQuery(
  DomainObject: TDomainObject;
  var QueryPattern: String;
  var QueryParams: TQueryParams
);
var ColumnNameList, ColumnValuePlaceholderList: String;
begin

  FDBTableMapping.GetInsertList(ColumnNameList, ColumnValuePlaceholderList);

  QueryPattern :=
    Format(
      'INSERT INTO %s (%s) VALUES (%s)',
      [FDBTableMapping.TableName, ColumnNameList, ColumnValuePlaceholderList]
    ) + ' ' + GetCustomTrailingInsertQueryTextPart;

  QueryParams :=
    CreateQueryParamsFromDomainObjectAndColumnMappings(
      DomainObject, FDBTableMapping.ColumnMappingsForModification
    );

end;

procedure TAbstractDBRepository.PrepareAndExecuteAddDomainObjectListQuery(
  DomainObjectList: TDomainObjectList
);
var QueryPattern: String;
    QueryParams: TQueryParams;
    DataReader: IDataReader;
begin

  if FReturnSurrogateIdOfDomainObjectAfterAdding then
    FLastOperation := roSelectGroup;

  QueryParams := nil;

  try
  
    PrepareAddDomainObjectListQuery(DomainObjectList, QueryPattern, QueryParams);

    if FReturnSurrogateIdOfDomainObjectAfterAdding then begin

      DataReader :=
        ExecuteSelectionQueryAndCheckResults(QueryPattern, QueryParams);

      SetSurrogateIdForDomainObjects(DomainObjectList, DataReader);

    end

    else ExecuteModificationQueryAndCheckResults(QueryPattern, QueryParams);

  finally

    FreeAndNil(QueryParams);
    
    if FReturnSurrogateIdOfDomainObjectAfterAdding then
      FLastOperation := roAdding;

  end;

end;

procedure TAbstractDBRepository.PrepareAndExecuteAddDomainObjectQuery(
  DomainObject: TDomainObject
);
var QueryPattern: String;
    QueryParams: TQueryParams;
    DataReader: IDataReader;
begin

  if FReturnSurrogateIdOfDomainObjectAfterAdding then
    FLastOperation := roSelectSingle;

  QueryParams := nil;

  try

    PrepareAddDomainObjectQuery(DomainObject, QueryPattern, QueryParams);

    if FReturnSurrogateIdOfDomainObjectAfterAdding then begin

      DataReader :=
        ExecuteSelectionQueryAndCheckResults(QueryPattern, QueryParams);

      SetSurrogateIdForDomainObject(DomainObject, DataReader);

    end

    else ExecuteModificationQueryAndCheckResults(QueryPattern, QueryParams);
    
  finally

    FreeAndNil(QueryParams);
    
    if FReturnSurrogateIdOfDomainObjectAfterAdding then
      FLastOperation := roAdding;
    
  end;

end;

function TAbstractDBRepository.PrepareAndExecuteFindDomainObjectByIdentityQuery(
  Identity: Variant
): IDataReader;
var QueryPattern: String;
    QueryParams: TQueryParams;
begin

  QueryParams := nil;

  try

    PrepareFindDomainObjectByIdentityQuery(Identity, QueryPattern, QueryParams);

    Result := ExecuteSelectionQueryAndCheckResults(QueryPattern, QueryParams);

  finally

    FreeAndNil(QueryParams);
    
  end;

end;

function TAbstractDBRepository.PrepareAndExecuteFindDomainObjectsByCriteria(
  Criteria: TAbstractRepositoryCriterion
): IDataReader;
var QueryPattern: String;
    QueryParams: TQueryParams;
begin

  QueryParams := nil;

  try

    PrepareFindDomainObjectsByCriteria(Criteria, QueryPattern, QueryParams);

    Result := ExecuteSelectionQueryAndCheckResults(QueryPattern, QueryParams);

  finally

    FreeAndNil(QueryParams);
    
  end;

end;

function TAbstractDBRepository.
  PrepareAndExecuteFindDomainObjectsByIdentitiesQuery(
    const Identities: TVariantList
  ): IDataReader;
var QueryPattern: String;
    QueryParams: TQueryParams;
begin

  QueryParams := nil;

  try

    PrepareFindDomainObjectsByIdentitiesQuery(Identities, QueryPattern, QueryParams);

    Result := ExecuteSelectionQueryAndCheckResults(QueryPattern, QueryParams);

  finally

    FreeAndNil(QueryParams);
    
  end;

end;

function TAbstractDBRepository.
  PrepareAndExecuteLoadAllDomainObjectsQuery: IDataReader;
var QueryPattern: String;
    QueryParams: TQueryParams;
begin

  QueryParams := nil;

  try

    PrepareLoadAllDomainObjectsQuery(QueryPattern, QueryParams);

    Result := ExecuteSelectionQueryAndCheckResults(QueryPattern, QueryParams);

  finally

    FreeAndNil(QueryParams);
    
  end;

end;

procedure TAbstractDBRepository.PrepareAndExecuteRemoveDomainObjectListQuery(
  DomainObjectList: TDomainObjectList);
var QueryPattern: String;
    QueryParams: TQueryParams;
begin

  QueryParams := nil;

  try

    PrepareRemoveDomainObjectListQuery(DomainObjectList, QueryPattern, QueryParams);

    ExecuteModificationQueryAndCheckResults(QueryPattern, QueryParams);

  finally

    FreeAndNil(QueryParams);
    
  end;

end;

procedure TAbstractDBRepository.PrepareAndExecuteRemoveDomainObjectQuery(
  DomainObject: TDomainObject
);
var QueryPattern: String;
    QueryParams: TQueryParams;
begin

  QueryParams := nil;

  try

    PrepareRemoveDomainObjectQuery(DomainObject, QueryPattern, QueryParams);
    ExecuteModificationQueryAndCheckResults(QueryPattern, QueryParams);

  finally

    FreeAndNil(QueryParams);
    
  end;

end;

procedure TAbstractDBRepository.PrepareAndExecuteUpdateDomainObjectListQuery(
  DomainObjectList: TDomainObjectList);
var QueryPattern: String;
    QueryParams: TQueryParams;
begin

  QueryParams := nil;

  try

    PrepareUpdateDomainObjectListQuery(DomainObjectList, QueryPattern, QueryParams);

    ExecuteModificationQueryAndCheckResults(QueryPattern, QueryParams);

  finally

    FreeAndNil(QueryParams);
    
  end;

end;

procedure TAbstractDBRepository.PrepareAndExecuteUpdateDomainObjectQuery(
  DomainObject: TDomainObject
);
var QueryPattern: String;
    QueryParams: TQueryParams;
begin

  QueryParams := nil;

  try

    PrepareUpdateDomainObjectQuery(DomainObject, QueryPattern, QueryParams);

    ExecuteModificationQueryAndCheckResults(QueryPattern, QueryParams);

  finally

    FreeAndNil(QueryParams);
    
  end;

end;

procedure TAbstractDBRepository.
  PrepareFindDomainObjectByIdentityQuery(
    Identity: Variant;
    var QueryPattern: String;
    var QueryParams: TQueryParams
  );
var TableName, SelectList, WhereClauseForSelectIdentity,
    CustomWhereClause, QueryText: String;
    PrimaryKeyColumnMapping: TTableColumnMapping;
begin

  TableName := GetTableNameFromTableMappingForSelect;

  GetSelectListFromTableMappingForSelectByIdentity(
    SelectList, WhereClauseForSelectIdentity
  );

  CustomWhereClause := GetCustomWhereClauseForSelect;

  if CustomWhereClause <> '' then
    WhereClauseForSelectIdentity :=
      WhereClauseForSelectIdentity + ' AND ' + CustomWhereClause; 

  QueryPattern :=
    Format(
      'SELECT %s FROM %s WHERE %s',
      [SelectList, TableName, WhereClauseForSelectIdentity]
    )
    + ' ' + GetCustomTrailingSelectQueryTextPart;

  QueryParams :=
    CreateParamValuesFromDomainObjectIdentityAndPrimaryKeyColumnMappings(
      Identity, FDBTableMapping.PrimaryKeyColumnMappings
    );

end;

procedure TAbstractDBRepository.PrepareFindDomainObjectsByCriteria(
  Criteria: TAbstractRepositoryCriterion;
  var QueryPattern: String;
  var QueryParams: TQueryParams
);
var TableName, SelectList, CriteriaWhereClause, CustomWhereClause: String;
    QueryText: String;
begin

  Criteria.FieldMappings := FDBTableMapping.ColumnMappingsForSelect;

  TableName := GetTableNameFromTableMappingForSelect;
  SelectList := GetSelectListFromTableMappingForSelectGroup;
  CustomWhereClause := GetCustomWhereClauseForSelect;

  CriteriaWhereClause := Criteria.Expression;

  if CustomWhereClause <> '' then
    CriteriaWhereClause := CriteriaWhereClause + ' AND ' + CustomWhereClause;

  QueryPattern :=
    Format(
      'SELECT %s FROM %s WHERE %s',
      [
       SelectList,
       TableName,
       CriteriaWhereClause
      ]
    )
    + ' ' + GetCustomTrailingSelectQueryTextPart;

  QueryParams := nil;
  
end;

procedure TAbstractDBRepository.PrepareFindDomainObjectsByIdentitiesQuery(
  const Identities: TVariantList;
  var QueryPattern: String;
  var QueryParams: TQueryParams
);
var Criteria: TFindDomainObjectsByIdentitiesCriterion;
begin

  Criteria := TFindDomainObjectsByIdentitiesCriterion.Create(Identities, Self);

  try

    PrepareFindDomainObjectsByCriteria(
      Criteria, QueryPattern, QueryParams
    );

  finally

    FreeAndNil(Criteria);

  end;

end;

procedure TAbstractDBRepository.PrepareLoadAllDomainObjectsQuery(
  var QueryPattern: String;
  var QueryParams: TQueryParams
);
var TableName, SelectList, CustomWhereClause: String;
begin

  TableName := GetTableNameFromTableMappingForSelect;
  SelectList := GetSelectListFromTableMappingForSelectGroup;
  CustomWhereClause := GetCustomWhereClauseForSelect;

  QueryPattern :=
    Format(
      'SELECT %s FROM %s',
      [
       SelectList,
       TableName
      ]
    );

  if CustomWhereClause <> '' then
    QueryPattern := QueryPattern + ' WHERE ' + CustomWhereClause;

  QueryPattern := QueryPattern + ' ' + GetCustomTrailingSelectQueryTextPart;

  QueryParams := nil;
  
end;

procedure TAbstractDBRepository.PrepareRemoveDomainObjectListQuery(
  DomainObjectList: TDomainObjectList;
  var QueryPattern: String;
  var QueryParams: TQueryParams
);

  function CreateDomainObjectIdentitiesListStringForRemoving(
    DomainObjectList: TDomainObjectList
  ): String;
  var DomainObject: TDomainObject;
      IdentityString: String;
  begin

    for DomainObject in DomainObjectList do begin

      IdentityString := VarToStr(DomainObject.Identity);

      if Result = '' then
        Result := IdentityString

      else Result := Result + ',' + IdentityString;

    end;

  end;

begin

  QueryPattern :=
    Format(
      'DELETE FROM %s WHERE %s IN (%s)',
      [
        FDBTableMapping.TableNameWithAlias,
        FDBTableMapping.PrimaryKeyColumnMappings[0].ColumnName,
        CreateDomainObjectIdentitiesListStringForRemoving(DomainObjectList)
      ]
    );

  QueryParams := nil;
  
end;

procedure TAbstractDBRepository.PrepareRemoveDomainObjectQuery(
  DomainObject: TDomainObject;
  var QueryPattern: String;
  var QueryParams: TQueryParams
);
var PrimaryKeyColumnMapping: TTableColumnMapping;
begin

  QueryPattern :=
    Format(
      'DELETE FROM %s WHERE %s',
      [
       FDBTableMapping.TableNameWithAlias,
       GetCustomWhereClauseForDelete
      ]
    ) + ' ' + GetCustomTrailingDeleteQueryTextPart;

  QueryParams :=
    CreateQueryParamsFromDomainObjectAndColumnMappings(
      DomainObject, FDBTableMapping.PrimaryKeyColumnMappings
    );

end;

procedure TAbstractDBRepository.PrepareUpdateDomainObjectListQuery(
  DomainObjectList: TDomainObjectList;
  var QueryPattern: String;
  var QueryParams: TQueryParams
);
begin

  raise Exception.Create(
          '���������� ������ �������� ' +
          '�������� � ������ ������ ������� ' +
          '�� �������������� � ������ ' +
          '�����������'
        );
        
end;

procedure TAbstractDBRepository.PrepareUpdateDomainObjectQuery(
  DomainObject: TDomainObject;
  var QueryPattern: String;
  var QueryParams: TQueryParams
);
var PrimaryKeyColumnMapping: TTableColumnMapping;
    PrimaryKeyColumnQueryParams: TQueryParams;
begin
                     
  QueryPattern :=
    Format(
      'UPDATE %s SET %s WHERE %s',
      [
       FDBTableMapping.TableNameWithAlias,
       FDBTableMapping.GetUpdateList,
       FDBTableMapping.GetWhereClauseForSelectUniqueObject
      ]
    ) + ' ' + GetCustomTrailingUpdateQueryTextPart;

  QueryParams := nil;
  PrimaryKeyColumnQueryParams := nil;

  try

    QueryParams :=
      CreateQueryParamsFromDomainObjectAndColumnMappings(
        DomainObject, FDBTableMapping.ColumnMappingsForModification
      );

    PrimaryKeyColumnQueryParams :=
      CreateQueryParamsFromDomainObjectAndColumnMappings(
        DomainObject, FDBTableMapping.PrimaryKeyColumnMappings
      );

    QueryParams.SpliceParams(PrimaryKeyColumnQueryParams);

  except

    on e: Exception do begin

      FreeAndNil(QueryParams);
      FreeAndNil(PrimaryKeyColumnQueryParams);

      raise;
      
    end;

  end;

end;

function TAbstractDBRepository.InternalFindDomainObjectByIdentity(
  Identity: Variant): TDomainObject;
var DataReader: IDataReader;
begin

  DataReader := PrepareAndExecuteFindDomainObjectByIdentityQuery(Identity);

  Result := CreateAndFillDomainObjectFromDataReader(DataReader);

end;

function TAbstractDBRepository.InternalFindDomainObjectsByCriteria(
  Criteria: TAbstractRepositoryCriterion
): TDomainObjectList;
var DataReader: IDataReader;
begin

  DataReader := PrepareAndExecuteFindDomainObjectsByCriteria(Criteria);

  Result := CreateAndFillDomainObjectListFromDataReader(DataReader);
  
end;

function TAbstractDBRepository.InternalFindDomainObjectsByIdentities(
  const Identities: TVariantList): TDomainObjectList;
var DataReader: IDataReader;
begin

  DataReader := PrepareAndExecuteFindDomainObjectsByIdentitiesQuery(Identities);

  Result := CreateAndFillDomainObjectListFromDataReader(DataReader);
  
end;

function TAbstractDBRepository.InternalLoadAll: TDomainObjectList;
var DataReader: IDataReader;
begin

  DataReader := PrepareAndExecuteLoadAllDomainObjectsQuery;

  Result := CreateAndFillDomainObjectListFromDataReader(DataReader);

end;

procedure TAbstractDBRepository.Initialize;
begin

  FDBTableMapping := CreateDBTableMapping;

  FDomainObjectCompiler :=
    CreateDomainObjectCompiler(
      FDBTableMapping.ColumnMappingsForSelect
    );

  CustomizeTableMapping(FDBTableMapping);
  MarkAllModificationOperationsAsNonTransactional;

  FReturnSurrogateIdOfDomainObjectAfterAdding := True;
  
end;

function TAbstractDBRepository.InternalAdd(DomainObject: TDomainObject): Boolean;
begin

  Result := False;

  ExecuteDomainObjectDatabaseOperation(
    PrepareAndExecuteAddDomainObjectQuery,
    DomainObject,
    FIsAddingTransactional
  );

  Result := True;

end;

function TAbstractDBRepository.InternalAddDomainObjectList(
  DomainObjectList: TDomainObjectList): Boolean;
begin

  Result := False;

  PrepareAndExecuteAddDomainObjectListQuery(DomainObjectList);

  Result := True;
  
end;

function TAbstractDBRepository.InternalRemove(DomainObject: TDomainObject): Boolean;
begin

  Result := False;

  ExecuteDomainObjectDatabaseOperation(
    PrepareAndExecuteRemoveDomainObjectQuery,
    DomainObject,
    FIsRemovingTransactional
  );

  Result := True;

end;

function TAbstractDBRepository.InternalRemoveDomainObjectList(
  DomainObjectList: TDomainObjectList): Boolean;
begin

  Result := False;

  PrepareAndExecuteRemoveDomainObjectListQuery(DomainObjectList);

  Result := True;
  
end;

function TAbstractDBRepository.InternalUpdate(DomainObject: TDomainObject): Boolean;
begin

  Result := False;

  ExecuteDomainObjectDatabaseOperation(
    PrepareAndExecuteUpdateDomainObjectQuery,
    DomainObject,
    FIsUpdatingTransactional
  );

  Result := True;
  
end;

function TAbstractDBRepository.InternalUpdateDomainObjectList(
  DomainObjectList: TDomainObjectList): Boolean;
begin

  Result := False;

  PrepareAndExecuteUpdateDomainObjectListQuery(DomainObjectList);

  Result := True;
  
end;

procedure TAbstractDBRepository.MarkAllModificationOperationsAsNonTransactional;
begin

  FIsAddingTransactional := False;
  FIsUpdatingTransactional := False;
  FIsRemovingTransactional := False;

end;

procedure TAbstractDBRepository.MarkAllModificationOperationsAsTransactional;
begin

  FIsAddingTransactional := True;
  FIsUpdatingTransactional := True;
  FIsRemovingTransactional := True;
  
end;

procedure TAbstractDBRepository.OnEventRaisedAboutDomainObjectWasLoadedEarlier(
  DomainObject: TDomainObject; DataReader: IDataReader);
begin

end;

function TAbstractDBRepository.SafeQueryExecutor: IQueryExecutor;
begin

  if not Assigned(FQueryExecutor) then
    raise Exception.Create('QueryExecutor not assigned');

  Result := FQueryExecutor;
  
end;

procedure TAbstractDBRepository.SetSurrogateIdForDomainObject(
  DomainObject: TDomainObject;
  DataReader: IDataReader
);
var PrimaryKeyColumnIndex: Integer;
    PrimaryKeyColumnMappings: TTableColumnMappings;
    PrimaryKeyColumnMapping: TTableColumnMapping;
    ComplexIdentity: Variant;
    PrimaryKeyColumnName: String;
begin

  if FDBTableMapping.PrimaryKeyColumnMappings.Count = 1 then  begin

    PrimaryKeyColumnName :=
      FDBTableMapping.PrimaryKeyColumnMappings[0].ColumnName;

    DomainObject.Identity := DataReader[PrimaryKeyColumnName];

    Exit;

  end;

  PrimaryKeyColumnMappings := FDBTableMapping.PrimaryKeyColumnMappings;

  ComplexIdentity :=
    VarArrayCreate([0, PrimaryKeyColumnMappings.Count - 1], varVariant);

  for PrimaryKeyColumnIndex := 0 to PrimaryKeyColumnMappings.Count - 1
  do begin

    PrimaryKeyColumnMapping :=
      PrimaryKeyColumnMappings[PrimaryKeyColumnIndex];

    ComplexIdentity[PrimaryKeyColumnIndex] :=
      DataReader[PrimaryKeyColumnMapping.ColumnName];

  end;

end;

procedure TAbstractDBRepository.SetSurrogateIdForDomainObjects(
  DomainObjectList: TDomainObjectList;
  DataReader: IDataReader
);
var DomainObject: TDomainObject;
begin

  DataReader.Restart;
  
  for DomainObject in DomainObjectList do begin

    DataReader.Next;
    
    SetSurrogateIdForDomainObject(DomainObject, DataReader);

  end;

end;

procedure TAbstractDBRepository.StartTransaction;
begin

end;

procedure TAbstractDBRepository.ThrowExceptionIfErrorIsNotUnknown;
begin

  if HasError and not (LastError is TUnknownDBRepositoryError) then
    raise Exception.Create(LastError.InformativeErrorMessage);
  
end;

procedure TAbstractDBRepository.CommitTransaction;
begin

end;

procedure TAbstractDBRepository.RollbackTransaction;
begin

end;

{ TAbstractDecoratingDBRepository }

constructor TAbstractDecoratingDBRepository.Create;
begin

  inherited Create;

end;

constructor TAbstractDecoratingDBRepository.Create(QueryExecutor: IQueryExecutor);
begin

  inherited Create(QueryExecutor);

end;

constructor TAbstractDecoratingDBRepository.Create(
  QueryExecutor: IQueryExecutor;
  DecoratedDBRepository: TAbstractDBRepository
);
begin

  inherited Create(QueryExecutor);

  Self.DecoratedDBRepository := DecoratedDBRepository;

end;

destructor TAbstractDecoratingDBRepository.Destroy;
begin

  FreeAndNil(FDecoratedDBRepository);
  inherited;

end;

procedure TAbstractDecoratingDBRepository.FillDomainObjectFromDataReader(
  DomainObject: TDomainObject;
  DataReader: IDataReader
);
begin

  if Assigned(FDecoratedDBRepository) then
    FDecoratedDBRepository.FillDomainObjectFromDataReader(
      DomainObject, DataReader
    )

  else inherited;

end;

procedure TAbstractDecoratingDBRepository.PrepareAndExecuteAddDomainObjectQuery(
  DomainObject: TDomainObject);
begin

  if Assigned(FDecoratedDBRepository) then
    FDecoratedDBRepository.Add(DomainObject);

  inherited;

end;

procedure TAbstractDecoratingDBRepository.PrepareAndExecuteRemoveDomainObjectQuery(
  DomainObject: TDomainObject);
begin

  inherited;

  if Assigned(FDecoratedDBRepository) then
    FDecoratedDBRepository.Remove(DomainObject);

end;

procedure TAbstractDecoratingDBRepository.PrepareAndExecuteUpdateDomainObjectQuery(
  DomainObject: TDomainObject);
begin

  if Assigned(FDecoratedDBRepository) then
    FDecoratedDBRepository.Update(DomainObject);
  
  inherited;

end;

{ TFindDomainObjectsByIdentitiesCriterion }

constructor TFindDomainObjectsByIdentitiesCriterion.Create(
  const Identities: TVariantList; Repository: TAbstractDBRepository);
begin

  inherited Create;

  FIdentities := Identities;
  FRepository := Repository;
  
end;

function TFindDomainObjectsByIdentitiesCriterion.GetExpression: String;
var TableMapping: TDBTableMapping;
    TableName: String;
    IdentityColumnName: String;
begin

  TableMapping := FRepository.TableMapping;

  if TableMapping.AliasTableName <> '' then
    TableName := TableMapping.AliasTableName

  else TableName := TableMapping.TableName;

  IdentityColumnName := TableMapping.PrimaryKeyColumnMappings[0].ColumnName;

  Result :=
    Format(
      '%s.%s IN (%s)',
      [
        TableName,
        IdentityColumnName,
        CreateStringFromVariantList(FIdentities)
      ]
    );

end;

end.
