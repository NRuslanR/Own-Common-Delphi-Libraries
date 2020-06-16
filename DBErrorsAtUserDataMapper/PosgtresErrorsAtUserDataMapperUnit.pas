unit PosgtresErrorsAtUserDataMapperUnit;

interface

uses DBErrorsAtUserDataMapperUnit, SysUtils, Variants, Classes;

const
  UNIQUE_VIOLATION_ERROR_CODE = '23505';
  FOREIGN_KEY_VIOLATION_ERROR_CODE = '23503';

type
  TPostgresErrorsAtUserDataMapper = class(TDBErrorsAtUserDataMapper)

    public

      constructor Create;
      
  end;

implementation

{ TPostgresErrorsAtStringMapper }

constructor TPostgresErrorsAtUserDataMapper.Create;
begin
  inherited;
end;

{
function TPostgresErrorsAtUserDataMapper.GetUserDataByError(const ComparisonObject, Error: Variant): TObject; virtual;
begin

  Result := inherited GetUserDataByError(ComparisonObject, Error);

end;

function TPostgresErrorsAtUserDataMapper.GetUniqueErrorUserData(ComparisonObject: Variant): TObject;
var I: Integer;
begin

  Result := GetUserDataByError(UNIQUE_VIOLATION_ERROR_CODE);
  
end;

procedure TPostgresErrorsAtUserDataMapper.ResetUniqueErrorString;
var I: Integer;
begin

  if FErrorsAtStringsMap.Find(UNIQUE_VIOLATION_ERROR_CODE, I) then
    FErrorsAtStringsMap.Delete(I);

end;

procedure TPostgresErrorsAtUserDataMapper.SetUniqueErrorString(
  const ErrorString: string);
var I: Integer;
begin

  if not FErrorsAtStringsMap.Find(UNIQUE_VIOLATION_ERROR_CODE, I) then
    FErrorsAtStringsMap.AddObject(UNIQUE_VIOLATION_ERROR_CODE, TObject(ErrorString))

  else FErrorsAtStringsMap.Objects[I] := TObject(ErrorString);

end;                        }

end.
