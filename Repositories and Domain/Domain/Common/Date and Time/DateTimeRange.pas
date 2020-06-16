unit DateTimeRange;

interface

uses

  DomainObjectValueUnit,
  SysUtils,
  Classes;

type

  TDateTimeRange = class (TDomainObjectValue)

    protected

      FStartDateTime: TDateTime;
      FEndDateTime: TDateTime;

    public

      constructor Create; overload; virtual;
      constructor Create(
        const StartDateTime: TDateTime;
        const EndDateTime: TDateTime
      ); overload;

      function HasIncludes(const DateTime: TDateTime): Boolean;

    published

      property StartDateTime: TDateTime
      read FStartDateTime write FStartDateTime;

      property EndDateTime: TDateTime
      read FEndDateTime write FEndDateTime;
      
  end;

implementation

uses

  DateUtils,
  Variants,
  AuxDebugFunctionsUnit;
  
{ TDateTimeRange }

constructor TDateTimeRange.Create;
begin

  inherited;

end;

constructor TDateTimeRange.Create(const StartDateTime, EndDateTime: TDateTime);
begin

  inherited Create;

  FStartDateTime := StartDateTime;
  FEndDateTime := EndDateTime;
  
end;

function TDateTimeRange.HasIncludes(const DateTime: TDateTime): Boolean;
var CheckableDate: TDateTime;
begin

  CheckableDate := DateOf(DateTime);
  
  Result :=
    (FStartDateTime <= CheckableDate) and
    (CheckableDate <= FEndDateTime);

end;

end.
