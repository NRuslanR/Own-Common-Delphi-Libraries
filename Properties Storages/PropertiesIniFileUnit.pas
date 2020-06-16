unit PropertiesIniFileUnit;

interface

uses
     IGetSelfUnit,
     IPropertiesStorageUnit,
     IniFiles,
     SysUtils,
     Classes;

type

  TPropertiesIniFile = class (TInterfacedObject, IPropertiesStorage)

    private

      FIniFile: TIniFile;
      FNameOfCurrentSection: String;

      function GetIniFilePath: String;
      procedure SetIniFilePath(const Value: String);

    public

      destructor Destroy; override;

      function GetSelf: TObject;
      
      constructor Create(const SettingsIniFilePath: String);

      procedure GoToSection(const SectionId: Variant);

      function GetCurrentSection: String;
      
      procedure WriteValueForProperty(
        const PropertyName: String;
        const Value: Variant
      );

      procedure WriteValueForPropertyAsVariant(
        const PropertyName: String;
        const Value: Variant
      );

      function ReadValueForProperty(
        const PropertyName: String;
        const ValueType: TVarType;
        const DefaultValue: Variant
      ): Variant;

      function ReadSections: TStrings;

      function IsKeyExists(const Section, KeyName: String): Boolean;
      
      procedure ClearAllSettings;
    
      procedure Commit;
      procedure Rollback;

    published

      property IniFilePath: String read GetIniFilePath write SetIniFilePath;
      property CurrentSection: String read GetCurrentSection;
      
  end;

implementation

uses

  AuxiliaryStringFunctions,
  Variants;

{ TPropertiesIniFile }

procedure TPropertiesIniFile.ClearAllSettings;
var KeyNameList: TStrings;
    KeyName: String;
begin

  KeyNameList := nil;
  
  try

    KeyNameList := TStringList.Create;

    FIniFile.ReadSection(FNameOfCurrentSection, KeyNameList);

    for KeyName in KeyNameList do begin

      FIniFile.DeleteKey(FNameOfCurrentSection, KeyName);

    end;

  finally

    FreeAndNil(KeyNameList);
    
  end;

end;

procedure TPropertiesIniFile.Commit;
begin

end;

constructor TPropertiesIniFile.Create(
  const SettingsIniFilePath: String);
begin

  inherited Create;

  FIniFile := TIniFile.Create(SettingsIniFilePath);

end;

destructor TPropertiesIniFile.Destroy;
begin

  FreeAndNil(FIniFile);
  inherited;

end;

function TPropertiesIniFile.GetCurrentSection: String;
begin

  Result := FNameOfCurrentSection;
  
end;

function TPropertiesIniFile.GetIniFilePath: String;
begin

  Result := FIniFile.FileName;
  
end;

function TPropertiesIniFile.GetSelf: TObject;
begin

  Result := Self;
                
end;

procedure TPropertiesIniFile.GoToSection(const SectionId: Variant);
begin

  FNameOfCurrentSection := SectionId;
  
end;

function TPropertiesIniFile.IsKeyExists(const Section,
  KeyName: String): Boolean;
begin

  Result := FIniFile.ValueExists(Section, KeyName);
  
end;

function TPropertiesIniFile.ReadSections: TStrings;
begin

  Result := TStringList.Create;

  FIniFile.ReadSections(Result);

end;

function TPropertiesIniFile.ReadValueForProperty(
  const PropertyName: String;
  const ValueType: TVarType;
  const DefaultValue: Variant
): Variant;
var ValueWithTypeExpression: String;
    TypeAndValueStrings: TStrings;
    VarType: Word;
begin

  case ValueType of

    varSmallInt, varInteger, varByte,
    varWord, varLongWord, varInt64, varShortInt:

      Result :=
        FIniFile.ReadInteger(
          FNameOfCurrentSection, PropertyName, DefaultValue
        );

    varSingle, varDouble, varCurrency:

      Result :=
        FIniFile.ReadFloat(FNameOfCurrentSection, PropertyName, DefaultValue);

    varDate:

      Result :=
        FIniFile.ReadDateTime(
          FNameOfCurrentSection, PropertyName, DefaultValue
        );

    varVariant:
    begin

      ValueWithTypeExpression :=
        FIniFile.ReadString(
          FNameOfCurrentSection, PropertyName, ''
        );

      if ValueWithTypeExpression = '' then begin

        Result := DefaultValue;
        Exit;

      end;

      TypeAndValueStrings :=
        SplitStringByDelimiter(ValueWithTypeExpression, '|');

      if TypeAndValueStrings.Count < 2 then begin

        Result := DefaultValue;
        
      end

      else begin

        VarType := StrToInt(TypeAndValueStrings[0]);

        Result := VarAsType(TypeAndValueStrings[1], VarType);

      end;

    end;      

    varBoolean:

      Result :=
        FIniFile.ReadBool(FNameOfCurrentSection, PropertyName, DefaultValue);

    else

    Result :=
      FIniFile.ReadString(FNameOfCurrentSection, PropertyName, DefaultValue);

  end;
 
end;

procedure TPropertiesIniFile.Rollback;
begin

end;

procedure TPropertiesIniFile.SetIniFilePath(const Value: String);
begin

  FreeAndNil(FIniFile);

  FIniFile := TIniFile.Create(Value);

end;

procedure TPropertiesIniFile.WriteValueForProperty(
  const PropertyName: String;
  const Value: Variant
);
var ValueType: TVarType;
begin

  ValueType := VarType(Value);

  case ValueType of

    varSmallInt, varInteger, varByte,
    varWord, varLongWord, varInt64, varShortInt:

      FIniFile.WriteInteger(FNameOfCurrentSection, PropertyName, Value);

    varSingle, varDouble, varCurrency:

      FIniFile.WriteFloat(FNameOfCurrentSection, PropertyName, Value);

    varDate:

      FIniFile.WriteDateTime(FNameOfCurrentSection, PropertyName, Value);
      
    varBoolean:

      FIniFile.WriteBool(FNameOfCurrentSection, PropertyName, Value);
      
    else FIniFile.WriteString(FNameOfCurrentSection, PropertyName, Value);

  end;

end;

procedure TPropertiesIniFile.WriteValueForPropertyAsVariant(
  const PropertyName: String; const Value: Variant);
begin

  FIniFile.WriteString(
    FNameOfCurrentSection,
    PropertyName,
    Format(
      '%d|%s',
      [
        VarType(Value),
        VarToStr(Value)
      ]
    )
  );

end;

end.
