unit AuxCollectionFunctionsUnit;

interface
  uses Classes, SysUtils;

procedure FreeListItems(source: TList);
procedure FreeListWithItems(var source: TList);

implementation


procedure FreeListItems(source: TList);
var item: Pointer;
begin

  if not Assigned(source) then Exit;

  for item in source do begin
    try
      TObject(item).Free;
    except
      on e: EInvalidPointer do
        FreeMem(item);
    end;
  end;

  source.Clear;

end;

procedure FreeListWithItems(var source: TList);
begin

  FreeListItems(source);
  FreeAndNil(source);

end;
end.
