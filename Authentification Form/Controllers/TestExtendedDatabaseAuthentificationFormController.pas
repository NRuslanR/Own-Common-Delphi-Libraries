unit TestExtendedDatabaseAuthentificationFormController;

interface

uses

  ExtendedDatabaseAuthentificationFormController,
  ExtendedDatabaseAuthentificationFormViewModelPropertiesINIFile,
  SimpleEventBus,
  DatabaseServerRoleAuthentificationService,
  SysUtils,
  Classes;

type

  TTestExtendedDatabaseAuthentificationFormController =
    class (TExtendedDatabaseAuthentificationFormController)

      public

        constructor Create;
        
    end;
  
implementation

uses

  SystemAuthentificationService,
  AuxSystemFunctionsUnit,
  ZQueryExecutorFactory;
  
{ TTestExtendedDatabaseAuthentificationFormController }

constructor TTestExtendedDatabaseAuthentificationFormController.Create;
var UserRoleAccountDbSchemaData: TUserRoleAccountDbSchemaData;
    ZQueryExecutorFactory: TZQueryExecutorFactory;
    ViewModelPropertiesINIFile: TExtendedDatabaseAuthentificationFormViewModelPropertiesINIFile;
    PropertiesINIFilePath: String;
    AuthentificationService: ISystemAuthentificationService;
    DbAuthService: IDatabaseServerRoleAuthentificationService;
begin

  UserRoleAccountDbSchemaData := TUserRoleAccountDbSchemaData.Create;

  UserRoleAccountDbSchemaData.RoleTableName := 'fca.roles';
  UserRoleAccountDbSchemaData.RoleIdColumnName := 'role_id';
  UserRoleAccountDbSchemaData.RoleIdForeignKeyColumnName := 'employee_role_id';
  UserRoleAccountDbSchemaData.RoleFriendlyNameColumnName := 'display_name';
  UserRoleAccountDbSchemaData.TableName := 'fca.v_employees';
  UserRoleAccountDbSchemaData.UserIdColumnName := 'employee_id';
  UserRoleAccountDbSchemaData.UserLoginColumnName := 'login';
  UserRoleAccountDbSchemaData.UserFriendlyNameColumnName := 'full_name';

  ZQueryExecutorFactory :=
    TZQueryExecutorFactory.Create(
      'postgresql-9',
      'WIN1251'
    );

  PropertiesINIFilePath :=
    IncludeTrailingPathDelimiter(
      GetAppLocalDataFolderPath(
        GetApplicationExeNameWithoutExtension,
        CreateFolderIfNotExists
      )
    ) + 'settings.ini';
      
  ViewModelPropertiesINIFile :=
    TExtendedDatabaseAuthentificationFormViewModelPropertiesINIFile.Create(
      PropertiesINIFilePath
    );

  AuthentificationService :=
    TDatabaseServerRoleAuthentificationService.Create(
      UserRoleAccountDbSchemaData,
      ZQueryExecutorFactory
    );

  AuthentificationService.QueryInterface(
    IDatabaseServerRoleAuthentificationService,
    DbAuthService
  );

  inherited Create(
    TSimpleEventBus.Create,
    DbAuthService,
    ViewModelPropertiesINIFile
  );

end;

end.
