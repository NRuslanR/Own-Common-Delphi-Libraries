unit EmailMessageSpecChars;

interface

uses

  MessageSpecChars,
  SysUtils,
  Classes;
  
type

  TEmailMessageSpecChars = class (TInterfacedObject, IMessageSpecChars)

    public

      function GetNewLine: String;
      function GetTabulation: String;

      property NewLine: String read GetNewLine;
      property Tabulation: String read GetTabulation;

  end;

implementation

{ TEmailMessageSpecChars }

function TEmailMessageSpecChars.GetNewLine: String;
begin

  Result := '<br>';
  
end;

function TEmailMessageSpecChars.GetTabulation: String;
begin

  Result := '&nbsp;&nbsp;&nbsp;&nbsp;';
  
end;

end.
