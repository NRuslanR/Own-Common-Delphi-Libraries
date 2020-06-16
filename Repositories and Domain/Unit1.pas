unit Unit1;

interface

uses AbstractRepositoryCriteriaUnit;

type

  TMyRepositoryCriterionBinding = class (TAbstractRepositoryCriteriaBinding)

    protected

      function GetValue: String; override;

  end;

implementation

{ TMyRepositoryCriterionBinding }

function TMyRepositoryCriterionBinding.GetValue: String;
begin

  Result := '&&';

end;

end.
