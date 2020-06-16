unit SimpleDataSetFilterBuilderUnit;

interface

uses SysUtils, Classes, DB, Variants;

type

    TFilterCondition = (

        fcDefault,
        fcEqual,
        fcNotEqual,
        fcLess,
        fcGreater,
        fcLessOrEqual,
        fcGreaterOrEqual,
        fcContains

    );

    TSimpleDataSetFilterBuilder = class (TObject)

        strict protected

            type

              TDataSetFieldFilterInfo = class

                strict private

                    FFieldName: String;
                    FFilterConditionValue: Variant;
                    FFilterCondition: TFilterCondition;

                public

                    constructor Create; overload;
                    constructor Create(
                        AFieldName: String;
                        AFilterConditionValue: Variant;
                        AFilterCondition: TFilterCondition
                    ); overload;

                    property FieldName: String read FFieldName write FFieldName;
                    property FilterCondition: TFilterCondition
                    read FFilterCondition write FFilterCondition;
                    property FilterConditionValue: Variant
                    read FFilterConditionValue write FFilterConditionValue;

              end;

              TDataSetFieldFilterInfoList = class;

              TDataSetFieldFilterInfoListEnumerator = class (TListEnumerator)

                strict private

                    function GetCurrentFieldFilter: TDataSetFieldFilterInfo;

                public

                    constructor Create(
                        DataSetFieldFilterInfoList: TDataSetFieldFilterInfoList
                    );

                    property Current: TDataSetFieldFilterInfo
                    read GetCurrentFieldFilter;

              end;

              TDataSetFieldFilterInfoList = class (TList)

                strict private

                    function GetFieldFilterByIndex(
                        Index: Integer
                    ): TDataSetFieldFilterInfo;

                public

                    procedure Notify(Ptr: Pointer; Action: TListNotification); override;

                    property Items[Index: Integer]: TDataSetFieldFilterInfo
                    read GetFieldFilterByIndex;

                    function GetByFieldName(
                        const FieldName: String
                    ): TDataSetFieldFilterInfo;

                    procedure RemoveByFieldName(
                        const FieldName: String
                    );

                    function GetEnumerator: TDataSetFieldFilterInfoListEnumerator;

              end;

        strict protected

            FDataSet: TDataSet;
            FUsedFieldFilterInfos: TDataSetFieldFilterInfoList;

            function CreateFieldFilterExpression(
                FieldFilterInfo: TDataSetFieldFilterInfo
            ): String;

            procedure GetDefaultFieldFilterConditionAndValueStrings(
                DataType: TFieldType;
                FilterValue: Variant;
                var FieldFilterConditionString: String;
                var FieldFilterValueString: String
            );

            function GetFieldFilterConditionString(
                const FilterCondition: TFilterCondition
            ): String;

            function GetFieldFilterValueString(
                DataType: TFieldType;
                FilterCondition: TFilterCondition;
                FilterValue: Variant
            ): String;

            function SingleQuotedStr(const TargetString: String): String;

        public

            destructor Destroy; override;

            constructor Create; overload;
            constructor Create(ADataSet: TDataSet); overload;

            procedure Initialize(ADataSet: TDataSet = nil);

            function SetDataSet(ADataSet: TDataSet): TSimpleDataSetFilterBuilder;

            function AddOrChangeFieldFilter(

                const FieldName: String;
                const Value: Variant;
                const FilterCondition: TFilterCondition = fcDefault

            ): TSimpleDataSetFilterBuilder; virtual;

            function RemoveFieldFilter(const FieldName: String): TSimpleDataSetFilterBuilder;

            function GetFilterString: String; virtual;

    end;

implementation

{ TSimpleDataSetFilterBuilder.TDataSetFieldFilterConditionInfoList }

function TSimpleDataSetFilterBuilder.TDataSetFieldFilterInfoList.GetByFieldName(
  const FieldName: String): TDataSetFieldFilterInfo;
var FieldFilterInfo: TDataSetFieldFilterInfo;
begin

    for FieldFilterInfo in Self do
        if FieldFilterInfo.FieldName = FieldName then begin

            Result := FieldFilterInfo;
            Exit;

        end;

    Result := nil;

end;

function TSimpleDataSetFilterBuilder.TDataSetFieldFilterInfoList.GetEnumerator: TDataSetFieldFilterInfoListEnumerator;
begin

    Result := TDataSetFieldFilterInfoListEnumerator.Create(Self);

