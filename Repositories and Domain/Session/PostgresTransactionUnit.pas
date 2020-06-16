unit PostgresTransactionUnit;

interface

uses DatabaseTransactionUnit, Classes;

type

  TPostgresTransaction = class abstract (TDatabaseTransaction)

    protected

      function GetIsolationLevelText: String; override;
      function GetStartTransactionText: String; override;
      function GetCommitTransactionText: String; override;
      function GetRollbackTransactionText: String; override;

    public

      constructor Create(Connection: TComponent);

  end;

implementation

{ TPostgresTransaction }

constructor TPostgresTransaction.Create(Connection: TComponent);
begin

  inherited;

  FIsolationLevel := ReadCommitted;

end;

function TPostgresTransaction.GetCommitTransactionText: String;
begin

  Result := 'COMMIT';

end;

function TPostgresTransaction.GetIsolationLevelText: String;
begin

  case FIsolationLevel of

    ReadUncommitted: Result := 'READ UNCOMMITTED';
    ReadCommitted: Result := 'READ COMMITTED';
    RepeatableRead: Result := 'REPEATABLE READ';
    Serializable: Result := 'SERIALIZABLE';

  end;

end;

function TPostgresTransaction.GetRollbackTransactionText: String;
begin

  Result := 'ROLLBACK';

end;

function TPostgresTransaction.GetStartTransactionText: String;
begin

  Result := 'START TRANSACTION ISOLATION LEVEL ' + GetIsolationLevelText;

end;

end.
