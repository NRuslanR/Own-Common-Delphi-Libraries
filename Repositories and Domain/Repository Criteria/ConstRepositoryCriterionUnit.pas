unit ConstRepositoryCriterionUnit;

interface

uses

  AbstractRepositoryCriteriaUnit, Variants;

type

  TConstRepositoryCriterion = class (TAbstractRepositoryCriterion)

    strict private

      FConstant: Variant;

    public

      constructor Create; overload;
      constructor Create(AConstant: Variant); overload;

      function GetExpression: String; override;

      property Constant: Variant read FConstant write FConstant;
      
  end;

  TConstRepositoryCriterionClass = class of TConstRepositoryCriterion;
  
implementation

{ TConstRepositoryCriterion }

constructor TConstRepositoryCriterion.Create(AConstant: Variant);
begin

  inherited Create;

  Constant := AConstant;

end;

constructor TConstRepositoryCriterion.Create;
begin

  inherited;
  
end;

function TConstRepositoryCriterion.GetExpression: String;
begin

  Result := VarToStr(Constant);
  
end;

end.
