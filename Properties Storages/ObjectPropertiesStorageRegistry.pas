unit ObjectPropertiesStorageRegistry;

interface

uses

  IObjectPropertiesStorageRegistryUnit,
  IObjectPropertiesStorageUnit,
  SysUtils,
  Classes;

type
    
  TObjectPropertiesStorageRegistry = class (TInterfacedObject, IObjectPropertiesStorageRegistry)

    protected

      type

        TObjectPropertiesStorageEntry = class

            ObjectClass: TClass;
            ObjectPropertiesStorage: IObjectPropertiesStorage;
            RegisterOption: TRegisterObjectPropertiesStorageOption;

          public

            constructor Create(
              ObjectClass: TClass;
              ObjectPropertiesStorage: IObjectPropertiesStorage;
              RegisterOption: TRegisterObjectPropertiesStorageOption
            );

        end;

    protected

      class var FInstance: IObjectPropertiesStorageRegistry;

      FObjectPropertiesStorageEntries: TList;

      function FindObjectPropertiesStorageEntryByObjectClass(
        ObjectClass: TClass
      ): TObjectPropertiesStorageEntry;

      procedure AddObjectPropertiesStorageEntry(
        ObjectClass: TClass;
        ObjectPropertiesStorage: IObjectPropertiesStorage;
        const RegisterOption: TRegisterObjectPropertiesStorageOption
      );

    public

      constructor Create; virtual;
      destructor Destroy; override;

      function GetSelf: TObject;

      procedure RegisterObjectPropertiesStorageForObjectClass(
        ObjectClass: TClass;
        ObjectPropertiesStorage: IObjectPropertiesStorage;
        const RegisterOption: TRegisterObjectPropertiesStorageOption = RegisterWithInheritanceCheckingOptionIfObjectClassNotFound
      );
      
      function GetPropertiesStorageForObjectClass(
        ObjectClass: TClass
      ): IObjectPropertiesStorage;

    published

      class property Current: IObjectPropertiesStorageRegistry
      read FInstance write FInstance;
      
  end;

implementation

uses AuxCollectionFunctionsUnit;

{ TObjectPropertiesStorageRegistry }

procedure TObjectPropertiesStorageRegistry.AddObjectPropertiesStorageEntry(
  ObjectClass: TClass;
  ObjectPropertiesStorage: IObjectPropertiesStorage;
  const RegisterOption: TRegisterObjectPropertiesStorageOption
);
var ObjectPropertiesStorageEntry: TObjectPropertiesStorageEntry;
begin

  ObjectPropertiesStorageEntry :=
    TObjectPropertiesStorageEntry.Create(
      ObjectClass,
      ObjectPropertiesStorage,
      RegisterOption
    );

  FObjectPropertiesStorageEntries.Add(ObjectPropertiesStorageEntry)

end;

constructor TObjectPropertiesStorageRegistry.Create;
begin

  inherited;

  FObjectPropertiesStorageEntries := TList.Create;
  
end;

destructor TObjectPropertiesStorageRegistry.Destroy;
begin

  FreeListWithItems(FObjectPropertiesStorageEntries);
  inherited;

end;

function TObjectPropertiesStorageRegistry.FindObjectPropertiesStorageEntryByObjectClass(
  ObjectClass: TClass
): TObjectPropertiesStorageEntry;
var I: Integer;
    ObjectPropertiesStorageEntry: TObjectPropertiesStorageEntry;
begin

  Result := nil;

  for I := 0 to FObjectPropertiesStorageEntries.Count - 1 do begin

    ObjectPropertiesStorageEntry :=
      TObjectPropertiesStorageEntry(FObjectPropertiesStorageEntries[I]);

    if ObjectClass = ObjectPropertiesStorageEntry.ObjectClass  then begin

      Result := ObjectPropertiesStorageEntry;
      Exit;

    end

  end;

  for I := 0 to FObjectPropertiesStorageEntries.Count - 1 do begin

    ObjectPropertiesStorageEntry :=
      TObjectPropertiesStorageEntry(FObjectPropertiesStorageEntries[I]);

    if ObjectPropertiesStorageEntry.RegisterOption =
       RegisterWithoutInheritanceCheckingOption

    then Continue;

    if ObjectClass.ClassParent = ObjectPropertiesStorageEntry.ObjectClass then
    begin

      Result := ObjectPropertiesStorageEntry;
      Exit;
      
    end;
    
  end;

  for I := 0 to FObjectPropertiesStorageEntries.Count - 1 do begin

    ObjectPropertiesStorageEntry :=
      TObjectPropertiesStorageEntry(FObjectPropertiesStorageEntries[I]);

    if ObjectPropertiesStorageEntry.RegisterOption =
       RegisterWithoutInheritanceCheckingOption

    then Continue;

    if ObjectClass.InheritsFrom(ObjectPropertiesStorageEntry.ObjectClass)
    then
    begin

      Result := ObjectPropertiesStorageEntry;
      Exit;
      
    end;
    
  end;

end;

function TObjectPropertiesStorageRegistry.GetPropertiesStorageForObjectClass(
  ObjectClass: TClass): IObjectPropertiesStorage;
var ObjectPropertiesStorageEntry: TObjectPropertiesStorageEntry;
begin

  ObjectPropertiesStorageEntry :=
    FindObjectPropertiesStorageEntryByObjectClass(ObjectClass);

  if Assigned(ObjectPropertiesStorageEntry) then
    Result := ObjectPropertiesStorageEntry.ObjectPropertiesStorage

  else Result := nil;

end;

function TObjectPropertiesStorageRegistry.GetSelf: TObject;
begin

  Result := Self;

end;

procedure TObjectPropertiesStorageRegistry.RegisterObjectPropertiesStorageForObjectClass(
  ObjectClass: TClass;
  ObjectPropertiesStorage: IObjectPropertiesStorage;
  const RegisterOption: TRegisterObjectPropertiesStorageOption
);
var ObjectPropertiesStorageEntry: TObjectPropertiesStorageEntry;
begin

  ObjectPropertiesStorageEntry :=
    FindObjectPropertiesStorageEntryByObjectClass(ObjectClass);

  if Assigned(ObjectPropertiesStorageEntry) then
    ObjectPropertiesStorageEntry.ObjectPropertiesStorage :=
      ObjectPropertiesStorage

  else
    AddObjectPropertiesStorageEntry(
      ObjectClass, ObjectPropertiesStorage, RegisterOption
    );

end;

{ TObjectPropertiesStorageRegistry.TObjectPropertiesStorageEntry }

constructor TObjectPropertiesStorageRegistry.TObjectPropertiesStorageEntry.Create(
  ObjectClass: TClass;
  ObjectPropertiesStorage: IObjectPropertiesStorage;
  RegisterOption: TRegisterObjectPropertiesStorageOption
);
begin

  inherited Create;

  Self.ObjectClass := ObjectClass;
  Self.ObjectPropertiesStorage := ObjectPropertiesStorage;
  Self.RegisterOption := RegisterOption;
  
end;

end.
