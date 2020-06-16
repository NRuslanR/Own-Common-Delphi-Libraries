unit AuxiliaryFunctionsForExceptionHandlingUnit;

interface

uses SysUtils;

function CloneException(Other: Exception): Exception;

implementation

function CloneException(Other: Exception): Exception;
begin

  Result := Exception(Other.NewInstance);
  Result.Message := Other.Message;
  Result.HelpContext := Other.HelpContext;
  
end;

end.
