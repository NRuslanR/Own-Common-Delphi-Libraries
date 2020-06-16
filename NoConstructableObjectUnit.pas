unit NoConstructableObjectUnit;

interface

uses SysUtils, Classes;

type

  TNoConstructableObject = class

    strict private

      constructor Create;

  end;

implementation

{ TNoConstructableObject }

constructor TNoConstructableObject.Create;
begin

  inherited;

end;

end.
