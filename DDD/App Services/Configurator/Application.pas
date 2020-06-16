unit Application;

interface

uses

  ApplicationServiceRegistries,
  ClientAccount;

type

  IApplication = interface
  ['{407BC790-6426-4307-A527-4D062CEEBE8E}']
  
    function GetApplicationServiceRegistries: IApplicationServiceRegistries;

    procedure SetApplicationServiceRegistries(
      Value: IApplicationServiceRegistries
    );

    function GetClientAccount: TClientAccount;
    procedure SetClientAccount(ClientAccount: TClientAccount);

    
    property ServiceRegistries: IApplicationServiceRegistries
    read GetApplicationServiceRegistries
    write SetApplicationServiceRegistries;

    property ClientAccount: TClientAccount
    read GetClientAccount write SetClientAccount;
    
  end;
  
implementation

end.
