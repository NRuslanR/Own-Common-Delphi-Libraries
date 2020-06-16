unit TimeFrame;

interface

uses

  DomainObjectValueUnit,
  DateTimeRange,
  SysUtils,
  Classes;

type

  TTimeFrame = class (TDomainObjectValue)

    protected

      FDateTimeRange: TDateTimeRange;

      function GetDeadline: TDateTime;
      function GetStart: TDateTime;

      procedure CreateDateTimeRange; overload;

      procedure CreateDateTimeRange(
        const StartDateTime: TDateTime;
        const EndDateTime: TDateTime
      ); overload;

      procedure EnsureThatStartAndDeadlineSpecifyCorrectInterval(
        const Start, Deadline: TDateTime
      );

      procedure SetDeadline(const Value: TDateTime);
      procedure SetStart(const Value: TDateTime);
      
    public

      destructor Destroy; override;
      constructor Create; overload; virtual;
      constructor Create(
        const Start: TDateTime;
        const Deadline: TDateTime
      ); overload;

      function IsExpired: Boolean;
      function IsExpiring: Boolean;

      procedure SetStartAndDeadline(const Start, Deadline: TDateTime);

    published

      property Start: TDateTime read GetStart write SetStart;
      property Deadline: TDateTime read GetDeadline write SetDeadline;

  end;

implementation

uses

  AuxDebugFunctionsUnit;

{ TTimeFrame }

constructor TTimeFrame.Create(const Start, Deadline: TDateTime);
begin

  inherited Create;

  CreateDateTimeRange;
  SetStartAndDeadline(Start, Deadline);
  
end;

procedure TTimeFrame.CreateDateTimeRange(const StartDateTime,
  EndDateTime: TDateTime);
begin
  
  FDateTimeRange := TDateTimeRange.Create(StartDateTime, EndDateTime);

end;

destructor TTimeFrame.Destroy;
begin

  FreeAndNil(FDateTimeRange);
  inherited;

end;

procedure TTimeFrame.EnsureThatStartAndDeadlineSpecifyCorrectInterval(
  const Start, Deadline: TDateTime);
begin

  if not InvariantsComplianceRequested then
    Exit;
  
  if Start > Deadline then
    raise Exception.CreateFmt(
            'Дата начала %s и конца %s определяют ' +
            'истекший промежуток времени',
            [
              Start,
              Deadline
            ]
          );
          
end;

procedure TTimeFrame.CreateDateTimeRange;
begin

  CreateDateTimeRange(Now, Now);
  
end;

constructor TTimeFrame.Create;
begin

  inherited;

  CreateDateTimeRange;

end;

function TTimeFrame.GetDeadline: TDateTime;
begin

  Result := FDateTimeRange.EndDateTime;

end;

function TTimeFrame.GetStart: TDateTime;
begin

  Result := FDateTimeRange.StartDateTime;

end;

function TTimeFrame.IsExpired: Boolean;
begin

  Result := Now > Deadline;
  
end;

function TTimeFrame.IsExpiring: Boolean;
begin

  Result := FDateTimeRange.HasIncludes(Now);
  
end;

procedure TTimeFrame.SetDeadline(const Value: TDateTime);
begin

  SetStartAndDeadline(Start, Value);
  
end;

procedure TTimeFrame.SetStart(const Value: TDateTime);
begin

  SetStartAndDeadline(Value, Deadline);
  
end;

procedure TTimeFrame.SetStartAndDeadline(const Start, Deadline: TDateTime);
begin

  EnsureThatStartAndDeadlineSpecifyCorrectInterval(Start, Deadline);

  FDateTimeRange.StartDateTime := Start;
  FDateTimeRange.EndDateTime := Deadline;
  
end;

end.
