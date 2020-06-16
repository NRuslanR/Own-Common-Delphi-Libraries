unit DBDataTableFilterFormStatePropertiesStorage;

interface

uses

  IObjectPropertiesStorageUnit,
  TableViewFilterFormUnit,
  SysUtils,
  Classes;

type

  TDBDataTableFilterFormStatePropertiesStorage = class (TInterfacedObject, IObjectPropertiesStorage)

    protected

      procedure InternalSaveObjectProperties(FilterFormState: TTableViewFilterFormState); virtual; abstract;
      procedure InternalRestorePropertiesForObject(FilterFormState: TTableViewFilterFormState); virtual; abstract;

      constructor Create; virtual;
      
    public

      function GetSelf: TObject;

      procedure SaveObjectProperties(TargetObject: TObject);
      procedure RestorePropertiesForObject(TargetObject: TObject);

  end;

implementation

{ TDBDataTableFilterFormStatePropertiesStorage }

constructor TDBDataTableFilterFormStatePropertiesStorage.Create;
begin

  inherited;

end;

function TDBDataTableFilterFormStatePropertiesStorage.GetSelf: TObject;
begin

  Result := Self;
  
end;

procedure TDBDataTableFilterFormStatePropertiesStorage.RestorePropertiesForObject(
  TargetObject: TObject);
begin

  if Assigned(TargetObject) then
    InternalRestorePropertiesForObject(TargetObject as TTableViewFilterFormState);
  
end;

procedure TDBDataTableFilterFormStatePropertiesStorage.SaveObjectProperties(
  TargetObject: TObject);
begin

  if Assigned(TargetObject) then
    InternalSaveObjectProperties(TargetObject as TTableViewFilterFormState);

end;

end.
