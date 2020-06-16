unit FieldsEqualityImplementationUnit;

interface

uses SysUtils, Classes, EquatableUnit;

type

  {$M+}
  TFieldsEqualityImplementation = class (TObject)

    public

      constructor Create;

      function Equals(Equatable: TObject): Boolean; virtual;

  end;
  {$M-}

implementation

uses TypInfo, Windows;

{ TFieldsEqualityImplementation }

constructor TFieldsEqualityImplementation.Create;
begin

end;

function TFieldsEqualityImplementation.Equals(Equatable: TObject): Boolean;
var ClassTypeInfo: PTypeInfo;
    ClassTypeData: PTypeData;
    PropertyList: PPropList;
    PropertyIndex, PropertyCount: Integer;
    PropertyInfo: TPropInfo;
    PropertyName: String;
    ArePropertyValuesEqualed: Boolean;
    SelfObjectField, OtherObjectField: TObject;
begin

  ClassTypeInfo := Self.ClassInfo;
  ClassTypeData := GetTypeData(ClassTypeInfo);

  try

    GetMem(PropertyList, Sizeof(PPropInfo) * ClassTypeData.PropCount);

    PropertyCount := GetPropList(PTypeInfo(ClassTypeInfo), tkProperties, PropertyList);

    if PropertyCount = 0 then begin

      Result := False;
      Exit;

    end;

    for PropertyIndex := 0 to PropertyCount - 1 do begin

      PropertyInfo := PropertyList[PropertyIndex]^;
      PropertyName := PropertyInfo.Name;

      case PropertyInfo.PropType^.Kind of

        tkInteger, tkEnumeration:

          ArePropertyValuesEqualed :=
            GetOrdProp(Self, PropertyName) =
            GetOrdProp(Equatable, PropertyName);

        tkVariant:

          ArePropertyValuesEqualed :=
            GetVariantProp(Self, PropertyName) =
            GetVariantProp(Equatable, PropertyName);

        tkString, tkLString, tkWString {$IFDEF  VER210}, tkUString {$ENDIF}:

          ArePropertyValuesEqualed :=
            GetStrProp(Self, PropertyName) =
            GetStrProp(Equatable, PropertyName);

        tkFloat:

          ArePropertyValuesEqualed :=
            GetFloatProp(Self, PropertyName) =
            GetFloatProp(Equatable, PropertyName);

        tkInt64:

          ArePropertyValuesEqualed :=
            GetInt64Prop(Self, PropertyName) =
            GetInt64Prop(Equatable, PropertyName);

        tkClass:
        begin

          SelfObjectField := GetObjectProp(Self, PropertyName);
          OtherObjectField := GetObjectProp(Equatable, PropertyName);

          ArePropertyValuesEqualed := SelfObjectField = OtherObjectField;

          if ArePropertyValuesEqualed then begin

            Break;

          end;

          if Assigned(SelfObjectField) and Assigned(OtherObjectField) then
              if SelfObjectField is TFieldsEqualityImplementation then
                ArePropertyValuesEqualed :=
                  (SelfObjectField as TFieldsEqualityImplementation).
                      Equals(OtherObjectField);


        end;

      end;

      if not ArePropertyValuesEqualed then begin

        Result := False;
        Exit;

      end;


    end;

    Result := True;

  finally

    FreeMem(PropertyList);

  end;

end;

end.
