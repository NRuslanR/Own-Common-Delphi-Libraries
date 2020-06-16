unit AbstractContainsRepositoryCriterionOperationUnit;

interface

uses AbstractRepositoryCriteriaUnit;

type

  TAbstractContainsRepositoryCriterionOperation =
  class (TAbstractRepositoryCriterionOperation)

    protected

      function GetAnyTextPlaceholder: String; virtual; abstract;

    public

      property AnyTextPlaceholder: String read GetAnyTextPlaceholder;

  end;

  TAbstractContainsRepositoryCriterionOperationClass =
    class of TAbstractContainsRepositoryCriterionOperation;

implementation

end.
