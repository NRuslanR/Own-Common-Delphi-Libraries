program SystemAuthentificationFormProject;

uses
  Forms,
  unSystemAuthentificationForm in 'unSystemAuthentificationForm.pas' {SystemAuthentificationForm},
  unDatabaseAuthentificationForm in 'unDatabaseAuthentificationForm.pas' {DatabaseAuthentificationForm},
  unExtendedDatabaseAuthentificationForm in 'unExtendedDatabaseAuthentificationForm.pas' {ExtendedDatabaseAuthentificationForm},
  SystemAuthentificationFormViewModel in 'View Models\SystemAuthentificationFormViewModel.pas',
  DatabaseAuthentificationFormViewModel in 'View Models\DatabaseAuthentificationFormViewModel.pas',
  ExtendedDatabaseAuthentificationFormViewModel in 'View Models\ExtendedDatabaseAuthentificationFormViewModel.pas',
  SystemAuthentificationFormController in 'Controllers\SystemAuthentificationFormController.pas',
  SystemAuthentificationFormControllerEvents in 'Controllers\SystemAuthentificationFormControllerEvents.pas',
  DatabaseAuthentificationFormController in 'Controllers\DatabaseAuthentificationFormController.pas',
  DatabaseServerAuthentificationService in '..\DDD\App Services\Authentification\DatabaseServerAuthentificationService.pas',
  DatabaseServerRoleAuthentificationService in '..\DDD\App Services\Authentification\DatabaseServerRoleAuthentificationService.pas',
  SystemAuthentificationService in '..\DDD\App Services\Authentification\SystemAuthentificationService.pas',
  AbstractSystemAuthentificationFormViewModelPropertiesStorage in 'Properties Storages\AbstractSystemAuthentificationFormViewModelPropertiesStorage.pas',
  SystemAuthentificationFormViewModelPropertiesINIFile in 'Properties Storages\SystemAuthentificationFormViewModelPropertiesINIFile.pas',
  DatabaseAuthentificationFormViewModelPropertiesINIFile in 'Properties Storages\DatabaseAuthentificationFormViewModelPropertiesINIFile.pas',
  ExtendedDatabaseAuthentificationFormViewModelPropertiesINIFile in 'Properties Storages\ExtendedDatabaseAuthentificationFormViewModelPropertiesINIFile.pas',
  ExtendedDatabaseAuthentificationFormController in 'Controllers\ExtendedDatabaseAuthentificationFormController.pas',
  TestExtendedDatabaseAuthentificationFormController in 'Controllers\TestExtendedDatabaseAuthentificationFormController.pas',
  unControllersTestForm in 'Tests\unControllersTestForm.pas' {ControllersTestForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TControllersTestForm, ControllersTestForm);
  Application.Run;
end.
