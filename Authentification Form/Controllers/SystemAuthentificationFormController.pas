unit SystemAuthentificationFormController;

interface

uses

  unSystemAuthentificationForm,
  AbstractFormController,
  SystemAuthentificationFormViewModel,
  SystemAuthentificationService,
  SystemAuthentificationFormControllerEvents,
  ServiceInfo,
  AuthentificationData,
  ClientAccount,
  ClientLogOnInfo,
  EventBus,
  Event,
  EventHandler,
  Forms,
  SysUtils,
  Classes;

type

  TSystemAuthentificationFormController =
    class (TAbstractFormController, IEventHandler)

      protected

        FSystemAuthentificationService: ISystemAuthentificationService;

      protected

        procedure OnSystemAuthentificationRequestedEventHandler(
          Sender: TObject;
          ViewModel: TSystemAuthentificationFormViewModel;
          var CloseForm: Boolean
        ); virtual;
      
      protected

        function CreateSystemAuthentificationFormViewModel:
          TSystemAuthentificationFormViewModel; virtual;

        function GetSystemAuthentificationFormViewModelClass:
          TSystemAuthentificationFormViewModelClass; virtual;

        procedure FillSystemAuthentificationFormViewModel(
          ViewModel: TSystemAuthentificationFormViewModel
        ); virtual;

      protected

        function MapViewModelToAuthentificationData(
          ViewModel: TSystemAuthentificationFormViewModel
        ): TClientServiceAuthentificationData; virtual;

        function GetClientServiceAuthentificationDataClass:
          TClientServiceAuthentificationDataClass; virtual;

        procedure FillClientServiceAuthentificationDataFromViewModel(
          ClientServiceAuthentificationData:
            TClientServiceAuthentificationData;

          ViewModel: TSystemAuthentificationFormViewModel
        ); virtual;

      protected

        procedure SubscribeOnEvents(EventBus: IEventBus); override;

      protected

        procedure HandleLogOnRequestedEvent(Event: TLogOnRequestedEvent);
 
      protected

        procedure SubscribeOnFormEvents(Form: TForm); override;
        procedure CustomizeForm(Form: TForm; FormData: TFormData); override;

        function GetFormClass: TFormClass; override;

      public

        constructor Create(
          EventBus: IEventBus;
          SystemAuthentificationService: ISystemAuthentificationService
        );

      public

        procedure Handle(Event: TEvent);

        function GetSelf: TObject;
    
    end;


implementation

uses

  Controls,
  AuxWindowsFunctionsUnit;

{ TSystemAuthentificationFormController }

constructor TSystemAuthentificationFormController.Create(
  EventBus: IEventBus;
  SystemAuthentificationService: ISystemAuthentificationService
);
begin

  inherited Create(EventBus);

  FSystemAuthentificationService := SystemAuthentificationService;
  
end;

function TSystemAuthentificationFormController.
  CreateSystemAuthentificationFormViewModel: TSystemAuthentificationFormViewModel;
begin

  Result := GetSystemAuthentificationFormViewModelClass.Create;

  try

    FillSystemAuthentificationFormViewModel(Result);
    
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

procedure TSystemAuthentificationFormController.CustomizeForm(Form: TForm;
  FormData: TFormData);
begin

  inherited;

  with Form as TSystemAuthentificationForm do
    ViewModel := CreateSystemAuthentificationFormViewModel;

end;

procedure TSystemAuthentificationFormController.
  FillClientServiceAuthentificationDataFromViewModel(
    ClientServiceAuthentificationData: TClientServiceAuthentificationData;
    ViewModel: TSystemAuthentificationFormViewModel
  );
begin

  with
    ClientServiceAuthentificationData as
    TUserServiceAuthentificationData
  do begin

    UserLogOnInfo :=
      TUserLogOnInfo.Create(
        ViewModel.ClientLogin,
        ViewModel.ClientPassword
      );

    ServiceInfo := TServiceInfo.Create;
    
  end;

end;

procedure TSystemAuthentificationFormController.
  FillSystemAuthentificationFormViewModel(
    ViewModel: TSystemAuthentificationFormViewModel
  );
begin

end;

function TSystemAuthentificationFormController.
  GetClientServiceAuthentificationDataClass:
    TClientServiceAuthentificationDataClass;
begin

  Result := TUserServiceAuthentificationData;
  
end;

function TSystemAuthentificationFormController.GetFormClass: TFormClass;
begin

  Result := TSystemAuthentificationForm;

end;

function TSystemAuthentificationFormController.GetSelf: TObject;
begin

  Result := Self;
  
end;

function TSystemAuthentificationFormController.
  GetSystemAuthentificationFormViewModelClass:
    TSystemAuthentificationFormViewModelClass;
begin

  Result := TSystemAuthentificationFormViewModel;
  
end;

procedure TSystemAuthentificationFormController.Handle(Event: TEvent);
begin

  if Event is TLogOnRequestedEvent then begin

    HandleLogOnRequestedEvent(TLogOnRequestedEvent(Event));

  end

  else inherited;
  
end;

procedure TSystemAuthentificationFormController.HandleLogOnRequestedEvent(
  Event: TLogOnRequestedEvent);
begin

  with CreateForm(TComponent(nil)) do
    ShowFormAsModal(Application);
  
end;

function TSystemAuthentificationFormController.
  MapViewModelToAuthentificationData(
    ViewModel: TSystemAuthentificationFormViewModel
  ): TClientServiceAuthentificationData;
begin

  Result := GetClientServiceAuthentificationDataClass.Create;
  
  try

    FillClientServiceAuthentificationDataFromViewModel(
      Result, ViewModel
    );

  except

    on e: Exception do begin

      FreeAndNil(Result);
      
      raise;
      
    end;

  end;

end;

procedure TSystemAuthentificationFormController.
  OnSystemAuthentificationRequestedEventHandler(
    Sender: TObject;
    ViewModel: TSystemAuthentificationFormViewModel;
    var CloseForm: Boolean
  );
var ClientAccount: TClientAccount;
    ClientServiceAuthentificationData: TClientServiceAuthentificationData;
    ClientAuthentificatedEvent: TClientAuthentificatedEvent;
begin

  ClientServiceAuthentificationData :=
    MapViewModelToAuthentificationData(ViewModel);

  try

    Screen.Cursor := crHourGlass;
    
    ClientAccount :=
      FSystemAuthentificationService.Authentificate(
        ClientServiceAuthentificationData
      );

  finally

    Screen.Cursor := crDefault;

  end;

  ClientAuthentificatedEvent :=
    TClientAuthentificatedEvent.Create(
      ClientAccount,
      ClientServiceAuthentificationData
    );

  try

    EventBus.RaiseEvent(ClientAuthentificatedEvent);

    CloseForm := True;
    
  finally

    FreeAndNil(ClientServiceAuthentificationData);
    FreeAndNil(ClientAuthentificatedEvent);

  end;
  
end;

procedure TSystemAuthentificationFormController.SubscribeOnEvents(
  EventBus: IEventBus);
begin

  inherited;

  EventBus.RegisterEventHandler(TLogOnRequestedEvent, Self);

end;

procedure TSystemAuthentificationFormController.SubscribeOnFormEvents(
  Form: TForm);
var SystemAuthentificationForm: TSystemAuthentificationForm;
begin

  inherited;

  SystemAuthentificationForm := Form as TSystemAuthentificationForm;

  SystemAuthentificationForm.OnSystemAuthentificationRequestedEventHandler :=
    OnSystemAuthentificationRequestedEventHandler;

end;

end.
