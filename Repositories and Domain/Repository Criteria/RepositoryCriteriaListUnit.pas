unit RepositoryCriteriaListUnit;

interface

uses Classes, AbstractRepositoryCriteriaUnit;

type

  TRepositoryCriteriaList = class;

  TRepositoryCriteriaListEnumerator = class (TListEnumerator)

    private

      function GetCurrentCriterion: TAbstractRepositoryCriterion;

      constructor Create(
        RepositoryCriteriaList: TRepositoryCriteriaList
      );
      
    public

      property Current: TAbstractRepositoryCriterion read GetCurrentCriterion;

  end;

  TRepositoryCriteriaList = class (TList)

    private

      function GetCriterionByIndex(Index: Integer): TAbstractRepositoryCriterion;

      procedure FreeCriteria;

    public

      destructor Destroy; override;

      procedure Clear; override;
      
      function GetEnumerator: TRepositoryCriteriaListEnumerator;

      property Items[Index: Integer]: TAbstractRepositoryCriterion
      read GetCriterionByIndex; default;

  end;

implementation

{ TAbstractRepositoryCriteriaListEnumerator }

constructor TRepositoryCriteriaListEnumerator.Create(
  RepositoryCriteriaList: TRepositoryCriteriaList);
begin

  inherited Create(RepositoryCriteriaList);

end;

function TRepositoryCriteriaListEnumerator.GetCurrentCriterion: TAbstractRepositoryCriterion;
begin

  Result := TAbstractRepositoryCriterion(GetCurrent);

end;

{ TAbstractRepositoryCriteriaList }

procedure TRepositoryCriteriaList.Clear;
begin

  FreeCriteria;
  inherited;

end;

destructor TRepositoryCriteriaList.Destroy;
begin

  inherited;

end;

procedure TRepositoryCriteriaList.FreeCriteria;
var AbstractRepositoryCriterion: TAbstractRepositoryCriterion;
begin

  for AbstractRepositoryCriterion in Self do
    AbstractRepositoryCriterion.Free;

end;

function TRepositoryCriteriaList.GetCriterionByIndex(
  Index: Integer): TAbstractRepositoryCriterion;
begin

  Result := TAbstractRepositoryCriterion(Get(Index));
  
end;

function TRepositoryCriteriaList.GetEnumerator: TRepositoryCriteriaListEnumerator;
begin

  Result := TRepositoryCriteriaListEnumerator.Create(Self);
  
end;

end.
