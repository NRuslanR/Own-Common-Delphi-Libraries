unit AuxVariantFunctions;

interface

uses

  Variants;

function VarIsNullOrEmpty(const Value: Variant): Boolean;

implementation

function VarIsNullOrEmpty(const Value: Variant): Boolean;
begin

  Result := VarIsNull(Value) or VarIsEmpty(Value);
  
end;

end.
