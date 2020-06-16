unit ApplicationBuilder;

interface

uses

  IGetSelfUnit,
  Application,
  ClientAccount;
  
type

  IApplicationBuilder = interface (IGetSelf)

    function Build: IApplication;

  end;
  
implementation

end.
