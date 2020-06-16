unit AbstractApplicationServiceRegistry;

interface

uses

  ApplicationService,
  ApplicationServiceRegistry,
  SysUtils,
  Classes;

type

  TAbstractApplicationServiceRegistry =
    class abstract (TInterfacedObject, IApplicationServiceRegistry)

      protected

        function GetServiceTypeName(ServiceTypeInfo: Pointer): String;

      public

        procedure Clear; virtual; abstract;

        procedure RegisterApplicationService(
          ApplicationServiceTypeInfo: Pointer;
          ApplicationService: IApplicationService
        ); virtual; abstract;

        procedure RegisterOrUpdateApplicationService(
          ApplicationServiceTypeInfo: Pointer;
          ApplicationService: IApplicationService
        ); virtual; abstract;

        function GetApplicationService(
          ApplicationServiceTypeInfo: Pointer
        ): IApplicationService; virtual; abstract;

    end;
  
implementation

uses

  TypInfo;
  
{ TAbstractApplicationServiceRegistry }

function TAbstractApplicationServiceRegistry.GetServiceTypeName(
  ServiceTypeInfo: Pointer): String;
begin

  Result := PTypeInfo(ServiceTypeInfo)^.Name;

end;

end.
