unit BinaryRepositoryCriterionUnit;

interface

uses

  AbstractRepositoryCriteriaUnit, UnaryRepositoryCriterionUnit, SysUtils;

const

  BINARY_CRITERION_ELEMENTS_SEPARATOR = ' ';
  
type

  TBinaryRepositoryCriterion = class (TAbstractRepositoryCriterion)

    protected

      FFirstCriterion: TAbstractRepositoryCriterion;
      FSecondCriterion: TAbstractRepositoryCriterion;
      FCriteriaBinding: TAbstractRepositoryCriteriaBinding;

      function GetExpression: String; override;

    public

      destructor Destroy; override;
      constructor Create(
        AFirstCriterion,
        ASecondCriterion: TAbstractRepositoryCriterion;
        ACriterionBinding: TAbstractRepositoryCriteriaBinding
      );

      property FirstCriterion: TAbstractRepositoryCriterion
      read FFirstCriterion write FFirstCriterion;

      property SecondCriterion: TAbstractRepositoryCriterion
      read FSecondCriterion write FSecondCriterion;

      property CriteriaBinding: TAbstractRepositoryCriteriaBinding
      read FCriteriaBinding write FCriteriaBinding;

  end;

  TBinaryRepositoryCriterionClass = class of TBinaryRepositoryCriterion;

implementation

{ TBinaryRepositoryCriterion }

constructor TBinaryRepositoryCriterion.Create(AFirstCriterion,
  ASecondCriterion: TAbstractRepositoryCriterion;
  ACriterionBinding: TAbstractRepositoryCriteriaBinding);
begin

  inherited Create;

  FirstCriterion := AFirstCriterion;
  SecondCriterion := ASecondCriterion;
  CriteriaBinding := ACriterionBinding;

end;

destructor TBinaryRepositoryCriterion.Destroy;
begin

  FreeAndNil(FFirstCriterion);
  FreeAndNil(FSecondCriterion);
  FreeAndNil(FCriteriaBinding);
  inherited;

end;

function TBinaryRepositoryCriterion.GetExpression: String;
begin

  Result := FFirstCriterion.Expression + BINARY_CRITERION_ELEMENTS_SEPARATOR +
            FCriteriaBinding.Value + BINARY_CRITERION_ELEMENTS_SEPARATOR +
            FSecondCriterion.Expression;
            
end;

end.
