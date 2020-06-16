unit StubLogger;

interface

uses

  SysUtils,
  Classes,
  Logger;

type

  TStubLogger = class (TInterfacedObject, ILogger)

    public

      procedure PrepareForLog(const Message: String);
      procedure LogMessage(const Message: String);
      procedure MakeLog;

  end;
  
implementation


{ TStubLogger }

procedure TStubLogger.LogMessage(const Message: String);
begin

end;

procedure TStubLogger.MakeLog;
begin

end;

procedure TStubLogger.PrepareForLog(const Message: String);
begin

end;

end.
