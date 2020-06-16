unit AuxiliaryDateFunctions;

interface

uses

  SysUtils;

function IsDateTimeValid(const DateTime: TDateTime): Boolean;

implementation

uses

  DateUtils;
  
function IsDateTimeValid(const DateTime: TDateTime): Boolean;
var Year, Month, Day, Hour, Minute, Second, Millisecond: Word;
begin

  DecodeDateTime(
    DateTime, Year, Month, Day, Hour, Minute, Second, Millisecond
  );

  Result :=
    IsValidDateTime(Year, Month, Day, Hour, Minute, Second, Millisecond);

end;  

end.
