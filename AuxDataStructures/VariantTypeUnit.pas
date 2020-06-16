unit VariantTypeUnit;

interface

uses Variants;

type

  TVariant = class sealed (TObject)

    strict private

      FValue: Variant;

    public

      constructor Create; overload;
      constructor Create(const AValue: Variant); overload;

      property Value: Variant read FValue write FValue;

  end;

implementation


{ TVariant }

constructor TVariant.Create(const AValue: Variant);
begin

  inherited Create;

  FValue := AValue;
  
end;

constructor TVariant.Create;
begin

  inherited;
  
end;

end.
