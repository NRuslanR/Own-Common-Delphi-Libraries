unit AbstractDBRepositoryCriteriaUnit;

interface

uses AbstractRepositoryCriteriaUnit,
     TableColumnMappingsUnit;

type

  TAbstractDBRepositoryCriterion = class (TAbstractRepositoryCriterion)

    protected

      FDBTableColumnMappings: TTableColumnMappings;

    public

      property DBTableColumnMappings: TTableColumnMappings
      read FDBTableColumnMappings write FDBTableColumnMappings;

  end;

implementation

{ TAbstractDBRepositoryCriterion }

end.
