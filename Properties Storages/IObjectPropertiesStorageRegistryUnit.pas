unit IObjectPropertiesStorageRegistryUnit;

interface

uses

  IGetSelfUnit,
  IObjectPropertiesStorageUnit,
  SysUtils,
  Classes;

type

  TRegisterObjectPropertiesStorageOption =
    (
      RegisterWithInheritanceCheckingOptionIfObjectClassNotFound,
      RegisterWithoutInheritanceCheckingOption
    );

  IObjectPropertiesStorageRegistry = interface (IGetSelf)

    procedure RegisterObjectPropertiesStorageForObjectClass(
      ObjectClass: TClass;
      ObjectPropertiesStorage: IObjectPropertiesStorage;
      const RegisterOption: TRegisterObjectPropertiesStorageOption = RegisterWithInheritanceCheckingOptionIfObjectClassNotFound
    );
    
    function GetPropertiesStorageForObjectClass(ObjectClass: TClass): IObjectPropertiesStorage;

  end;

implementation

end.
