unit ContainsDBRepositoryCriterionOperationUnit;

interface

uses ContainsRepositoryCriterionOperationUnit;

type

  TContainsDBRepositoryCriterionOperation =
  class (TContainsRepositoryCriterionOperation)

    protected

      function GetValue: String; override;
      function GetAnyTextPlaceholder: String; override;

  end;

implementation

{ TContainsDBRepositoryCriterion }

function TContainsDBRepositoryCriterionOperation.GetAnyTextPlaceholder: String;
begin

  Result := '%'

end;

function TContainsDBRepositoryCriterionOperation.GetValue: String;
begin

  Result := 'LIKE';

end;

end.
