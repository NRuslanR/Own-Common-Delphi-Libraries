unit DatabaseServerRoleAuthentificationService;

interface

uses

  SystemAuthentificationService,
  DatabaseServerAuthentificationService,
  DataReader,
  QueryExecutorFactory,
  ClientAccount,
  SysUtils,
  Classes;

type

  TUserRoleAccountDbSchemaData = class (TUserAccountDbSchemaData)

    public

      RoleTableName: String;

      RoleIdColumnName: String;
      RoleIdForeignKeyColumnName: String;
      RoleFriendlyNameColumnName: String;
      
  end;

  IDatabaseServerRoleAuthentificationService =
    interface (IDatabaseServerAuthentificationService)
    ['{AA78590B-E1F7-4367-BD59-BA192E08E62A}']
    
    end;
    
  TDatabaseServerRoleAuthentificationService =
    class (
      TDatabaseServerAuthentificationService,
      IDatabaseServerRoleAuthentificationService,
      ISystemAuthentificationService
    )

      protected

        function PrepareFetchingUserAccountInfoQuery(
          UserAccountDbSchemaData: TUserAccountDbSchemaData
        ): String; override;

      protected

        function GetUserAccountClass: TUserAccountClass; override;
      
        procedure FillUserAccount(
          UserAccount: TUserAccount;
          DataReader: IDataReader;
          UserAccountDbSchemaData: TUserAccountDbSchemaData
        ); override;

      public

        constructor Create(
          UserRoleAccountDbSchemaData: TUserRoleAccountDbSchemaData;
          QueryExecutorFactory: IQueryExecutorFactory
        );

    end;
  

implementation

{ TDatabaseServerRoleAuthentificationService }

constructor TDatabaseServerRoleAuthentificationService.Create(
  UserRoleAccountDbSchemaData: TUserRoleAccountDbSchemaData;
  QueryExecutorFactory: IQueryExecutorFactory);
begin

  inherited Create(UserRoleAccountDbSchemaData, QueryExecutorFactory);
  
end;

procedure TDatabaseServerRoleAuthentificationService.FillUserAccount(
  UserAccount: TUserAccount;
  DataReader: IDataReader;
  UserAccountDbSchemaData: TUserAccountDbSchemaData
);
begin

  inherited;

  with
    UserAccount as TUserRoleAccount,
    UserAccountDbSchemaData as TUserRoleAccountDbSchemaData
  do begin

    RoleIdentity := DataReader[RoleIdColumnName];
    RoleFriendlyName := DataReader[RoleFriendlyNameColumnName];
    
  end;

end;

function TDatabaseServerRoleAuthentificationService.
  GetUserAccountClass: TUserAccountClass;
begin

  Result := TUserRoleAccount;
  
end;

function TDatabaseServerRoleAuthentificationService.
  PrepareFetchingUserAccountInfoQuery(
    UserAccountDbSchemaData: TUserAccountDbSchemaData
  ): String;
var UserRoleAccountDbSchemaData: TUserRoleAccountDbSchemaData;
begin

  UserRoleAccountDbSchemaData :=
    UserAccountDbSchemaData as TUserRoleAccountDbSchemaData;

  Result :=
    Format(
      'SELECT ' +
      'A.%s,A.%s,A.%s,B.%s,B.%s ' +
      'FROM %s A ' +
      'JOIN %s B ON B.%s=A.%s ' +
      'WHERE A.%s=:p%s',
      [
        UserRoleAccountDbSchemaData.UserIdColumnName,
        UserRoleAccountDbSchemaData.UserLoginColumnName,
        UserRoleAccountDbSchemaData.UserFriendlyNameColumnName,
        UserRoleAccountDbSchemaData.RoleIdColumnName,
        UserRoleAccountDbSchemaData.RoleFriendlyNameColumnName,

        UserRoleAccountDbSchemaData.TableName,
        UserRoleAccountDbSchemaData.RoleTableName,

        UserRoleAccountDbSchemaData.RoleIdColumnName,
        UserRoleAccountDbSchemaData.RoleIdForeignKeyColumnName,

        UserRoleAccountDbSchemaData.UserLoginColumnName,
        UserRoleAccountDbSchemaData.UserLoginColumnName
      ]
    );

end;

end.
