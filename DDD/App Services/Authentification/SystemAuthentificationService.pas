unit SystemAuthentificationService;

interface

uses

  AuthentificationData,
  ApplicationService,
  ClientLogOnInfo,
  ServiceInfo,
  ClientAccount,
  SysUtils,
  Classes;

type

  ISystemAuthentificationService = interface (IApplicationService)
  ['{F17C57E5-FCEA-40EF-9DFE-496B262BA133}']

    function Authentificate(
      AuthentificationData: TClientServiceAuthentificationData
    ): TClientAccount;

  end;
  
implementation

end.
