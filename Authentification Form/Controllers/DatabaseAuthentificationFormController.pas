unit DatabaseAuthentificationFormController;

{
procedure OnFormDestroyHandler(Sender: TObject); virtual;
}

interface

uses

  SystemAuthentificationFormController,
  SystemAuthentificationFormViewModel,
  DatabaseAuthentificationFormViewModel,
  unDatabaseAuthentificationForm,
  unSystemAuthentificationForm,
  DatabaseServerAuthentificationService,
  AbstractFormController,
  IObjectPropertiesStorageUnit,
  AuthentificationData,
  SystemAuthentificationService,
  ServiceInfo,
  EventBus,
  Forms,
  SySutils,
  Classes;

type

  TDatabaseAuthentificationFormController =
    class (TSystemAuthentificationFormController)

      protected

        FViewModelPropertiesStorage: IObjectPropertiesStorage;

      protected

        function GetClientServiceAuthentificationDataClass:
          TClientServiceAuthentificationDataClass; override;
          
        procedure FillClientServiceAuthentificationDataFromViewModel(
          ClientServiceAuthentificationData:
            TClientServiceAuthentificationData;

          ViewModel: TSystemAuthentificationFormViewModel
        ); override;

      protected

        function GetSystemAuthentificationFormViewModelClass:
          TSystemAuthentificationFormViewModelClass; override;

        procedure FillSystemAuthentificationFormViewModel(
          ViewModel: TSystemAuthentificationFormViewModel
        ); override;

        function
        UpdateDatabaseAuthentificationFormViewModelOnSuccessAuthentification(
          ViewModel: TDatabaseAuthentificationFormViewModel
        ): Boolean; virtual;

      protected

        procedure OnSystemAuthentificationRequestedEventHandler(
          Sender: TObject;
          ViewModel: TSystemAuthentificationFormViewModel;
          var CloseForm: Boolean
        ); override;

      function GetServiceInfoClass: TServiceInfoClass;

      protected

        function GetFormClass: TFormClass; override;

      public

        constructor Create(
          EventBus: IEventBus;
          DatabaseServerAuthentificationService: IDatabaseServerAuthentificationService;
          ViewModelPropertiesStorage: IObjectPropertiesStorage
        );
        
    end;


implementation
  
{ TDatabaseAuthentificationFormController }

constructor TDatabaseAuthentificationFormController.Create(
  EventBus: IEventBus;
  DatabaseServerAuthentificationService: IDatabaseServerAuthentificationService;
  ViewModelPropertiesStorage: IObjectPropertiesStorage
);
begin

  inherited Create(EventBus, DatabaseServerAuthentificationService);

  FViewModelPropertiesStorage := ViewModelPropertiesStorage;
  
end;

procedure TDatabaseAuthentificationFormController.
  FillClientServiceAuthentificationDataFromViewModel(
    ClientServiceAuthentificationData: TClientServiceAuthentificationData;
    ViewModel: TSystemAuthentificationFormViewModel
  );
begin

  inherited;

  with
    ClientServiceAuthentificationData as
    TUserDatabaseServerAuthentificationData,
    ViewModel as TDatabaseAuthentificationFormViewModel
  do begin

    DatabaseServerInfo := TDatabaseServerInfo.Create;
    DatabaseServerInfo.Database := CurrentDatabaseName;
    
  end;

end;

procedure TDatabaseAuthentificationFormController.
  FillSystemAuthentificationFormViewModel(
    ViewModel: TSystemAuthentificationFormViewModel
  );
begin

  inherited;

  FViewModelPropertiesStorage.RestorePropertiesForObject(ViewModel);

end;

function TDatabaseAuthentificationFormController.
  GetClientServiceAuthentificationDataClass:
    TClientServiceAuthentificationDataClass;
begin

  Result := TUserDatabaseServerAuthentificationData;
  
end;

function TDatabaseAuthentificationFormController.GetFormClass: TFormClass;
begin

  Result := TDatabaseAuthentificationForm;

end;

function TDatabaseAuthentificationFormController.
  GetServiceInfoClass: TServiceInfoClass;
begin

  Result := TDatabaseServerInfo;
  
end;

function TDatabaseAuthentificationFormController.
  GetSystemAuthentificationFormViewModelClass:
    TSystemAuthentificationFormViewModelClass;
begin

  Result := TDatabaseAuthentificationFormViewModel;
  
end;

function TDatabaseAuthentificationFormController.
  UpdateDatabaseAuthentificationFormViewModelOnSuccessAuthentification(
    ViewModel: TDatabaseAuthentificationFormViewModel
  ): Boolean;
begin

  with ViewModel do begin

    Result := DatabaseNames.IndexOf(CurrentDatabaseName) = -1;

    if Result then
      DatabaseNames.Add(CurrentDatabaseName);

  end;

end;

procedure TDatabaseAuthentificationFormController.
  OnSystemAuthentificationRequestedEventHandler(
    Sender: TObject;
    ViewModel: TSystemAuthentificationFormViewModel;
    var CloseForm: Boolean
  );
var IsViewModelUpdated: Boolean;
begin

  inherited;

  IsViewModelUpdated :=
    UpdateDatabaseAuthentificationFormViewModelOnSuccessAuthentification(
      ViewModel as TDatabaseAuthentificationFormViewModel
    );

  FViewModelPropertiesStorage.SaveObjectProperties(ViewModel);

  if IsViewModelUpdated then
    ViewModel.OnUpdated;

end;

end.
