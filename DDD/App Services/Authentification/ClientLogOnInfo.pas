unit ClientLogOnInfo;

interface

type

  TClientLogOnInfo = class

  end;

  TClientLogOnInfoClass = class of TClientLogOnInfo;
  
  TUserLogOnInfo = class (TClientLogOnInfo)

    public

      UserName: String;
      Password: String;

      constructor Create(const UserName, Password: String);

  end;
  
implementation

{ TUserLogOnInfo }

constructor TUserLogOnInfo.Create(const UserName, Password: String);
begin

  inherited Create;

  Self.UserName := UserName;
  Self.Password := Password;
  
end;

end.
