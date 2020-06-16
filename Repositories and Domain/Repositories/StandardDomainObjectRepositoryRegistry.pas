unit StandardDomainObjectRepositoryRegistry;

interface

uses

  ISessionUnit,
  DomainObjectRepository,
  DomainObjectRepositoryRegistry,
  DomainObjectUnit,
  SysUtils,
  Classes;

type

  TDomainObjectRepositoryRegistry =
    class (TInterfacedObject, IDomainObjectRepositoryRegistry)

      protected

        class var FInstance: IDomainObjectRepositoryRegistry;

      protected
      
        class function GetCurrent: IDomainObjectRepositoryRegistry; static;
        class procedure SetCurrent(const Value: IDomainObjectRepositoryRegistry); static;

      private

        type

          TDomainObjectRepositoryHolder = class

            DomainObjectClass: TDomainObjectClass;
            DomainObjectRepository: IDomainObjectRepository;

            constructor Create(
              DomainObjectClass: TDomainObjectClass;
              DomainObjectRepository: IDomainObjectRepository
            );
            
          end;

      private

        FSession: ISession;
        FDomainObjectRepositoryHolders: TList;

        function FindDomainObjectRepositoryHolder(
          DomainObjectClass: TDomainObjectClass
        ): TDomainObjectRepositoryHolder;

        procedure AddDomainObjectRepository(
          DomainObjectClass: TDomainObjectClass;
          DomainObjectRepository: IDomainObjectRepository
        );

      protected

        class function CreateInstance: IDomainObjectRepositoryRegistry;

      public

        procedure RegisterSessionManager(Session: ISession);

        function GetSessionManager: ISession;

      public

        procedure Clear;
        
        procedure RegisterDomainObjectRepository(
          DomainObjectClass: TDomainObjectClass;
          DomainObjectRepository: IDomainObjectRepository
        );

        function GetDomainObjectRepository(
          DomainObjectClass: TDomainObjectClass
        ): IDomainObjectRepository;

      public

        constructor Create; 
        
        destructor Destroy; override;

        class property Current: IDomainObjectRepositoryRegistry
        read GetCurrent write SetCurrent;
        
    end;
    
implementation

uses

  AuxCollectionFunctionsUnit;

{ TDomainObjectRepositoryRegistry }

function TDomainObjectRepositoryRegistry.GetDomainObjectRepository(
  DomainObjectClass: TDomainObjectClass
): IDomainObjectRepository;
var Holder: TDomainObjectRepositoryHolder;
begin

  Holder := FindDomainObjectRepositoryHolder(DomainObjectClass);

  if Assigned(Holder) then
    Result := Holder.DomainObjectRepository

  else Result := nil;
  
end;

function TDomainObjectRepositoryRegistry.GetSessionManager: ISession;
begin

  Result := FSession;
  
end;

procedure TDomainObjectRepositoryRegistry.RegisterDomainObjectRepository(
  DomainObjectClass: TDomainObjectClass;
  DomainObjectRepository: IDomainObjectRepository
);
var Holder: TDomainObjectRepositoryHolder;
begin

  Holder := FindDomainObjectRepositoryHolder(DomainObjectClass);

  if Assigned(Holder) then
    Holder.DomainObjectRepository := DomainObjectRepository

  else AddDomainObjectRepository(DomainObjectClass, DomainObjectRepository);
  
end;

procedure TDomainObjectRepositoryRegistry.RegisterSessionManager(
  Session: ISession);
begin

  FSession := Session;
  
end;

procedure TDomainObjectRepositoryRegistry.AddDomainObjectRepository(
  DomainObjectClass: TDomainObjectClass;
  DomainObjectRepository: IDomainObjectRepository
);
begin

  FDomainObjectRepositoryHolders.Add(
    TDomainObjectRepositoryHolder.Create(
      DomainObjectClass, DomainObjectRepository
    )
  );

end;

procedure TDomainObjectRepositoryRegistry.Clear;
begin

  FSession := nil;
  
  FreeListItems(FDomainObjectRepositoryHolders);
  
end;

constructor TDomainObjectRepositoryRegistry.Create;
begin

  inherited;

  FDomainObjectRepositoryHolders := TList.Create;

end;

class function TDomainObjectRepositoryRegistry.CreateInstance: IDomainObjectRepositoryRegistry;
begin

  Result := TDomainObjectRepositoryRegistry.Create;
  
end;

destructor TDomainObjectRepositoryRegistry.Destroy;
begin

  FreeListWithItems(FDomainObjectRepositoryHolders);
  
  inherited;

end;

function TDomainObjectRepositoryRegistry.FindDomainObjectRepositoryHolder(
  DomainObjectClass: TDomainObjectClass
): TDomainObjectRepositoryHolder;
var HolderPointer: Pointer;
begin

  for HolderPointer in FDomainObjectRepositoryHolders do begin

    Result := TDomainObjectRepositoryHolder(HolderPointer);

    if Result.DomainObjectClass = DomainObjectClass then
      Exit;

  end;

  Result := nil;

end;

class function TDomainObjectRepositoryRegistry.GetCurrent: IDomainObjectRepositoryRegistry;
begin

  if not Assigned(FInstance) then
    FInstance := CreateInstance;

  Result := FInstance;
  
end;

class procedure TDomainObjectRepositoryRegistry.SetCurrent(
  const Value: IDomainObjectRepositoryRegistry);
begin

  FInstance := Value;
  
end;

{ TDomainObjectRepositoryRegistry.TDomainObjectRepositoryHolder }

constructor TDomainObjectRepositoryRegistry.TDomainObjectRepositoryHolder.Create(
  DomainObjectClass: TDomainObjectClass;
  DomainObjectRepository: IDomainObjectRepository);
begin

  inherited Create;

  Self.DomainObjectClass := DomainObjectClass;
  Self.DomainObjectRepository := DomainObjectRepository;
  
end;

end.
