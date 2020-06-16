unit VariantTypeUnit;

interface

uses

  Variants,
  Cloneable;

type

  TVariant = class sealed (TCloneable)

    strict private

      FValue: Variant;

    public

      constructor Create; overload;
      constructor Create(const AValue: Variant); overload;

      property Value: Variant read FValue write FValue;

      function Clone: TObject; override;
      
  end;

implementation


{ TVariant }

function TVariant.Clone: TObject;
begin

  Result := TVariant.Create(FValue);
  
end;

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
