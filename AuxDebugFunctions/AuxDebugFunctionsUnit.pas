unit AuxDebugFunctionsUnit;

interface

uses Windows, Variants;

procedure DebugOutput(const Data: Variant);

implementation

uses SysUtils;

procedure DebugOutput(const Data: Variant);
var I, VarArrayElementCount: Integer;
    ArrayString: String;
    VarArrayElement: Variant;
begin

  if not VarIsArray(Data) then
    OutputDebugString(PChar(VarToStr(Data)))

  else begin

    VarArrayElementCount := VarArrayHighBound(Data, 1);

    ArrayString := '';

    for I := 0 to VarArrayElementCount do begin

      VarArrayElement := Data[I];

      if ArrayString = '' then
        ArrayString := VarArrayElement

      else ArrayString := ArrayString + ', ' + VarToStr(VarArrayElement);

    end;

    ArrayString := '[' + ArrayString + ']';

    OutputDebugString(PChar(ArrayString));

  end;

end;

end.
