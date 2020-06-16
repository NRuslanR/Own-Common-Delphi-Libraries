unit UnaryRepositoryCriterionUnit;

interface

uses

  AbstractRepositoryCriteriaUnit,
  ConstRepositoryCriterionUnit, SysUtils, Variants;

const

  UNARY_CRITERION_ELEMENTS_SEPARATOR = ' ';

type

  TUnaryRepositoryCriterion = class (TAbstractRepositoryCriterion)

    protected

      FCriterionObjectName: String;
      FCriterionObjectValue: TConstRepositoryCriterion;
      FCriterionOperation: TAbstractRepositoryCriterionOperation;

      function GetConstRepositoryCriterionClass: TConstRepositoryCriterionClass; virtual;
      
      procedure SetCriterionObjectName(const ACriterionObjectName: String); virtual;
      function GetCriterionObjectName: String; virtual;

      procedure SetCriterionObjectValue(ACriterionObjectValue: Variant); virtual;
      function GetCriterionObjectValue: Variant; virtual;

      procedure SetCriterionOperation(ACriterionOperation: TAbstractRepositoryCriterionOperation);
      function GetCriterionOperation: TAbstractRepositoryCriterionOperation;

      function GetExpression: String; override;
      
    public

      constructor Create(
        const ACriterionObjectName: String;
        ACriterionObjectValue: Variant;
        ACriterionOperation: TAbstractRepositoryCriterionOperation
      );

      destructor Destroy; override;

      property CriterionObjectName: String
      read GetCriterionObjectName write SetCriterionObjectName;

      property CriterionObjectValue: Variant
      read GetCriterionObjectValue write SetCriterionObjectValue;

      property CriterionOperation: TAbstractRepositoryCriterionOperation
      read GetCriterionOperation write SetCriterionOperation;
      
  end;

  TUnaryRepositoryCriterionClass = class of TUnaryRepositoryCriterion;

implementation

{ TUnaryRepositoryCriterion }

constructor TUnaryRepositoryCriterion.Create(
  const ACriterionObjectName: String;
  ACriterionObjectValue: Variant;
  ACriterionOperation: TAbstractRepositoryCriterionOperation
);
begin

  inherited Create;

  CriterionObjectName := ACriterionObjectName;
  CriterionOperation := ACriterionOperation;
  FCriterionObjectValue := GetConstRepositoryCriterionClass.Create(ACriterionObjectValue);

end;

destructor TUnaryRepositoryCriterion.Destroy;
begin

  FreeAndNil(FCriterionObjectValue);
  FreeAndNil(FCriterionOperation);
  inherited;

end;

function TUnaryRepositoryCriterion.GetConstRepositoryCriterionClass: TConstRepositoryCriterionClass;
begin

  Result := TConstRepositoryCriterion;
  
end;

function TUnaryRepositoryCriterion.GetCriterionObjectName: String;
begin

  Result := FCriterionObjectName;

end;

procedure TUnaryRepositoryCriterion.SetCriterionObjectName(
  const ACriterionObjectName: String);
begin

  FCriterionObjectName := ACriterionObjectName;

end;

function TUnaryRepositoryCriterion.GetCriterionObjectValue: Variant;
begin

  Result := FCriterionObjectValue.Constant;
  
end;

procedure TUnaryRepositoryCriterion.SetCriterionObjectValue(
  ACriterionObjectValue: Variant);
begin

  FCriterionObjectValue.Constant := ACriterionObjectValue;

end;

function TUnaryRepositoryCriterion.GetCriterionOperation: TAbstractRepositoryCriterionOperation;
begin

  Result := FCriterionOperation;
  
end;

function TUnaryRepositoryCriterion.GetExpression: String;
begin

  Result :=
    CriterionObjectName + UNARY_CRITERION_ELEMENTS_SEPARATOR +
    CriterionOperation.Value + UNARY_CRITERION_ELEMENTS_SEPARATOR +
    FCriterionObjectValue.Expression;

end;

procedure TUnaryRepositoryCriterion.SetCriterionOperation(
  ACriterionOperation: TAbstractRepositoryCriterionOperation);
begin

  FCriterionOperation := ACriterionOperation;

end;

end.
