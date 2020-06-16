unit INumberGeneratorUnit;

interface

uses

  SysUtils;

type

  TCurrentNumberNotFoundException = class (Exception)

  end;
  
  INumberGenerator = interface

    function GetCurrentNumber: LongInt;
    function GetNextNumber: LongInt;
    procedure Reset;

    property CurrentNumber: LongInt read GetCurrentNumber;
    
  end;

implementation

end.
