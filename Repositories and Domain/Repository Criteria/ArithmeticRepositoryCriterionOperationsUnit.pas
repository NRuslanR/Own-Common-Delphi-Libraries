unit ArithmeticRepositoryCriterionOperationsUnit;

interface

uses

  AbstractRepositoryCriteriaUnit;

const

  EQUALITY_OPERATION_VALUE = '=';
  LESS_OPERATION_VALUE = '<';
  LESS_OR_EQUAL_OPERATION_VALUE = '<=';
  GREATER_OPERATION_VALUE = '>';
  GREATER_OR_EQUAL_OPERATION_VALUE = '>=';
  
type

  TEqualityRepositoryCriterionOperation = class(TAbstractRepositoryCriterionOperation)

    protected

      function GetValue: String; override;

    public

      constructor Create;

  end;

  TEqualityRepositoryCriterionOperationClass = class of TEqualityRepositoryCriterionOperation;

  TLessRepositoryCriterionOperation = class(TAbstractRepositoryCriterionOperation)

    protected

      function GetValue: String; override;

    public

      constructor Create;

  end;

  TLessRepositoryCriterionOperationClass = class of TLessRepositoryCriterionOperation;

  TLessOrEqualRepositoryCriterionOperation = class(TAbstractRepositoryCriterionOperation)

    protected

      function GetValue: String; override;

    public

      constructor Create;

  end;

  TLessOrEqualRepositoryCriterionOperationClass = class of TLessOrEqualRepositoryCriterionOperation;

  TGreaterRepositoryCriterionOperation = class(TAbstractRepositoryCriterionOperation)

    protected

      function GetValue: String; override;

    public

      constructor Create;

  end;

  TGreaterRepositoryCriterionOperationClass = class of TGreaterRepositoryCriterionOperation;

  TGreaterOrEqualRepositoryCriterionOperation = class(TAbstractRepositoryCriterionOperation)

    protected

      function GetValue: String; override;

    public

      constructor Create;

  end;

  TGreaterOrEqualRepositoryCriterionOperationClass = class of TGreaterOrEqualRepositoryCriterionOperation;

implementation

{ TEqualRepositoryCriteriaOperation }

constructor TEqualityRepositoryCriterionOperation.Create;
begin

  inherited;

end;

function TEqualityRepositoryCriterionOperation.GetValue: String;
begin

  Result := EQUALITY_OPERATION_VALUE;
  
end;

{ TLessRepositoryCriterionOperation }

constructor TLessRepositoryCriterionOperation.Create;
begin

  inherited;

end;

function TLessRepositoryCriterionOperation.GetValue: String;
begin

  Result := LESS_OPERATION_VALUE;
  
end;

{ TLessOrEqualRepositoryCriterionOperation }

constructor TLessOrEqualRepositoryCriterionOperation.Create;
begin

  inherited;

end;

function TLessOrEqualRepositoryCriterionOperation.GetValue: String;
begin

  Result := LESS_OR_EQUAL_OPERATION_VALUE;

end;

{ TGreaterRepositoryCriterionOperation }

constructor TGreaterRepositoryCriterionOperation.Create;
begin

  inherited;

end;

function TGreaterRepositoryCriterionOperation.GetValue: String;
begin

  Result := GREATER_OPERATION_VALUE;

end;

{ TGreaterOrEqualRepositoryCriterionOperation }

constructor TGreaterOrEqualRepositoryCriterionOperation.Create;
begin

  inherited;

end;

function TGreaterOrEqualRepositoryCriterionOperation.GetValue: String;
begin

  Result := GREATER_OR_EQUAL_OPERATION_VALUE;
  
end;

end.
