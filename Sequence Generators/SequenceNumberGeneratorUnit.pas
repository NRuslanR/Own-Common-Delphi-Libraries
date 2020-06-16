unit SequenceNumberGeneratorUnit;

interface

uses

  INumberGeneratorUnit;

type

  TSequenceNumberGenerator = class (TInterfacedObject, INumberGenerator)

    protected

      FCurrentNumber: LongInt;

      function InternalGetCurrentNumber: LongInt; virtual;
      function InternalGetNextNumber: LongInt; virtual;
      procedure InternalReset; virtual;

    public

      function GetCurrentNumber: LongInt;
      function GetNextNumber: LongInt;
      procedure Reset;

      property CurrentNumber: LongInt read GetCurrentNumber;

  end;
  
implementation

{ TSequenceNumberGenerator }

function TSequenceNumberGenerator.GetCurrentNumber: LongInt;
begin

  Result := InternalGetCurrentNumber;

end;

function TSequenceNumberGenerator.GetNextNumber: LongInt;
begin

  Result := InternalGetNextNumber;

end;

procedure TSequenceNumberGenerator.Reset;
begin

  InternalReset;
  
end;

function TSequenceNumberGenerator.InternalGetCurrentNumber: LongInt;
begin

  Result := FCurrentNumber;
  
end;

function TSequenceNumberGenerator.InternalGetNextNumber: LongInt;
begin

  Inc(FCurrentNumber);

  Result := FCurrentNumber;
  
end;

procedure TSequenceNumberGenerator.InternalReset;
begin

  FCurrentNumber := 0;
  
end;

end.
