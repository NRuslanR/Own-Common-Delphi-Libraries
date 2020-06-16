unit InterfaceObjectList;

interface

uses

  SysUtils,
  Classes;

type

  TInterfaceObjectList = class;

  TInterfaceObjectListEnumerator = class (TListEnumerator)

    protected

      function GetCurrentInterfaceObject: IInterface;

    public

      constructor Create(InterfaceObjectList: TInterfaceObjectList);

      property Current: IInterface read GetCurrentInterfaceObject;

  end;
  
  TInterfaceObjectList = class (TList)

    protected

      type

        TEntry = class

          InterfaceObject: IInterface;

          constructor Create(InterfaceObject: IInterface);
          
        end;

    protected

      function GetInterfaceObjectByIndex(Index: Integer): IInterface;
      procedure SetInterfaceObjectByIndex(
        Index: Integer;
        Value: IInterface
      );

      procedure Notify(Ptr: Pointer; Action: TListNotification); override;

      function FindEntryIndexByInterfaceObject(InterfaceObject: IInterface): Integer;
      function FindEntryByInterfaceObject(InterfaceObject: IInterface): TEntry;

    public

      function Add(InterfaceObject: IInterface): Integer;
      procedure Remove(InterfaceObject: IInterface);

      function GetEnumerator: TInterfaceObjectListEnumerator;

      property Items[Index: Integer]: IInterface
      read GetInterfaceObjectByIndex
      write SetInterfaceObjectByIndex; default;
      
  end;
  
implementation

{ TInterfaceObjectListEnumerator }

constructor TInterfaceObjectListEnumerator.Create(
  InterfaceObjectList: TInterfaceObjectList);
begin

  inherited Create(InterfaceObjectList);
  
end;

function TInterfaceObjectListEnumerator.GetCurrentInterfaceObject: IInterface;
begin

  Result := TInterfaceObjectList.TEntry(GetCurrent).InterfaceObject;
  
end;

{ TInterfaceObjectList }

function TInterfaceObjectList.Add(InterfaceObject: IInterface): Integer;
begin

  Result := inherited Add(TEntry.Create(InterfaceObject));
  
end;

function TInterfaceObjectList.FindEntryByInterfaceObject(
  InterfaceObject: IInterface): TEntry;
var EntryIndex: Integer;
begin

  EntryIndex := FindEntryIndexByInterfaceObject(InterfaceObject);

  Result := TEntry(Get(EntryIndex));
  
end;

function TInterfaceObjectList.FindEntryIndexByInterfaceObject(
  InterfaceObject: IInterface): Integer;
begin

  for Result := 0 to Count - 1 do
    if Self[Result] = InterfaceObject then
      Exit;

  Result := -1;

end;

function TInterfaceObjectList.GetEnumerator: TInterfaceObjectListEnumerator;
begin

  Result := TInterfaceObjectListEnumerator.Create(Self);
  
end;

function TInterfaceObjectList.GetInterfaceObjectByIndex(
  Index: Integer): IInterface;
begin

  Result := TEntry(Get(Index)).InterfaceObject;
  
end;

procedure TInterfaceObjectList.Notify(Ptr: Pointer; Action: TListNotification);
begin

  if Action = lnDeleted then
    if Assigned(Ptr) then
      TEntry(Ptr).Destroy;
      
end;

procedure TInterfaceObjectList.Remove(InterfaceObject: IInterface);
var EntryIndex: Integer;
begin

  EntryIndex := FindEntryIndexByInterfaceObject(InterfaceObject);

  Delete(EntryIndex);
  
end;

procedure TInterfaceObjectList.SetInterfaceObjectByIndex(Index: Integer;
  Value: IInterface);
var Entry: TEntry;
begin

  Entry := TEntry(Get(Index));
  
  Entry.InterfaceObject := Value;
  
end;

{ TInterfaceObjectList.TEntry }

constructor TInterfaceObjectList.TEntry.Create(InterfaceObject: IInterface);
begin

  inherited Create;

  Self.InterfaceObject := InterfaceObject;
  
end;

end.
