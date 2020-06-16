unit BoolLogicalNegativeRepositoryCriterionUnit;

interface

uses

  AbstractNegativeRepositoryCriterionUnit;

const

  BOOL_NEGATIVE_CRITERION_DEFAULT_EXPRESSION = 'not';

type

  TBoolNegativeRepositoryCriterion = class (TAbstractNegativeRepositoryCriterion)

    protected

      function GetNegativeExpression: String; override;
      
  end;

  TBoolNegativeRepositoryCriterionClass = class of TBoolNegativeRepositoryCriterion;

implementation

{ TBoolNegativeRepositoryCriterion }

function TBoolNegativeRepositoryCriterion.GetNegativeExpression: String;
begin

  Result := BOOL_NEGATIVE_CRITERION_DEFAULT_EXPRESSION;
   
end;

end.
