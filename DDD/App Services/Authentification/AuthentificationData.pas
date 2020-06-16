unit AuthentificationData;

interface

uses

  ClientLogOnInfo,
  ServiceInfo,
  SysUtils,
  Classes;

type

  TAuthentificationData = class

  end;

  TClientServiceAuthentificationData = class (TAuthentificationData)

    private

      FClientLogOnInfo: TClientLogOnInfo;
      FServiceInfo: TServiceInfo;

      procedure SetClientLogOnInfo(const Value: TClientLogOnInfo);
      procedure SetServiceInfo(const Value: TServiceInfo);

    public

      destructor Destroy; override;
      
      constructor Create; overload;
      constructor Create(
        ClientLogOnInfo: TClientLogOnInfo;
        ServiceInfo: TServiceInfo
      ); overload;

    public

      property ClientLogOnInfo: TClientLogOnInfo
      read FClientLogOnInfo write SetClientLogOnInfo;

      property ServiceInfo: TServiceInfo
      read FServiceInfo write SetServiceInfo;
      
  end;

  TClientServiceAuthentificationDataClass =
    class of TClientServiceAuthentificationData;

  TUserServiceAuthentificationData = class (TClientServiceAuthentificationData)

    private

      function GetUserLogOnInfo: TUserLogOnInfo;
      procedure SetUserLogOnInfo(const Value: TUserLogOnInfo);
      
    public

      constructor Create(
        UserLogOnInfo: TUserLogOnInfo;
        ServiceInfo: TServiceInfo
      );

      property UserLogOnInfo: TUserLogOnInfo
      read GetUserLogOnInfo write SetUserLogOnInfo;

  end;
  
  TUserHostProcessAuthentificationData = class (TUserServiceAuthentificationData)

    private

      function GetHostProcessInfo: THostProcessInfo;
      procedure SetHostProcessInfo(const Value: THostProcessInfo);

    public

      constructor Create(
        UserLogOnInfo: TUserLogOnInfo;
        HostProcessInfo: THostProcessInfo
      ); overload;

    public

      property HostProcessInfo: THostProcessInfo
      read GetHostProcessInfo write SetHostProcessInfo;
      
  end;

  TUserDatabaseServerAuthentificationData = class (TUserHostProcessAuthentificationData)

    private

      function GetDatabaseServerInfo: TDatabaseServerInfo;
      procedure SetDatabaseServerInfo(const Value: TDatabaseServerInfo);

    public

      constructor Create(
        UserLogOnInfo: TUserLogOnInfo;
        DatabaseServerInfo: TDatabaseServerInfo
      ); overload;

    public

      property DatabaseServerInfo: TDatabaseServerInfo
      read GetDatabaseServerInfo write SetDatabaseServerInfo;
      
  end;

implementation

{ TClientServiceAuthentificationData }

constructor TClientServiceAuthentificationData.Create(
  ClientLogOnInfo: TClientLogOnInfo; ServiceInfo: TServiceInfo);
begin

  inherited Create;

  FClientLogOnInfo := ClientLogOnInfo;
  FServiceInfo := ServiceInfo;
  
end;

constructor TClientServiceAuthentificationData.Create;
begin

  inherited;

end;

destructor TClientServiceAuthentificationData.Destroy;
begin

  FreeAndNil(FClientLogOnInfo);
  FreeAndNil(FServiceInfo);
  
  inherited;

end;

procedure TClientServiceAuthentificationData.SetClientLogOnInfo(
  const Value: TClientLogOnInfo);
begin

  FreeAndNil(FClientLogOnInfo);
  
  FClientLogOnInfo := Value;

end;

procedure TClientServiceAuthentificationData.SetServiceInfo(
  const Value: TServiceInfo);
begin

  FreeAndNil(FServiceInfo);
  
  FServiceInfo := Value;

end;

{ TUserHostProcessAuthentificationData }

constructor TUserHostProcessAuthentificationData.Create(
  UserLogOnInfo: TUserLogOnInfo; HostProcessInfo: THostProcessInfo);
begin

  inherited Create(UserLogOnInfo, HostProcessInfo);
  
end;

function TUserHostProcessAuthentificationData.GetHostProcessInfo: THostProcessInfo;
begin

  Result := THostProcessInfo(ServiceInfo);
  
end;

procedure TUserHostProcessAuthentificationData.SetHostProcessInfo(
  const Value: THostProcessInfo);
begin

  ServiceInfo := Value;
  
end;

{ TUserDatabaseServerAuthentificationData }

constructor TUserDatabaseServerAuthentificationData.Create(
  UserLogOnInfo: TUserLogOnInfo;
  DatabaseServerInfo: TDatabaseServerInfo
);
begin

  inherited Create(UserLogOnInfo, DatabaseServerInfo);
  
end;

function TUserDatabaseServerAuthentificationData.GetDatabaseServerInfo: TDatabaseServerInfo;
begin

  Result := TDatabaseServerInfo(HostProcessInfo);
  
end;

procedure TUserDatabaseServerAuthentificationData.SetDatabaseServerInfo(
  const Value: TDatabaseServerInfo);
begin

  HostProcessInfo := Value;
  
end;

{ TUserServiceAuthentificationData }

constructor TUserServiceAuthentificationData.Create(
  UserLogOnInfo: TUserLogOnInfo; ServiceInfo: TServiceInfo);
begin

  inherited Create(UserLogOnInfo, ServiceInfo);
  
end;

function TUserServiceAuthentificationData.GetUserLogOnInfo: TUserLogOnInfo;
begin

  Result := ClientLogOnInfo as TUserLogOnInfo;
  
end;

procedure TUserServiceAuthentificationData.SetUserLogOnInfo(
  const Value: TUserLogOnInfo);
begin

  ClientLogOnInfo := Value;
  
end;

end.
