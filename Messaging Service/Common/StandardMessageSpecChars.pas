unit StandardMessageSpecChars;

interface

uses

  MessageSpecChars,
  SysUtils,
  Classes;

type

  TStandardMessageSpecChars = class (TInterfacedObject, IMessageSpecChars)

    public

      function GetNewLine: String;
      function GetTabulation: String;

      property NewLine: String read GetNewLine;
      property Tabulation: String read GetTabulation;
    
  end;
  
implementation

{ TStandardMessageSpecChars }

function TStandardMessageSpecChars.GetNewLine: String;
begin

  Result := '\r\n';

end;

function TStandardMessageSpecChars.GetTabulation: String;
begin

  Result := '\t';
  
end;

end.
