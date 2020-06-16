unit ConstDBRepositoryCriterionUnit;

interface

uses

  ConstRepositoryCriterionUnit, Variants;

type

  TConstDBRepositoryCriterion = class (TConstRepositoryCriterion)

    protected

      FStringConstantPrefix: String;
      FStringConstantSuffix: String;

      function GetExpression: String; override;

    public

      property StringConstantPrefix: String
      read FStringConstantPrefix write FStringConstantPrefix;

      property StringConstantSuffix: String
      read FStringConstantSuffix write FStringConstantSuffix;

  end;

implementation

uses SysUtils;

{ TConstZeosDBRepositoryCriterion }

function TConstDBRepositoryCriterion.GetExpression: String;
begin

  Result := inherited GetExpression;

  case VarType(Constant) of

    varString, varDate {$IFDEF VER210}, varUString {$ENDIF}:

      Result := '''' + FStringConstantPrefix + Result + FStringConstantSuffix + '''';
    
  end;

end;

end.
