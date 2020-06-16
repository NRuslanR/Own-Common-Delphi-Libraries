unit DBDataTableFilterFormStatePropertiesIniFile;

interface

uses

  DBDataTableFilterFormStatePropertiesStorage,
  PropertiesIniFileUnit,
  TableViewFilterFormUnit,
  SysUtils,
  Classes;

type

  TDBDataTableFilterFormStatePropertiesIniFile = class (TDBDataTableFilterFormStatePropertiesStorage)

    protected

      FPropertiesIniFile: TPropertiesIniFile;

      function GetIniFilePath: String;
      procedure SetIniFilePath(const Value: String);

      procedure CreatePropertiesIniFileObject(const IniFilePath: String = '');

      procedure RaiseExceptionAboutNotFoundPropertyName(const PropertyName: String);
      
    protected

      function RestoreFilterValue: TObject; virtual;
      procedure SaveFilterValue(FilterValue: TObject); virtual;
      
      procedure InternalSaveObjectProperties(FilterFormState: TTableViewFilterFormState); override;
      procedure InternalRestorePropertiesForObject(FilterFormState: TTableViewFilterFormState); override;

    public

      destructor Destroy; override;
      
      constructor Create; overload; override;
      constructor Create(const IniFilePath: String); overload;

    published

      property IniFilePath: String read GetIniFilePath write SetIniFilePath;

  end;


implementation

uses

  Cloneable,
  SimpleDateRangePanelUnit,
  VariantTypeUnit,
  Variants,
  AuxiliaryStringFunctions;

{ TDBDataTableFilterFormStatePropertiesIniFile }

constructor TDBDataTableFilterFormStatePropertiesIniFile.Create(
  const IniFilePath: String);
begin

  inherited Create;

  CreatePropertiesIniFileObject(IniFilePath);
  
end;

procedure TDBDataTableFilterFormStatePropertiesIniFile.CreatePropertiesIniFileObject(
  const IniFilePath: String);
begin

  FPropertiesIniFile := TPropertiesIniFile.Create(IniFilePath);
  
end;

constructor TDBDataTableFilterFormStatePropertiesIniFile.Create;
begin

  inherited;

  CreatePropertiesIniFileObject;
  
end;

destructor TDBDataTableFilterFormStatePropertiesIniFile.Destroy;
begin

  FreeAndNil(FPropertiesIniFile);
  inherited;

end;

function TDBDataTableFilterFormStatePropertiesIniFile.GetIniFilePath: String;
begin

  Result := FPropertiesIniFile.IniFilePath;
  
end;

procedure TDBDataTableFilterFormStatePropertiesIniFile.SetIniFilePath(
  const Value: String);
begin

  FPropertiesIniFile.IniFilePath := Value;

end;

procedure TDBDataTableFilterFormStatePropertiesIniFile.InternalRestorePropertiesForObject(
  FilterFormState: TTableViewFilterFormState
);
var
    FilterPanelData: TFilterPanelData;
    Sections: TStrings;
    Section: String;
begin

  if not Assigned(FilterFormState) then Exit;
  
  Sections := FPropertiesIniFile.ReadSections;

  try

    try

      for Section in Sections do begin

        FilterPanelData := nil;
        
        if not FPropertiesIniFile.IsKeyExists(Section, 'Focused') then
          Continue;

        FilterPanelData := TFilterPanelData.Create;

        FPropertiesIniFile.GoToSection(Section);

        FilterPanelData.IsFilterFieldControlFocused :=
          FPropertiesIniFile.ReadValueForProperty(
            'Focused', varBoolean, False
          );

        FilterPanelData.IsFilterFieldSelected :=
          FPropertiesIniFile.ReadValueForProperty(
            'Selected', varBoolean, False
          );

        FilterPanelData.FilterFieldName := Section;

        FilterPanelData.ConditionExpressionIndex :=
          FPropertiesIniFile.ReadValueForProperty(
            'ConditionExpressionIndex', varInteger, 0
          );

        FilterPanelData.FilterValue := RestoreFilterValue as TCloneable;

        FilterFormState.AddFilterPanelData(FilterPanelData);

      end;

      FPropertiesIniFile.GoToSection('FilterOptions');

      FilterFormState.UseInsensitiveTextFilter :=
        FPropertiesIniFile.ReadValueForProperty(
          'UseInsensitiveTextFilter', varBoolean, False
        );

      FPropertiesIniFile.GoToSection('FilterFormOptions');
      
      FilterFormState.ChooseAllFilterFields :=
        FPropertiesIniFile.ReadValueForProperty(
          'ChooseAllFilterFields', varBoolean, False
        );

      FilterFormState.FilterActivated :=
        FPropertiesIniFile.ReadValueForProperty(
          'FilterActivated', varBoolean, False
        );
        
    except

      on e: Exception do begin

        FreeAndNil(FilterPanelData);
        raise;

      end;

    end;
    
  finally

    FreeAndNil(Sections);

  end;

