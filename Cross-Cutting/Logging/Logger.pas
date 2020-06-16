unit Logger;

interface

uses

  SysUtils,
  Classes;

type

  ILogger = interface

    procedure PrepareForLog(const Message: String);
    procedure LogMessage(const Message: String);
    procedure MakeLog;

  end;

implementation

end.
