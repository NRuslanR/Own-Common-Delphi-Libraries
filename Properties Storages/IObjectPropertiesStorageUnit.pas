unit IObjectPropertiesStorageUnit;

interface

uses

  IGetSelfUnit,
  SysUtils,
  Classes;

type

  IObjectPropertiesStorage = interface (IGetSelf)

    procedure SaveObjectProperties(TargetObject: TObject);
    procedure RestorePropertiesForObject(TargetObject: TObject);
    
  end;

implementation

end.
