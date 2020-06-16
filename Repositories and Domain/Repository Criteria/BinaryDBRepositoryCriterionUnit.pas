unit BinaryDBRepositoryCriterionUnit;

interface

uses

  BinaryRepositoryCriterionUnit;
  
type

  TBinaryDBRepositoryCriterion = class (TBinaryRepositoryCriterion)

    protected

      function GetExpression: String; override;
      
  end;

implementation

{ TBinaryZeosDBRepositoryCriterion }

function TBinaryDBRepositoryCriterion.GetExpression: String;
begin

  Result := inherited GetExpression;

end;

end.
