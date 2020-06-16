unit ApplicationServiceRegistry;

interface

uses

  ApplicationService;

type

  IApplicationServiceRegistry = interface

    procedure Clear;
    
    procedure RegisterApplicationService(
      ApplicationServiceTypeInfo: Pointer;
      ApplicationService: IApplicationService
    );

    procedure RegisterOrUpdateApplicationService(
      ApplicationServiceTypeInfo: Pointer;
      ApplicationService: IApplicationService
    );

    function GetApplicationService(
      ApplicationServiceTypeInfo: Pointer
    ): IApplicationService;
    
  end;

implementation

end.
