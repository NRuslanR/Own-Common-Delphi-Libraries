unit SystemAdministrationService;

interface

uses

  ApplicationService,
  SystemAdministrationPrivileges,
  SystemAdministrationPrivilegeServices;
  
type

  ISystemAdministrationService = interface (IApplicationService)

    function HasClientSystemAdministrationPrivileges(
      const ClientIdentity: Variant
    ): Boolean;
    
    function GetAllSystemAdministrationPrivileges(
      const ClientIdentity: Variant
    ): TSystemAdministrationPrivileges;

    function GetSystemAdministrationPrivilegeServices(
      const ClientIdentity: Variant;
      const PrivilegeIdentity: Variant
    ): TSystemAdministrationPrivilegeServices;
    
  end;

implementation

end.
