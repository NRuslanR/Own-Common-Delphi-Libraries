unit LoggerAccessor;

interface

uses

  SysUtils,
  Classes,
  Logger;

type

  TLoggerAccessor = class

    private

      class var FCurrentLogger: ILogger;
      
      class function GetCurrentLogger: ILogger; static;
      class procedure SetCurrentLogger(const Value: ILogger); static;

    public

      class property CurrentLogger: ILogger
      read GetCurrentLogger write SetCurrentLogger;
      
  end;

implementation

{ TLoggerAccessor }

class function TLoggerAccessor.GetCurrentLogger: ILogger;
begin

  Result := FCurrentLogger;

end;

class procedure TLoggerAccessor.SetCurrentLogger(const Value: ILogger);
begin

  FCurrentLogger := Value;

end;

end.
