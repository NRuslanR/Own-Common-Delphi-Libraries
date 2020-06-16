unit AbstractConnectionFactory;

interface

uses

  ConnectionFactory,
  ConnectionInfo,
  SysUtils,
  Classes;

type

  TAbstractConnectionFactory =
    class abstract (TInterfacedObject, IConnectionFactory)

      public

        function GetSelf: TObject;
        
        function CreateConnection(ConnectionInfo: TConnectionInfo): TObject;
          virtual; abstract;

    end;
    
implementation

{ TAbstratConnectionFactory }

function TAbstractConnectionFactory.GetSelf: TObject;
begin

  Result := Self;
  
end;

end.
