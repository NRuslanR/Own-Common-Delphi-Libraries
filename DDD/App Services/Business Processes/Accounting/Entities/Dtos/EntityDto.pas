unit EntityDto;

interface

uses

  SysUtils,
  Classes;

type

  TEntityDto = class

    protected

      FId: Variant;

      function GetId: Variant; virtual;
      procedure SetId(const Value: Variant); virtual;

    public

      constructor Create; virtual;

      property Id: Variant read GetId write SetId;

  end;

  TEntityDtoClass = class of TEntityDto;

  TEntityDtos = class;

  TEntityDtosEnumerator = class (TListEnumerator)

    protected

      function GetCurrentEntityDto: TEntityDto;

    public

      constructor Create(EntityDtos: TEntityDtos);

      property Current: TEntityDto read GetCurrentEntityDto;
      
  end;

  TEntityDtos = class (TList)

    protected

      function GetEntityDtoByIndex(Index: Integer): TEntityDto;
      procedure SetEntityDtoByIndex(Index: Integer; const Value: TEntityDto);

    protected

      procedure Notify(Ptr: Pointer; Action: TListNotification); override;

    public

      function Add(EntityDto: TEntityDto): Integer;
      procedure Remove(EntityDto: TEntityDto);

      function FindById(const Id: Variant): TEntityDto;

      function GetEnumerator: TEntityDtosEnumerator;

      property Items[Index: Integer]: TEntityDto
      read GetEntityDtoByIndex write SetEntityDtoByIndex;
      
  end;

implementation

uses

  Variants;
  
{ TEntityDto }

constructor TEntityDto.Create;
begin

  inherited Create;

  Id := Null;

end;

function TEntityDto.GetId: Variant;
begin

  Result := FId;

end;

procedure TEntityDto.SetId(const Value: Variant);
begin

  FId := Value;
  
end;

{ TEntityDtos }

function TEntityDtos.Add(EntityDto: TEntityDto): Integer;
begin

  Result := inherited Add(EntityDto);

end;

function TEntityDtos.FindById(const Id: Variant): TEntityDto;
begin

  for Result in Self do
    if Result.Id = Id then
      Exit;

  Result := nil;
    
end;

function TEntityDtos.GetEntityDtoByIndex(Index: Integer): TEntityDto;
begin

  Result := TEntityDto(Get(Index));
  
end;

function TEntityDtos.GetEnumerator: TEntityDtosEnumerator;
begin

  Result := TEntityDtosEnumerator.Create(Self);
  
end;

procedure TEntityDtos.Notify(Ptr: Pointer; Action: TListNotification);
begin

  inherited;

  if Action = lnDeleted then
    if Assigned(Ptr) then
      TEntityDto(Ptr).Destroy;

end;

procedure TEntityDtos.Remove(EntityDto: TEntityDto);
var Index: Integer;
begin

  Index := IndexOf(EntityDto);

  if Index <> -1 then
    Delete(Index);
    
end;

procedure TEntityDtos.SetEntityDtoByIndex(Index: Integer;
  const Value: TEntityDto);
begin

  Put(Index, Value);
  
end;

{ TEntityDtosEnumerator }

constructor TEntityDtosEnumerator.Create(EntityDtos: TEntityDtos);
begin

  inherited Create(EntityDtos);
  
end;

function TEntityDtosEnumerator.GetCurrentEntityDto: TEntityDto;
begin

  Result := TEntityDto(GetCurrent);

end;

end.