end;

function TSimpleDataSetFilterBuilder.TDataSetFieldFilterInfoList.GetFieldFilterByIndex(
  Index: Integer): TDataSetFieldFilterInfo;
begin

    Result := TDataSetFieldFilterInfo(Get(Index));

end;

procedure TSimpleDataSetFilterBuilder.TDataSetFieldFilterInfoList.Notify(
  Ptr: Pointer; Action: TListNotification);
begin

  if Action = lnDeleted then
    TDataSetFieldFilterInfo(Ptr).Free;

end;

procedure TSimpleDataSetFilterBuilder.TDataSetFieldFilterInfoList.RemoveByFieldName(
  const FieldName: String);
var FieldFilterInfo: TDataSetFieldFilterInfo;
    DeletableFieldFilterInfoIndex: Integer;
begin

    DeletableFieldFilterInfoIndex := 0;

    for FieldFilterInfo in Self do begin

        if FieldFilterInfo.FieldName = FieldName then begin

            Delete(DeletableFieldFilterInfoIndex);
            Exit;

        end;

        Inc(DeletableFieldFilterInfoIndex);

    end;

end;

{ TSimpleDataSetFilterBuilder.TDataSetFieldFilterConditionInfoListEnumerator }

constructor TSimpleDataSetFilterBuilder.TDataSetFieldFilterInfoListEnumerator.Create(
  DataSetFieldFilterInfoList: TDataSetFieldFilterInfoList);
begin

    inherited Create(DataSetFieldFilterInfoList);

end;

function TSimpleDataSetFilterBuilder.TDataSetFieldFilterInfoListEnumerator.GetCurrentFieldFilter: TDataSetFieldFilterInfo;
begin

    Result := TDataSetFieldFilterInfo(GetCurrent);

end;

{ TSimpleDataSetFilterBuilder.TDataSetFieldFilterConditionInfo }

constructor TSimpleDataSetFilterBuilder.TDataSetFieldFilterInfo.Create;
begin

    inherited;

end;

constructor TSimpleDataSetFilterBuilder.TDataSetFieldFilterInfo.Create(
  AFieldName: String; AFilterConditionValue: Variant;
  AFilterCondition: TFilterCondition);
begin

    inherited Create;

    FieldName := AFieldName;
    FilterCondition := AFilterCondition;
    FilterConditionValue := AFilterConditionValue;

end;

{ TSimpleDataSetFilterBuilder }

function TSimpleDataSetFilterBuilder.AddOrChangeFieldFilter(
  const FieldName: String; const Value: Variant;
  const FilterCondition: TFilterCondition): TSimpleDataSetFilterBuilder;
var FieldFilterInfo: TDataSetFieldFilterInfo;
begin

    FieldFilterInfo :=
        FUsedFieldFilterInfos.GetByFieldName(FieldName);

    if Assigned(FieldFilterInfo) then begin

        FieldFilterInfo.FilterCondition := FilterCondition;
        FieldFilterInfo.FilterConditionValue := Value;

    end

    else begin

        if FDataSet.FindField(FieldName) = nil then
            raise Exception.CreateFmt(
                    'Field "%s" is not exists',
                    [FieldName]
                  );

        FUsedFieldFilterInfos.Add(
            TDataSetFieldFilterInfo.Create(
                FieldName, Value, FilterCondition
            )
        );

    end;

    Result := Self;

end;

constructor TSimpleDataSetFilterBuilder.Create(ADataSet: TDataSet);
begin

    inherited Create;

    Initialize(ADataSet);

end;

function TSimpleDataSetFilterBuilder.CreateFieldFilterExpression(
  FieldFilterInfo: TDataSetFieldFilterInfo): String;
var DataType: TFieldType;
    FieldFilterValueString, FieldFilterConditionString: String;
begin

    DataType := FDataSet.FieldByName(FieldFilterInfo.FieldName).DataType;

    if FieldFilterInfo.FilterCondition = fcDefault then
        GetDefaultFieldFilterConditionAndValueStrings(
            DataType, FieldFilterInfo.FilterConditionValue,
            FieldFilterConditionString, FieldFilterValueString
        )

    else begin

        FieldFilterConditionString :=
            GetFieldFilterConditionString(FieldFilterInfo.FilterCondition);

        FieldFilterValueString :=
            GetFieldFilterValueString(
                DataType,
                FieldFilterInfo.FilterConditionValue,
                FieldFilterInfo.FilterConditionValue
            );

    end;

    Result := '(' +
              FieldFilterInfo.FieldName + ' ' +
              FieldFilterConditionString + ' ' +
              FieldFilterValueString +
              ')';

