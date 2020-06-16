unit BoolLogicalNegativeDBRepositoryCriterionUnit;

interface

uses

  BoolLogicalNegativeRepositoryCriterionUnit;

type

  TBoolNegativeDBRepositoryCriterion = class (TBoolNegativeRepositoryCriterion)

    protected

      function GetNegativeExpression: String; override;

  end;

implementation

{ TBoolNegativeZeosDBRepositoryCriterion }

function TBoolNegativeDBRepositoryCriterion.GetNegativeExpression: String;
begin

  Result := inherited GetNegativeExpression;
  
end;

end.
