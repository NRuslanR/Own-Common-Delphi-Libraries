unit AbstractSystemAuthentificationFormViewModelPropertiesStorage;

interface

uses

  PropertiesIniFileUnit,
  IObjectPropertiesStorageUnit,
  SystemAuthentificationFormViewModel,
  SysUtils,
  Classes;

type

  TAbstractSystemAuthentificationFormViewModelPropertiesStorageException =
    class (Exception)

    end;
    
  TAbstractSystemAuthentificationFormViewModelPropertiesStorage =
    class abstract (TInterfacedObject, IObjectPropertiesStorage)

      protected

        procedure RaiseExceptionIfObjectHasNotValidType(
          VerifiableObject: TObject
        );

        function HasObjectValidType(VerifiableObject: TObject): Boolean; virtual;

        function GetValidSystemAuthentificationFormViewModelClass:
          TSystemAuthentificationFormViewModelClass; virtual;
          
      protected

        procedure SaveSystemAuthentificationFormViewModelProperties(
          ViewModel: TSystemAuthentificationFormViewModel
        ); virtual; abstract;

        procedure RestoreSystemAuthentificationFormViewModelProperties(
          ViewModel: TSystemAuthentificationFormViewModel
        ); virtual; abstract;

      public

        function GetSelf: TObject;
        
        procedure SaveObjectProperties(TargetObject: TObject);
        procedure RestorePropertiesForObject(TargetObject: TObject);

    end;

implementation

{ TAbstractSystemAuthentificationFormViewModelPropertiesStorage }

function TAbstractSystemAuthentificationFormViewModelPropertiesStorage.GetSelf: TObject;
begin

  Result := Self;
  
end;

function TAbstractSystemAuthentificationFormViewModelPropertiesStorage.
  GetValidSystemAuthentificationFormViewModelClass:
    TSystemAuthentificationFormViewModelClass;
begin

  Result := TSystemAuthentificationFormViewModel;
  
end;

function TAbstractSystemAuthentificationFormViewModelPropertiesStorage.
  HasObjectValidType(
    VerifiableObject: TObject
  ): Boolean;
begin

  Result :=
    VerifiableObject is GetValidSystemAuthentificationFormViewModelClass;

end;

procedure TAbstractSystemAuthentificationFormViewModelPropertiesStorage.
  RaiseExceptionIfObjectHasNotValidType(
    VerifiableObject: TObject
  );
begin

  if not HasObjectValidType(VerifiableObject) then begin

    raise
    TAbstractSystemAuthentificationFormViewModelPropertiesStorageException
      .CreateFmt(
        'Type "%s" isn''t descendant of "%s"',
        [
          VerifiableObject.ClassName,
          GetValidSystemAuthentificationFormViewModelClass.ClassName
        ]
      );

  end;

end;

procedure TAbstractSystemAuthentificationFormViewModelPropertiesStorage.
  RestorePropertiesForObject(
    TargetObject: TObject
  );
begin

  RaiseExceptionIfObjectHasNotValidType(TargetObject);
  
  RestoreSystemAuthentificationFormViewModelProperties(
    TargetObject as TSystemAuthentificationFormViewModel
  );
  

end;

procedure TAbstractSystemAuthentificationFormViewModelPropertiesStorage.
  SaveObjectProperties(
    TargetObject: TObject
  );
begin

  RaiseExceptionIfObjectHasNotValidType(TargetObject);

  SaveSystemAuthentificationFormViewModelProperties(
    TargetObject as TSystemAuthentificationFormViewModel
  );
  
end;

end.
