unit AbstractSectionStackedFormController;

interface

uses

  AbstractFormController,
  Forms,
  unSectionStackedForm,
  SectionRecordViewModel,
  SectionStackedFormViewModel,
  SectionSetHolder,
  FormEvents,
  Controls,
  EventHandler,
  Event,
  EventBus,
  SysUtils,
  Classes;

type

  TAbstractSectionStackedFormController =
    class abstract (TAbstractFormController, IEventHandler)

      protected

        procedure SubscribeOnEvents(EventBus: IEventBus); override;
        procedure SubscribeOnFormEvents(Form: TForm); override;
        procedure CustomizeForm(Form: TForm; FormData: TFormData); override;

        function GetFormClass: TFormClass; override;

      protected

        function CreateSectionStackedFormViewModel: TSectionStackedFormViewModel; virtual;

        function GetSectionStackedFormViewModelClass: TSectionStackedFormViewModelClass; virtual;
        function GetSectionSetHolderClass: TSectionSetHolderClass; virtual;
        function GetSectionSetFieldDefsClass: TSectionSetFieldDefsClass; virtual;

        procedure InitializeSectionSetFieldDefs(
          SectionSetFieldDefs: TSectionSetFieldDefs
        ); virtual; abstract;

        procedure FillSectionStackedFormViewModel(
          ViewModel: TSectionStackedFormViewModel
        ); virtual; abstract;

      protected

        function CreateSectionFormRequestedEventFrom(
          SectionRecordViewModel: TSectionRecordViewModel
        ): TSectionFormRequestedEvent; virtual;
        
      protected

        procedure OnSectionControlRequestedEventHandler(
          Sender: TObject;
          SectionRecordViewModel: TSectionRecordViewModel;
          var Control: TControl;
          var Success: Boolean
        ); virtual;

      protected

        procedure OnSectionalFormInflatingRequestedEventHandler(
          Event: TSectionalFormInflatingRequestedEvent
        ); virtual;
        
      public

        procedure Handle(Event: TEvent); virtual;

        function GetSelf: TObject;

    end;

implementation

{ TAbstractSectionStackedFormController }

function TAbstractSectionStackedFormController.CreateSectionFormRequestedEventFrom(
  SectionRecordViewModel: TSectionRecordViewModel): TSectionFormRequestedEvent;
begin

  Result := TSectionFormRequestedEvent.Create(SectionRecordViewModel.Id);

end;

function TAbstractSectionStackedFormController.CreateSectionStackedFormViewModel: TSectionStackedFormViewModel;
begin

  Result := GetSectionStackedFormViewModelClass.Create;

  try

    Result.SectionSetHolder := GetSectionSetHolderClass.Create;

    Result.SectionSetHolder.FieldDefs := GetSectionSetFieldDefsClass.Create;

    InitializeSectionSetFieldDefs(Result.SectionSetHolder.FieldDefs);

    FillSectionStackedFormViewModel(Result);

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;
  
end;

procedure TAbstractSectionStackedFormController.CustomizeForm(
  Form: TForm;
  FormData: TFormData
);
var SectionStackedForm: TSectionStackedForm;
begin

  inherited;

  SectionStackedForm := Form as TSectionStackedForm;

  SectionStackedForm.ViewModel := CreateSectionStackedFormViewModel;

end;

function TAbstractSectionStackedFormController.GetFormClass: TFormClass;
begin

  Result := TSectionStackedForm;

end;

function TAbstractSectionStackedFormController.GetSectionSetFieldDefsClass: TSectionSetFieldDefsClass;
begin

  Result := TSectionSetFieldDefs;
  
end;

function TAbstractSectionStackedFormController.GetSectionSetHolderClass: TSectionSetHolderClass;
begin

  Result := TSectionSetHolder;

end;

function TAbstractSectionStackedFormController.GetSectionStackedFormViewModelClass: TSectionStackedFormViewModelClass;
begin

  Result := TSectionStackedFormViewModel;
  
end;

function TAbstractSectionStackedFormController.GetSelf: TObject;
begin

  Result := Self;

end;

procedure TAbstractSectionStackedFormController.Handle(Event: TEvent);
begin

  if Event is TSectionalFormInflatingRequestedEvent then begin

    OnSectionalFormInflatingRequestedEventHandler(
      Event as TSectionalFormInflatingRequestedEvent
    );
    
  end

  else inherited;

end;

procedure TAbstractSectionStackedFormController.
  OnSectionalFormInflatingRequestedEventHandler(
    Event: TSectionalFormInflatingRequestedEvent
  );
var SectionStackedForm: TSectionStackedForm;
begin

  SectionStackedForm := CurrentForm as TSectionStackedForm;

  SectionStackedForm.ChangeControlOfSection(
    Event.SectionId, Event.InflateableControl
  );
  
end;
  
procedure TAbstractSectionStackedFormController.
  OnSectionControlRequestedEventHandler(
    Sender: TObject;
    SectionRecordViewModel: TSectionRecordViewModel;
    var Control: TControl;
    var Success: Boolean
  );
var SectionFormRequestedEvent: TSectionFormRequestedEvent;
begin

  Success := False;
  
  SectionFormRequestedEvent :=
    CreateSectionFormRequestedEventFrom(SectionRecordViewModel);

  try

    EventBus.RaiseEvent(SectionFormRequestedEvent);
    
  finally

    FreeAndNil(SectionFormRequestedEvent);
    
  end;

end;

procedure TAbstractSectionStackedFormController.SubscribeOnEvents(
  EventBus: IEventBus);
begin

  inherited;

  EventBus.RegisterEventHandler(TSectionalFormInflatingRequestedEvent, Self);

end;

procedure TAbstractSectionStackedFormController.SubscribeOnFormEvents(
  Form: TForm);
var SectionStackedForm: TSectionStackedForm;
begin

  inherited;

  SectionStackedForm := Form as TSectionStackedForm;

  SectionStackedForm.OnSectionControlRequestedEventHandler :=
    OnSectionControlRequestedEventHandler;
    
end;

end.
