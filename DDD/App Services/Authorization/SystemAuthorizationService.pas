unit SystemAuthorizationService;

interface

uses

  ApplicationService;
  
type

  TSystemAuthorizationServiceException = class (TApplicationServiceException)

  end;
  
  ISystemAuthorizationService = interface (IApplicationService)

    function IsRoleAssignedToClient(
      const ClientIdentity: Variant;
      const RoleIdentity: Variant
    ): Boolean;

    procedure EnsureThatRoleAssignedToClient(
      const RoleIdentity: Variant;
      const ClientIdentity: Variant
    );
    
    procedure AssignRoleToClient(
      const RoleIdentity: Variant;
      const ClientIdentity: Variant
    );
    
  end;

implementation

end.
