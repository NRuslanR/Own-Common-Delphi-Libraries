unit ZQueryExecutorFactory;

interface

uses

  ConnectionInfo,
  QueryExecutorFactory,
  AbstractQueryExecutorFactory,
  ConnectionFactory,
  ZConnectionFactory,
  QueryExecutor,
  SysUtils,
  Classes;

type

  TZQueryExecutorFactory = class (TAbstractQueryExecutorFactory)

    private
    
      procedure ValidateConnectionFactoryType(
        ConnectionFactory: IConnectionFactory
      );

    public

      constructor Create(
        ConnectionFactory: IConnectionFactory
      ); overload;

      function CreateQueryExecutor(ConnectionInfo: TConnectionInfo): IQueryExecutor; overload; override;
      function CreateQueryExecutor(Connection: TObject): IQueryExecutor; overload; override;

  end;
  
implementation

uses

  ZConnection,
  ZQueryExecutor,
  AuxZeosFunctions;
  
{ TZQueryExecutorFactory }

constructor TZQueryExecutorFactory.Create(
  ConnectionFactory: IConnectionFactory
);
begin

  inherited Create(ConnectionFactory);

end;

function TZQueryExecutorFactory.CreateQueryExecutor(
  Connection: TObject): IQueryExecutor;
begin

  if not (Connection is TZConnection)
  then begin

    raise Exception.CreateFmt(
      'Connection'' type isn''t a %s',
      [
        TZConnection.ClassName
      ]
    );
    
  end;

  Result := TZQueryExecutor.Create(TZConnection(Connection));

end;

function TZQueryExecutorFactory.CreateQueryExecutor(
  ConnectionInfo: TConnectionInfo
): IQueryExecutor;
var ZConnection: TZConnection;
begin

  ZConnection :=
    TZConnection(FConnectionFactory.CreateConnection(ConnectionInfo));

  Result := CreateQueryExecutor(ZConnection);
  
end;

procedure TZQueryExecutorFactory.ValidateConnectionFactoryType(
  ConnectionFactory: IConnectionFactory);
begin

  if not (ConnectionFactory.Self is TZConnectionFactory)
  then begin

    raise Exception.CreateFmt(
      'Type of connection factory isn''t a %s',
      [
        TZConnectionFactory.ClassName
      ]
    );
    
  end;
  
end;

end.
