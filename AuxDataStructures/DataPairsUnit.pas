unit DataPairsUnit;

interface

  type

    TIntegerPairRec = record
      First: integer;
      Second: integer;
    end;

    TIntegerPair = class
      strict private

        FFirst: integer;
        FSecond: integer;

      public
        constructor Create(First, Second: integer);

        property First: integer read FFirst write FFirst;
        property Second: integer read FSecond write FSecond;
    end;

implementation

{ TIntegerPair }

constructor TIntegerPair.Create(First, Second: integer);
begin
  inherited Create;

  FFirst := First;
  FSecond := Second;
end;

end.