end;

constructor TSimpleDataSetFilterBuilder.Create;
begin

    inherited;

    Initialize;

end;

destructor TSimpleDataSetFilterBuilder.Destroy;
begin

  FreeAndNil(FUsedFieldFilterInfos);

  inherited;

end;

function TSimpleDataSetFilterBuilder.GetFieldFilterValueString(
  DataType: TFieldType;
  FilterCondition: TFilterCondition;
  FilterValue: Variant
): String;
begin

    case DataType of

        ftString, ftMemo, ftWideMemo,
        ftFixedChar, ftFixedWideChar,
        ftGuid, ftWideString:
        begin

            Result := FilterValue;

            if FilterCondition = fcContains then
                Result := SingleQuotedStr('*' + Result + '*');

        end;

        ftDate, ftDateTime:
        begin

            Result := SingleQuotedStr(DateTimeToStr(FilterValue));

        end;

        ftBoolean:
        begin

            if FilterValue then
                Result := 'true'

            else Result := 'false';

        end;

        else begin

            Result := VarToStr(FilterValue);

        end;

    end;

end;

procedure TSimpleDataSetFilterBuilder.GetDefaultFieldFilterConditionAndValueStrings(
  DataType: TFieldType;
  FilterValue: Variant;
  var FieldFilterConditionString, FieldFilterValueString: String);
begin

    FieldFilterConditionString := GetFieldFilterConditionString(fcEqual);

    case DataType of

        ftString, ftMemo, ftWideMemo,
        ftFixedChar, ftFixedWideChar,
        ftGuid, ftWideString:
        begin

            FieldFilterConditionString :=
                GetFieldFilterConditionString(fcContains);

            FieldFilterValueString :=
                SingleQuotedStr('*' + FilterValue + '*');

        end;

        ftDate, ftDateTime:
        begin

            FieldFilterValueString :=
                SingleQuotedStr(DateTimeToStr(FilterValue));
        end;

        ftBoolean:
        begin

            if FilterValue then
                FieldFilterValueString := 'true'

            else FieldFilterValueString := 'false';

        end;

        else begin

            FieldFilterValueString := VarToStr(FilterValue);

        end;

    end;

end;

function TSimpleDataSetFilterBuilder.GetFieldFilterConditionString(
  const FilterCondition: TFilterCondition): String;
begin

     case FilterCondition of

        fcEqual: Result := '=';
        fcNotEqual: Result := '<>';
        fcLess: Result := '<';
        fcGreater: Result := '>';
        fcLessOrEqual: Result := '<=';
        fcGreaterOrEqual: Result := '>=';
        fcContains: Result := 'like';

        else raise Exception.CreateFmt('Unknown Filter Condition Number: %d', [Integer(FilterCondition)]);

    end;

end;

function TSimpleDataSetFilterBuilder.GetFilterString: String;
var FieldFilterInfo: TDataSetFieldFilterInfo;
    FieldFilterExpression: String;
begin

    Result := '';

    for FieldFilterInfo in FUsedFieldFilterInfos do begin

        FieldFilterExpression :=
            CreateFieldFilterExpression(FieldFilterInfo);

        if Result = '' then
            Result := FieldFilterExpression

        else Result := Result + ' and ' + FieldFilterExpression;

    end;

end;

procedure TSimpleDataSetFilterBuilder.Initialize(ADataSet: TDataSet);
begin

    SetDataSet(ADataSet);

    FUsedFieldFilterInfos := TDataSetFieldFilterInfoList.Create;

end;

function TSimpleDataSetFilterBuilder.RemoveFieldFilter(
  const FieldName: String): TSimpleDataSetFilterBuilder;
begin

    FUsedFieldFilterInfos.RemoveByFieldName(FieldName);

    Result := Self;

end;

function TSimpleDataSetFilterBuilder.SetDataSet(
  ADataSet: TDataSet): TSimpleDataSetFilterBuilder;
begin

    FDataSet := ADataSet;

end;

function TSimpleDataSetFilterBuilder.SingleQuotedStr(
  const TargetString: String): String;
begin

    Result := #39 + TargetString + #39;

end;

end.
