unit ZeosPostgresTransactionUnit;

interface

uses PostgresTransactionUnit, ZDataset, Classes;

type

  TZeosPostgresTransaction = class (TPostgresTransaction)

    protected

      FQueryObject: TZQuery;

      procedure InternalStart; override;
      procedure InternalCommit; override;
      procedure InternalRollback; override;

      function GetDatabaseConnection: TComponent; override;
      procedure SetDatabaseConnection(Connection: TComponent); override;

    public

      destructor Destroy; override;

      constructor Create(Connection: TComponent);

  end;

implementation

uses ZConnection, SysUtils;

{ TZeosPostgresTransaction }

destructor TZeosPostgresTransaction.Destroy;
begin

  FreeAndNil(FQueryObject);
  inherited;

end;

function TZeosPostgresTransaction.GetDatabaseConnection: TComponent;
begin

  Result := FQueryObject.Connection as TZConnection;

end;

procedure TZeosPostgresTransaction.InternalCommit;
begin

  FQueryObject.SQL.Text := GetCommitTransactionText;
  FQueryObject.ExecSQL;

end;

constructor TZeosPostgresTransaction.Create(Connection: TComponent);
begin

  FQueryObject := TZQuery.Create(nil);

  inherited;

end;

procedure TZeosPostgresTransaction.InternalRollback;
begin

  FQueryObject.SQL.Text := GetRollbackTransactionText;
  FQueryObject.ExecSQL;

end;

procedure TZeosPostgresTransaction.InternalStart;
begin

  FQueryObject.SQL.Text := GetStartTransactionText;
  FQueryObject.ExecSQL;

end;

procedure TZeosPostgresTransaction.SetDatabaseConnection(
  Connection: TComponent
);
begin

  FQueryObject.Connection := Connection as TZConnection;

end;

end.
