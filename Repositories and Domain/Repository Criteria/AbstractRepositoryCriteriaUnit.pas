unit AbstractRepositoryCriteriaUnit;

interface

uses

  SysUtils, Classes;

const

  CRITERION_EXPRESSION_DEFAULT_OPENING_ELEMENT = '(';
  CRITERION_EXPRESSION_DEFAULT_CLOSING_ELEMENT = ')';
  
type

  TAbstractRepositoryCriteriaBinding = class abstract

    protected

      constructor Create;

      function GetValue: String; virtual; abstract;

    public

      destructor Destroy; override;

      property Value: String read GetValue;

  end;

  TAbstractRepositoryCriteriaBindingClass = class of TAbstractRepositoryCriteriaBinding;

  TAbstractRepositoryCriterionOperation = class abstract

    protected

      constructor Create;

      function GetValue: String; virtual; abstract;

    public

      destructor Destroy; override;

      property Value: String read GetValue;
      
  end;

  TAbstractRepositoryCriterionOperationClass =
    class of TAbstractRepositoryCriterionOperation;

  TAbstractRepositoryCriterion = class abstract

    protected

      FFieldMappings: TObject;

      constructor Create;

      function GetExpressionOpeningElement: String; virtual;
      function GetExpressionClosingElement: String; virtual;
      
      function GetExpression: String; virtual; abstract;
      function GetEnclosedExpression: String;

      function GetFieldMappings: TObject; virtual;
      procedure SetFieldMappings(FieldMappings: TObject); virtual;

    public

      destructor Destroy; override;

      property Expression: String read GetEnclosedExpression;
      property FieldMappings: TObject
      read GetFieldMappings write SetFieldMappings;

  end;

  TAbstractRepositoryCriterionClass = class of TAbstractRepositoryCriterion;

implementation

{ TAbstractRepositoryCriterion }

constructor TAbstractRepositoryCriterion.Create;
begin

  inherited;

end;

function TAbstractRepositoryCriterion.GetExpressionOpeningElement: String;
begin

  Result := CRITERION_EXPRESSION_DEFAULT_OPENING_ELEMENT;

end;

function TAbstractRepositoryCriterion.GetFieldMappings: TObject;
begin

  Result := FFieldMappings;

end;

procedure TAbstractRepositoryCriterion.SetFieldMappings(FieldMappings: TObject);
begin

  FFieldMappings := FieldMappings;

end;

destructor TAbstractRepositoryCriterion.Destroy;
begin

  inherited;

end;

function TAbstractRepositoryCriterion.GetEnclosedExpression: String;
begin

  Result := GetExpressionOpeningElement +
            GetExpression +
            GetExpressionClosingElement;

end;

function TAbstractRepositoryCriterion.GetExpressionClosingElement: String;
begin

  Result := CRITERION_EXPRESSION_DEFAULT_CLOSING_ELEMENT;
  
end;

{ TAbstractRepositoryCriteriaBinding }

constructor TAbstractRepositoryCriteriaBinding.Create;
begin

  inherited;

end;

destructor TAbstractRepositoryCriteriaBinding.Destroy;
begin

  inherited;

end;

{ TAbstractRepositoryCriterionOperation }

constructor TAbstractRepositoryCriterionOperation.Create;
begin

  inherited;

end;

destructor TAbstractRepositoryCriterionOperation.Destroy;
begin

  inherited;

end;

end.
