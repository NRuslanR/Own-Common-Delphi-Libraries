unit ConnectionFactory;

interface

uses

  IGetSelfUnit,
  ConnectionInfo,
  Classes;

type

  IConnectionFactory = interface (IGetSelf)

    function CreateConnection(ConnectionInfo: TConnectionInfo): TObject;
    
  end;

implementation

end.
