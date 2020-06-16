unit InMemoryApplicationServiceRegistry;

interface

uses

  ApplicationService,
  AbstractApplicationServiceRegistry,
  ApplicationServiceRegistry,
  SysUtils,
  Classes;

type

  TInMemoryApplicationServiceRegistry = class (TAbstractApplicationServiceRegistry)

    private

      type

        TApplicationServiceItem = class

          ServiceTypeInfo: Pointer;
          ApplicationService: IApplicationService;

          constructor Create(
            ServiceTypeInfo: Pointer;
            ApplicationService: IApplicationService
          );

        end;

    private

      FApplicationServiceItems: TList;

      function FindApplicationServiceItemByServiceTypeInfo(
        ServiceTypeInfo: Pointer
      ): TApplicationServiceItem;

      function IsApplicationServiceExists(ServiceTypeInfo: Pointer): Boolean;

      procedure AddApplicationServiceItem(
        ServiceTypeInfo: Pointer;
        ApplicationService: IApplicationService
      );
      
    public

      destructor Destroy; override;
      constructor Create;

      procedure Clear; override;
      
      procedure RegisterApplicationService(
        ApplicationServiceTypeInfo: Pointer;
        ApplicationService: IApplicationService
      ); override;

      procedure RegisterOrUpdateApplicationService(
        ApplicationServiceTypeInfo: Pointer;
        ApplicationService: IApplicationService
      ); override;

      function GetApplicationService(
        ApplicationServiceTypeInfo: Pointer
      ): IApplicationService; override;

  end;

implementation

uses

  TypInfo,
  AuxCollectionFunctionsUnit;
  

{ TInMemoryApplicationServiceRegistry }

procedure TInMemoryApplicationServiceRegistry.AddApplicationServiceItem(
  ServiceTypeInfo: Pointer; ApplicationService: IApplicationService);
begin

  FApplicationServiceItems.Add(
    TApplicationServiceItem.Create(ServiceTypeInfo, ApplicationService)
  );

end;

procedure TInMemoryApplicationServiceRegistry.Clear;
begin

  FreeListItems(FApplicationServiceItems);

end;

constructor TInMemoryApplicationServiceRegistry.Create;
begin

  inherited;

  FApplicationServiceItems := TList.Create;
  
end;

destructor TInMemoryApplicationServiceRegistry.Destroy;
begin

  FreeListWithItems(FApplicationServiceItems);
  inherited;

end;

function TInMemoryApplicationServiceRegistry.FindApplicationServiceItemByServiceTypeInfo(
  ServiceTypeInfo: Pointer): TApplicationServiceItem;
var I: Integer;
begin

  for I := 0 to FApplicationServiceItems.Count - 1 do begin

    Result := TApplicationServiceItem(FApplicationServiceItems[I]);

    if Result.ServiceTypeInfo = ServiceTypeInfo then
      Exit;

  end;

  Result := nil;

end;

function TInMemoryApplicationServiceRegistry.GetApplicationService(
  ApplicationServiceTypeInfo: Pointer): IApplicationService;
var ApplicationServiceItem: TApplicationServiceItem;
begin

  ApplicationServiceItem :=
    FindApplicationServiceItemByServiceTypeInfo(ApplicationServiceTypeInfo);

  if Assigned(ApplicationServiceItem) then
    Result := ApplicationServiceItem.ApplicationService

  else Result := nil;
  
end;

function TInMemoryApplicationServiceRegistry.IsApplicationServiceExists(
  ServiceTypeInfo: Pointer): Boolean;
begin

  Result := Assigned(FindApplicationServiceItemByServiceTypeInfo(ServiceTypeInfo));
  
end;

procedure TInMemoryApplicationServiceRegistry.RegisterApplicationService(
  ApplicationServiceTypeInfo: Pointer;
  ApplicationService: IApplicationService
);
begin
        
  if IsApplicationServiceExists(ApplicationServiceTypeInfo) then begin

    raise Exception.CreateFmt(
      'Application service of the type "%s" ' +
      'is already exists',
      [GetServiceTypeName(ApplicationServiceTypeInfo)]
    );
    
  end;

  AddApplicationServiceItem(ApplicationServiceTypeInfo, ApplicationService);
  
end;

procedure TInMemoryApplicationServiceRegistry.
  RegisterOrUpdateApplicationService(
    ApplicationServiceTypeInfo: Pointer;
    ApplicationService: IApplicationService
  );
var ApplicationServiceItem: TApplicationServiceItem;
begin

  ApplicationServiceItem :=
    FindApplicationServiceItemByServiceTypeInfo(ApplicationServiceTypeInfo);

  if Assigned(ApplicationServiceItem) then
    ApplicationServiceItem.ApplicationService := ApplicationService

  else
    AddApplicationServiceItem(ApplicationServiceTypeInfo, ApplicationService);
    
end;

{ TInMemoryApplicationServiceRegistry.TApplicationServiceItem }

constructor TInMemoryApplicationServiceRegistry.TApplicationServiceItem.Create(
  ServiceTypeInfo: Pointer; ApplicationService: IApplicationService);
begin

  inherited Create;

  Self.ServiceTypeInfo := ServiceTypeInfo;
  Self.ApplicationService := ApplicationService;
  
end;

end.