end;

procedure TDBDataTableFilterFormStatePropertiesIniFile.RaiseExceptionAboutNotFoundPropertyName(
  const PropertyName: String);
begin

  raise Exception.Create('Ќе найдено название сохран€емого свойства ' + PropertyName);

end;

function TDBDataTableFilterFormStatePropertiesIniFile.RestoreFilterValue: TObject;
var FilterValueType: String;
    FilterValueString: String;
    DateTimeRangeString: String;
    DateTimeRangePartStrings: TStrings;
    LeftDateTimeString, RightDateTimeString: String;
    LeftDateTime, RightDateTime: TDateTime;
begin

  FilterValueType :=
    FPropertiesIniFile.ReadValueForProperty(
      'FilterValueType', varString, ''
    );

  if FilterValueType = '' then
    RaiseExceptionAboutNotFoundPropertyName('FilterValueType');

  FilterValueString :=
    FPropertiesIniFile.ReadValueForProperty('FilterValue', varString, '');

  if (FilterValueString = '') and
     (not FPropertiesIniFile.IsKeyExists(
            FPropertiesIniFile.GetCurrentSection, 'FilterValue'
          )
     )

  then RaiseExceptionAboutNotFoundPropertyName('FilterValue');

  if FilterValueType = 'DateTimeRange' then begin

    DateTimeRangePartStrings := SplitStringByDelimiter(FilterValueString, '|');

    try

      LeftDateTimeString := DateTimeRangePartStrings[0];
      RightDateTimeString := DateTimeRangePartStrings[1];

      LeftDateTime := StrToDateTime(LeftDateTimeString);
      RightDateTime := StrToDateTime(RightDateTimeString);
      
      Result := TDateTimeRange.Create(LeftDateTime, RightDateTime);

    finally

      FreeAndNil(DateTimeRangePartStrings);
      
    end;

  end

  else begin

    Result :=
      TVariant.Create(
        VarAsType(
          FilterValueString,
          StrToInt(FilterValueType)
        )
      );

  end;

end;

procedure TDBDataTableFilterFormStatePropertiesIniFile.InternalSaveObjectProperties(
  FilterFormState: TTableViewFilterFormState);
var FilterPanelData: TFilterPanelData;
begin

  if not Assigned(FilterFormState) then Exit;
  
  for FilterPanelData in FilterFormState.FilterPanelDataList do begin

    FPropertiesIniFile.GoToSection(FilterPanelData.FilterFieldName);

    FPropertiesIniFile.WriteValueForProperty(
      'Focused', FilterPanelData.IsFilterFieldControlFocused
    );

    FPropertiesIniFile.WriteValueForProperty(
      'Selected', FilterPanelData.IsFilterFieldSelected
    );

    FPropertiesIniFile.WriteValueForProperty(
      'ConditionExpressionIndex', FilterPanelData.ConditionExpressionIndex
    );

    SaveFilterValue(FilterPanelData.FilterValue);
    
  end;

  FPropertiesIniFile.GoToSection('FilterOptions');

  FPropertiesIniFile.WriteValueForProperty(
    'UseInsensitiveTextFilter', FilterFormState.UseInsensitiveTextFilter
  );

  FPropertiesIniFile.GoToSection('FilterFormOptions');

  FPropertiesIniFile.WriteValueForProperty(
    'ChooseAllFilterFields', FilterFormState.ChooseAllFilterFields
  );

  FPropertiesIniFile.WriteValueForProperty(
    'FilterActivated', FilterFormState.FilterActivated
  );
  
end;

procedure TDBDataTableFilterFormStatePropertiesIniFile.SaveFilterValue(
  FilterValue: TObject
);
var FilterValueKeyName: String;
    FilterValueTypeKeyValue: String;
    FilterValueVariant: Variant;
    DateTimeRange: TDateTimeRange;
    DateTimeRangeKeyValue: String;
begin

  if not ((FilterValue is TDateTimeRange) or (FilterValue is TVariant)) then
    Exit;

  FilterValueKeyName := 'FilterValue';

  if FilterValue is TVariant then begin

    FilterValueVariant := (FilterValue as TVariant).Value;

    FPropertiesIniFile.WriteValueForProperty(
      FilterValueKeyName, FilterValueVariant
    );

    FilterValueTypeKeyValue := IntToStr(VarType(FilterValueVariant));

  end

  else begin

    DateTimeRange := FilterValue as TDateTimeRange;

    DateTimeRangeKeyValue :=
      DateTimeToStr(DateTimeRange.LeftDateTime) + '|' +
      DateTimeToStr(DateTimeRange.RightDateTime);
      
    FPropertiesIniFile.WriteValueForProperty(
      FilterValueKeyName, DateTimeRangeKeyValue
    );

    FilterValueTypeKeyValue := 'DateTimeRange';
    
  end;

  FPropertiesIniFile.WriteValueForProperty(
    'FilterValueType', FilterValueTypeKeyValue
  );
  
end;

end.
