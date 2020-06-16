unit ApplicationServiceRegistries;

interface

uses

  ApplicationServiceRegistry;
  
type

  IApplicationServiceRegistries = interface

    procedure Clear;
    
    procedure RegisterApplicationServiceRegistry(
      ApplicationServiceRegistryTypeInfo: Pointer;
      ApplicationServiceRegistry: IApplicationServiceRegistry
    );

    function GetApplicationServiceRegistry(
      ApplicationServiceRegistryTypeInfo: Pointer
    ): IApplicationServiceRegistry;
    
  end;

implementation

end.
