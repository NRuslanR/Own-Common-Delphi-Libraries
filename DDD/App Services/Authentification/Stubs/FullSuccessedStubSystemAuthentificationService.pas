unit FullSuccessedStubSystemAuthentificationService;

interface

uses

  AuthentificationData,
  SystemAuthentificationService,
  ClientLogOnInfo,
  ServiceInfo,
  SysUtils,
  ClientAccount,
  Classes;

type

  TFullSuccessedStubSystemAuthentificationService =
    class (TInterfacedObject, ISystemAuthentificationService)

      protected

        function CreateClientAccount: TClientAccount; virtual;

        procedure FillClientAccount(ClientAccount: TClientAccount); virtual;
        
      public

        function Authentificate(
          AuthentificationData: TClientServiceAuthentificationData
        ): TClientAccount;

    end;
  
implementation

uses

  Variants;
  
{ TFullSuccessedStubSystemAuthentificationService }

function TFullSuccessedStubSystemAuthentificationService.Authentificate(
  AuthentificationData: TClientServiceAuthentificationData
): TClientAccount;
begin

  Result := CreateClientAccount;

  FillClientAccount(Result);

end;

function TFullSuccessedStubSystemAuthentificationService.CreateClientAccount: TClientAccount;
begin

  Result := TClientAccount.Create;
  
end;

procedure TFullSuccessedStubSystemAuthentificationService.FillClientAccount(
  ClientAccount: TClientAccount);
begin

  ClientAccount.Identity := Null;
  
end;

end.
