unit ContainsRepositoryCriterionOperationUnit;

interface

uses AbstractContainsRepositoryCriterionOperationUnit;

type

  TContainsRepositoryCriterionOperation =
  class (TAbstractContainsRepositoryCriterionOperation)

    protected

      function GetValue: String; override;

      function GetAnyTextPlaceholder: String; override;

    public

      constructor Create; overload;

  end;

  TContainsRepositoryCriterionOperationClass =
    class of TContainsRepositoryCriterionOperation;

implementation

{ TContainsRepositoryCriterionOperation }

constructor TContainsRepositoryCriterionOperation.Create;
begin

  inherited;

end;

function TContainsRepositoryCriterionOperation.GetAnyTextPlaceholder: String;
begin

  Result := '*';

end;

function TContainsRepositoryCriterionOperation.GetValue: String;
begin

  Result := '=';

end;

end.
