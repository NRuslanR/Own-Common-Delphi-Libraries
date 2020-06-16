unit StringRefUnit;

interface

type
  TStringRef = class

    strict private

      FString: String;

    public

      constructor Create(Source: String);

      property StoredString: String read FString write FString;

  end;

implementation

{ TStringRef }

constructor TStringRef.Create(Source: String);
begin

  FString := Source;

end;

end.
