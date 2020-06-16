unit DatabaseTransactionUnit;

interface

uses ISessionUnit, Classes;

type

  TIsolationLevel = (

    ReadUncommitted,
    ReadCommitted,
    RepeatableRead,
    Serializable

  );

  TDatabaseTransaction = class abstract (TInterfacedObject, ISession)

    protected

      FIsStarted: Boolean;
      FIsolationLevel: TIsolationLevel;

      function GetDatabaseConnection: TComponent; virtual; abstract;
      procedure SetDatabaseConnection(Connection: TComponent); virtual; abstract;

      function GetSelf: TObject;

      function GetIsolationLevelText: String; virtual; abstract;
      function GetStartTransactionText: String; virtual; abstract;
      function GetCommitTransactionText: String; virtual; abstract;
      function GetRollbackTransactionText: String; virtual; abstract;

      procedure InternalStart; virtual; abstract;
      procedure InternalCommit; virtual; abstract;
      procedure InternalRollback; virtual; abstract;

      function InternalGetIsStarted: Boolean; virtual;
      procedure ResetIsStartedState; virtual;
      procedure SetIsStartedState; virtual;
      
    public

      constructor Create(Connection: TComponent);

      procedure Start;
      procedure Commit;
      procedure Rollback;

      function GetIsStarted: Boolean;
      
      property Connection: TComponent
      read GetDatabaseConnection write SetDatabaseConnection;

      property IsolationLevel: TIsolationLevel
      read FIsolationLevel write FIsolationLevel;

    published

      property IsStarted: Boolean read GetIsStarted;

  end;

implementation

{ TDatabaseTransaction }

constructor TDatabaseTransaction.Create(Connection: TComponent);
begin

  inherited Create;

  FIsolationLevel := Serializable;

  Self.Connection := Connection;

end;

function TDatabaseTransaction.GetIsStarted: Boolean;
begin

  Result := InternalGetIsStarted;
  
end;

function TDatabaseTransaction.GetSelf: TObject;
begin

  Result := Self;

end;

function TDatabaseTransaction.InternalGetIsStarted: Boolean;
begin

  Result := FIsStarted;
  
end;

procedure TDatabaseTransaction.ResetIsStartedState;
begin

  FIsStarted := False;
  
end;

procedure TDatabaseTransaction.Rollback;
begin

  InternalRollback;

  ResetIsStartedState;
  
end;

procedure TDatabaseTransaction.Commit;
begin

  InternalCommit;

  ResetIsStartedState;

end;

procedure TDatabaseTransaction.SetIsStartedState;
begin

  FIsStarted := True;
  
end;

procedure TDatabaseTransaction.Start;
begin

  InternalStart;

  SetIsStartedState;

end;

end.
