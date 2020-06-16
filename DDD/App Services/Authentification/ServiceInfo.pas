unit ServiceInfo;

interface

type

  TServiceInfo = class

  end;

  TServiceInfoClass = class of TServiceInfo;
  
  THostProcessInfo = class (TServiceInfo)

    public

      Host: String;
      Port: Integer;

  end;

  TDatabaseServerInfo = class (THostProcessInfo)

    public

      Database: String;
      
  end;
  
implementation

end.
