unit DBDataTableFormPropertiesStorage;

interface

uses

  IObjectPropertiesStorageUnit,
  DBDataTableFormUnit,
  DBDataTableFilterFormStatePropertiesStorage,
  SysUtils,
  Classes;

type

  TDBDataTableFormPropertiesStorage = class abstract (TInterfacedObject, IObjectPropertiesStorage)

    protected

      FFilterFormStatePropertiesStorage: TDBDataTableFilterFormStatePropertiesStorage;

      procedure InternalSaveObjectProperties(DBDataTableForm: TDBDataTableForm); virtual; abstract;
      procedure InternalRestorePropertiesForObject(DBDataTableForm: TDBDataTableForm); virtual; abstract;

      constructor Create; overload; virtual;
      constructor Create(
        FilterFormStatePropertiesStorage: TDBDataTableFilterFormStatePropertiesStorage
      ); overload;

      procedure SetFilterFormStatePropertiesStorage(
        const Value: TDBDataTableFilterFormStatePropertiesStorage
      );

    public

      destructor Destroy; override;
      
      function GetSelf: TObject;
      
      procedure SaveObjectProperties(TargetObject: TObject);
      procedure RestorePropertiesForObject(TargetObject: TObject);

    published

      property FilterFormStatePropertiesStorage: TDBDataTableFilterFormStatePropertiesStorage
      read FFilterFormStatePropertiesStorage
      write SetFilterFormStatePropertiesStorage;

  end;
  
implementation

{ TDBDataTableFormPropertiesStorage }

constructor TDBDataTableFormPropertiesStorage.Create;
begin

  inherited;
  
end;

constructor TDBDataTableFormPropertiesStorage.Create(
  FilterFormStatePropertiesStorage: TDBDataTableFilterFormStatePropertiesStorage);
begin

  inherited Create;

  Self.FilterFormStatePropertiesStorage := FilterFormStatePropertiesStorage;
  
end;

destructor TDBDataTableFormPropertiesStorage.Destroy;
begin

  inherited;
end;

function TDBDataTableFormPropertiesStorage.GetSelf: TObject;
begin

  Result := Self;
  
end;

procedure TDBDataTableFormPropertiesStorage.RestorePropertiesForObject(
  TargetObject: TObject);
begin

  if Assigned(TargetObject) then
    InternalRestorePropertiesForObject(TargetObject as TDBDataTableForm);

end;

procedure TDBDataTableFormPropertiesStorage.SaveObjectProperties(
  TargetObject: TObject
);
begin

  if Assigned(TargetObject) then
    InternalSaveObjectProperties(TargetObject as TDBDataTableForm);
  
end;


procedure TDBDataTableFormPropertiesStorage.SetFilterFormStatePropertiesStorage(
  const Value: TDBDataTableFilterFormStatePropertiesStorage);
begin

  FreeAndNil(FFilterFormStatePropertiesStorage);
  
  FFilterFormStatePropertiesStorage := Value;

end;

end.
