unit UnaryDBRepositoryCriterionUnit;

interface

uses UnaryRepositoryCriterionUnit,
     ConstRepositoryCriterionUnit,
     TableColumnMappingsUnit,
     ContainsDBRepositoryCriterionOperationUnit,
     AbstractRepositoryCriteriaUnit;

type

  TUnaryDBRepositoryCriterion = class(TUnaryRepositoryCriterion)

    protected

      function GetExpression: String; override;
      function GetConstRepositoryCriterionClass:
        TConstRepositoryCriterionClass; override;

      function GetCriterionObjectName: String; override;

    public

      constructor Create(
        const ACriterionObjectName: String;
        ACriterionObjectValue: Variant;
        ACriterionOperation: TAbstractRepositoryCriterionOperation
      );

  end;

implementation

uses ConstDBRepositoryCriterionUnit;

{ TUnaryDBRepositoryCriterion }

constructor TUnaryDBRepositoryCriterion.Create(
  const ACriterionObjectName: String; ACriterionObjectValue: Variant;
  ACriterionOperation: TAbstractRepositoryCriterionOperation);
begin

  inherited;
  
end;

function TUnaryDBRepositoryCriterion.GetConstRepositoryCriterionClass: TConstRepositoryCriterionClass;
begin

  Result := TConstDBRepositoryCriterion;

end;

function TUnaryDBRepositoryCriterion.GetCriterionObjectName: String;
begin

  with FieldMappings as TTableColumnMappings do begin

    Result := FindColumnMappingByObjectPropertyName(
                inherited GetCriterionObjectName
              ).ColumnName;

  end;

end;

function TUnaryDBRepositoryCriterion.GetExpression: String;
var ContainsCriterionOperation: TContainsDBRepositoryCriterionOperation;
begin

  if FCriterionOperation is TContainsDBRepositoryCriterionOperation then begin

    ContainsCriterionOperation :=
      FCriterionOperation as TContainsDBRepositoryCriterionOperation;

    with FCriterionObjectValue as TConstDBRepositoryCriterion do begin

      StringConstantPrefix := ContainsCriterionOperation.AnyTextPlaceholder;
      StringConstantSuffix := ContainsCriterionOperation.AnyTextPlaceholder;

    end;

  end;

  Result := inherited GetExpression;

end;

end.
