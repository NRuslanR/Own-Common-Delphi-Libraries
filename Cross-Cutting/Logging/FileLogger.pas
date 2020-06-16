unit FileLogger;

interface

uses

  Logger,
  SysUtils,
  Classes;

type

  TFileLogger = class (TInterfacedObject, ILogger)

    protected

      FFilePath: String;
      FLogLines: TStrings;
      
      function GetFilePath: String;
      procedure SetFilePath(const Value: String);

      procedure Initialize(const FilePath: String = '');
      
    public

      destructor Destroy; override;
      constructor Create; overload;
      constructor Create(const FilePath: String); overload;

      procedure LogMessage(const Message: String);
      procedure PrepareForLog(const Message: String);
      procedure MakeLog;

    published

      property FilePath: String read GetFilePath write SetFilePath;
      
  end;

implementation

{ TFileLogger }

constructor TFileLogger.Create(const FilePath: String);
begin

  inherited Create;

  Initialize(FilePath);

end;

destructor TFileLogger.Destroy;
begin

  FreeAndNil(FLogLines);
  inherited;

end;

constructor TFileLogger.Create;
begin

  inherited;

  Initialize;
  
end;

function TFileLogger.GetFilePath: String;
begin

  Result := FFilePath;
  
end;

procedure TFileLogger.Initialize(const FilePath: String);
begin

  FLogLines := TStringList.Create;

  Self.FilePath := FilePath;
  
end;

procedure TFileLogger.LogMessage(const Message: String);
begin

  PrepareForLog(Message);
  MakeLog;
  
end;

procedure TFileLogger.MakeLog;
begin

  FLogLines.SaveToFile(FilePath);
  
end;

procedure TFileLogger.PrepareForLog(const Message: String);
begin

  FLogLines.Add(
    Format(
      '%d) [%s]: %s',
      [
        FLogLines.Count + 1,
        DateTimeToStr(Now),
        Message
      ]
    )
  );
  
end;

procedure TFileLogger.SetFilePath(const Value: String);
begin

  FFilePath := Value;
  
end;

end.
