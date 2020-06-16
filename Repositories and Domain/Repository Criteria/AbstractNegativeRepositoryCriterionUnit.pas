unit AbstractNegativeRepositoryCriterionUnit;

interface

uses

  SysUtils, AbstractRepositoryCriteriaUnit;

const

  ABSTRACT_NEGATIVE_CRITERION_ELEMENTS_SEPARATOR = ' ';
  
type

  TAbstractNegativeRepositoryCriterion = class abstract(TAbstractRepositoryCriterion)

    protected

      FNegativedCriterion: TAbstractRepositoryCriterion;

      function GetNegativeExpression: String; virtual; abstract;

      function GetExpression: String; override;

    public

      destructor Destroy; override;
      
      constructor Create(ANegativedCriterion: TAbstractRepositoryCriterion);

      property NegativedCriterion: TAbstractRepositoryCriterion
      read FNegativedCriterion write FNegativedCriterion;
      
  end;

  TAbstractNegativeRepositoryCriterionClass = class of TAbstractNegativeRepositoryCriterion;

implementation

{ TAbstractNegativeRepositoryCriterion }

constructor TAbstractNegativeRepositoryCriterion.Create(
  ANegativedCriterion: TAbstractRepositoryCriterion);
begin

  inherited Create;

  FNegativedCriterion := ANegativedCriterion;
  
end;

destructor TAbstractNegativeRepositoryCriterion.Destroy;
begin

  FreeAndNil(FNegativedCriterion);
  inherited;

end;

function TAbstractNegativeRepositoryCriterion.GetExpression: String;
begin

  Result := GetNegativeExpression +
            ABSTRACT_NEGATIVE_CRITERION_ELEMENTS_SEPARATOR +
            NegativedCriterion.Expression;
            
end;

end.
