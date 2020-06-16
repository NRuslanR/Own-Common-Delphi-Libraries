unit DomainObjectValueListUnit;

interface

uses

  SysUtils,
  Classes,
  DomainObjectValueUnit,
  IDomainObjectValueUnit,
  DomainObjectBaseListUnit,
  IDomainObjectValueListUnit,
  ClonableUnit,
  EquatableUnit;

type

  TDomainObjectValueList = class;

  TDomainObjectValueListEnumerator = class (TDomainObjectBaseListEnumerator)

    protected
      
      function GetCurrentDomainObjectValue: TDomainObjectValue;

      constructor Create(DomainObjectValueList: TDomainObjectValueList);

    public

      property Current: TDomainObjectValue read GetCurrentDomainObjectValue;

  end;

  TDomainObjectValueList = class (
                             TDomainObjectBaseList,
                             IDomainObjectValueList
                            )

    protected

      function GetDomainObjectValueByIndex(Index: Integer): TDomainObjectValue;

      procedure SetDomainObjectValueByIndex(
        Index: Integer;
        const Value: TDomainObjectValue
      );

      procedure DeleteDomainObjectValueEntryByIndex(const Index: Integer);

      function FindEntryByDomainObjectValue(DomainObjectValue: TDomainObjectValue): TDomainObjectBaseEntry; virtual;

    public

      procedure InsertDomainObjectValue(
        const Index: Integer;
        DomainObjectValue: TDomainObjectValue
      );

      function First: TDomainObjectValue;
      function Last: TDomainObjectValue;
      
      procedure AddDomainObjectValue(DomainObjectValue: TDomainObjectValue);

      function Contains(DomainObjectValue: TDomainObjectValue): Boolean;

      procedure DeleteDomainObjectValue(DomainObjectValue: TDomainObjectValue);

      function GetEnumerator: TDomainObjectValueListEnumerator; virtual;

      property Items[Index: Integer]: TDomainObjectValue
      read GetDomainObjectValueByIndex
      write SetDomainObjectValueByIndex; default;
      
  end;

  TDomainObjectValueListClass = class of TDomainObjectValueList;
  
implementation

uses

  Variants,
  AuxDebugFunctionsUnit;

{ TDomainObjectValueListEnumerator }

constructor TDomainObjectValueListEnumerator.Create(
  DomainObjectValueList: TDomainObjectValueList);
begin

  inherited Create(DomainObjectValueList);

end;

function TDomainObjectValueListEnumerator.GetCurrentDomainObjectValue: TDomainObjectValue;
begin

  Result := TDomainObjectValue(GetCurrentBaseDomainObject);

end;

{ TDomainObjectValueList }

procedure TDomainObjectValueList.AddDomainObjectValue(DomainObjectValue: TDomainObjectValue);
begin

  AddBaseDomainObject(DomainObjectValue);
  
end;

function TDomainObjectValueList.Contains(DomainObjectValue: TDomainObjectValue): Boolean;
begin

  Result := inherited Contains(DomainObjectValue);
  
end;

procedure TDomainObjectValueList.DeleteDomainObjectValue(DomainObjectValue: TDomainObjectValue);
var I: Integer;
begin

  DeleteBaseDomainObject(DomainObjectValue);

end;

procedure TDomainObjectValueList.DeleteDomainObjectValueEntryByIndex(
  const Index: Integer);
begin

  DeleteBaseDomainObjectEntryByIndex(Index);
  
end;

function TDomainObjectValueList.FindEntryByDomainObjectValue(
  DomainObjectValue: TDomainObjectValue
): TDomainObjectBaseEntry;
begin

  Result := TDomainObjectBaseEntry(inherited FindEntryByBaseDomainObject(DomainObjectValue));

end;

function TDomainObjectValueList.First: TDomainObjectValue;
begin

  Result := TDomainObjectValue(inherited First);
  
end;

function TDomainObjectValueList.GetDomainObjectValueByIndex(
  Index: Integer): TDomainObjectValue;
begin

  Result := TDomainObjectValue(inherited GetBaseDomainObjectByIndex(Index));
  
end;

function TDomainObjectValueList.GetEnumerator: TDomainObjectValueListEnumerator;
begin

  Result := TDomainObjectValueListEnumerator.Create(Self);
  
end;

procedure TDomainObjectValueList.InsertDomainObjectValue(
  const Index: Integer;
  DomainObjectValue: TDomainObjectValue
);
begin

  InsertBaseDomainObject(Index, DomainObjectValue);
  
end;

function TDomainObjectValueList.Last: TDomainObjectValue;
begin

  Result := TDomainObjectValue(inherited Last);
  
end;

procedure TDomainObjectValueList.SetDomainObjectValueByIndex(
  Index: Integer;
  const Value: TDomainObjectValue
);
begin

  SetBaseDomainObjectByIndex(Index, Value);

end;

end.
