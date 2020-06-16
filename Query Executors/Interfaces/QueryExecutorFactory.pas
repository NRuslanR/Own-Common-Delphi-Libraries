unit QueryExecutorFactory;

interface

uses

  ConnectionInfo,
  QueryExecutor;
  
type
  
  IQueryExecutorFactory = interface

    function CreateQueryExecutor(ConnectionInfo: TConnectionInfo): IQueryExecutor; overload;
    function CreateQueryExecutor(Connection: TObject): IQueryExecutor; overload;

  end;
  
implementation

end.
