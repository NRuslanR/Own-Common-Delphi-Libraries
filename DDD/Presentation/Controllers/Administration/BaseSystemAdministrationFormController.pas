unit BaseSystemAdministrationFormController;

interface

uses

  unSectionStackedForm,
  unSystemAdministrationForm,
  AbstractSectionStackedFormController,
  AbstractFormController,
  SystemAdministrationService,
  SectionRecordViewModel,
  SectionSetHolder,
  SectionStackedFormViewModel,
  SystemAdministrationPrivileges,
  SystemAdministrationFormViewModelMapperInterface,
  BaseSystemAdministrationFormControllerEvents,
  FormEvents,
  Controls,
  EventBus,
  Event,
  Forms,
  SysUtils,
  Classes;

type

  TBaseSystemAdministrationFormController = class (TAbstractSectionStackedFormController)

    protected

      FClientIdentity: Variant;
      FSystemAdministrationService: ISystemAdministrationService;
      FFormViewModelMapper: ISystemAdministrationFormViewModelMapper;
      
    protected

      function GetFormClass: TFormClass; override;

    protected

      function CreateSectionStackedFormViewModel: TSectionStackedFormViewModel; override;

    protected

      function CreateSectionFormRequestedEventFrom(
        SectionRecordViewModel: TSectionRecordViewModel
      ): TSectionFormRequestedEvent; override;

    public

      constructor Create(
        const ClientIdentity: Variant;
        SystemAdministrationService: ISystemAdministrationService;
        FormViewModelMapper: ISystemAdministrationFormViewModelMapper;
        EventBus: IEventBus
      );
    
  end;
  
implementation

{ TBaseSystemAdministrationFormController }

constructor TBaseSystemAdministrationFormController.Create(
  const ClientIdentity: Variant;
  SystemAdministrationService: ISystemAdministrationService;
  FormViewModelMapper: ISystemAdministrationFormViewModelMapper;
  EventBus: IEventBus
);
begin

  inherited Create(EventBus);

  FClientIdentity := ClientIdentity;
  FSystemAdministrationService := SystemAdministrationService;
  FFormViewModelMapper := FormViewModelMapper;
  
end;

function TBaseSystemAdministrationFormController.CreateSectionFormRequestedEventFrom(
  SectionRecordViewModel: TSectionRecordViewModel
): TSectionFormRequestedEvent;
begin

  Result :=
    TSystemAdministrationPrivilegeFormRequestedEvent.Create(
      SectionRecordViewModel.Id
    );

end;

function TBaseSystemAdministrationFormController.CreateSectionStackedFormViewModel: TSectionStackedFormViewModel;
var SystemAdministrationPrivileges: TSystemAdministrationPrivileges;
begin

  SystemAdministrationPrivileges :=
    FSystemAdministrationService.GetAllSystemAdministrationPrivileges(FClientIdentity);

  try

    Result :=
      FFormViewModelMapper.MapSystemAdministrationFormViewModelFrom(
        SystemAdministrationPrivileges
      );
      
  finally

    FreeAndNil(SystemAdministrationPrivileges);
    
  end;

end;

function TBaseSystemAdministrationFormController.GetFormClass: TFormClass;
begin

  Result := TSystemAdministrationForm;

end;

end.
