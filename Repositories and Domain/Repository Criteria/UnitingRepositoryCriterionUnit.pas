unit UnitingRepositoryCriterionUnit;

interface

uses AbstractRepositoryCriteriaUnit, RepositoryCriteriaListUnit;

const

  CRITERIA_SEPARATOR = ' ';

type

  TRepositoryCriteriaArray = Array Of TAbstractRepositoryCriterion;
  
  TUnitingRepositoryCriterion = class (TAbstractRepositoryCriterion)

    protected

      FCriteriaBinding: TAbstractRepositoryCriteriaBinding;
      FCriteriaList: TRepositoryCriteriaList;

      function GetExpression: String; override;

      function GetFieldMappings: TObject; override;
      procedure SetFieldMappings(FieldMappings: TObject); override;

    public

      destructor Destroy; override;

      constructor Create(
        CriteriaBinding: TAbstractRepositoryCriteriaBinding;
        CriteriaList: TRepositoryCriteriaList
      ); overload;

      constructor Create(
        CriteriaBinding: TAbstractRepositoryCriteriaBinding;
        CriteriaArray: array of TAbstractRepositoryCriterion //TRepositoryCriteriaArray
      ); overload;

      function GetCriterionByIndex(Index: Integer): TAbstractRepositoryCriterion;

      function AddCriterion(Criterion: TAbstractRepositoryCriterion): Integer;
      procedure DeleteCriterion(const Index: Integer); overload;
      procedure DeleteCriterion(Criterion: TAbstractRepositoryCriterion); overload;

      property Criteria[Index: Integer]: TAbstractRepositoryCriterion
      read GetCriterionByIndex; default;

      property CriteriaBinding: TAbstractRepositoryCriteriaBinding
      read FCriteriaBinding;

      property CriteriaList: TRepositoryCriteriaList
      read FCriteriaList;

  end;

  TUnitingRepositoryCriterionClass = class of TUnitingRepositoryCriterion;


implementation

uses SysUtils;

{ TUnitingRepositoryCriterion }

function TUnitingRepositoryCriterion.AddCriterion(
  Criterion: TAbstractRepositoryCriterion): Integer;
begin

  Result := FCriteriaList.Add(Criterion);

end;

constructor TUnitingRepositoryCriterion.Create(
  CriteriaBinding: TAbstractRepositoryCriteriaBinding;
  CriteriaList: TRepositoryCriteriaList);
begin

  inherited Create;

  FCriteriaBinding := CriteriaBinding;
  FCriteriaList := CriteriaList;

end;

constructor TUnitingRepositoryCriterion.Create(
  CriteriaBinding: TAbstractRepositoryCriteriaBinding;
  CriteriaArray: Array of TAbstractRepositoryCriterion //TRepositoryCriteriaArray
);
var Criterion: TAbstractRepositoryCriterion;
begin

  inherited Create;

  FCriteriaBinding := CriteriaBinding;
  FCriteriaList := TRepositoryCriteriaList.Create;

  for Criterion in CriteriaArray do
    FCriteriaList.Add(Criterion);

end;

procedure TUnitingRepositoryCriterion.DeleteCriterion(const Index: Integer);
begin

  FCriteriaList.Delete(Index);

end;

procedure TUnitingRepositoryCriterion.DeleteCriterion(
  Criterion: TAbstractRepositoryCriterion);
begin

  FCriteriaList.Delete(FCriteriaList.IndexOf(Criterion));
  
end;

destructor TUnitingRepositoryCriterion.Destroy;
begin

  FreeAndNil(FCriteriaBinding);
  FreeAndNil(FCriteriaList);
  inherited;
  
end;

function TUnitingRepositoryCriterion.GetCriterionByIndex(
  Index: Integer): TAbstractRepositoryCriterion;
begin

  Result := FCriteriaList[Index];
  
end;

function TUnitingRepositoryCriterion.GetExpression: String;
var Criterion: TAbstractRepositoryCriterion;
    CriteriaBindingString: String;
begin

  CriteriaBindingString := FCriteriaBinding.Value;

  for Criterion in FCriteriaList do begin

    Criterion.FieldMappings := FieldMappings;

    if Result = '' then
      Result := Criterion.Expression

    else Result := Result +
                   CRITERIA_SEPARATOR +
                   CriteriaBindingString +
                   CRITERIA_SEPARATOR +
                   Criterion.Expression;

  end;

  Result := GetExpressionOpeningElement +
            Result +
            GetExpressionClosingElement;
  
end;

function TUnitingRepositoryCriterion.GetFieldMappings: TObject;
begin

  Result := inherited GetFieldMappings;

end;

procedure TUnitingRepositoryCriterion.SetFieldMappings(FieldMappings: TObject);
begin

  inherited;

end;

end.
