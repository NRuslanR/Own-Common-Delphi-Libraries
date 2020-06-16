unit SystemAdministrationPrivilegeServices;

interface

uses

  SysUtils,
  Classes;

type

  TSystemAdministrationPrivilegeServices = class

    public

      PrivilegeId: Variant;

      constructor Create(const PrivilegeId: Variant);

  end;

implementation

{ TSystemAdministrationPrivilegeServices }

constructor TSystemAdministrationPrivilegeServices.Create(
  const PrivilegeId: Variant);
begin

  inherited Create;

  Self.PrivilegeId := PrivilegeId;
  
end;

end.
