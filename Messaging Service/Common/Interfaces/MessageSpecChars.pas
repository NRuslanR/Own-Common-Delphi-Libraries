unit MessageSpecChars;

interface

type

  IMessageSpecChars = interface

    function GetNewLine: String;
    function GetTabulation: String;

    property NewLine: String read GetNewLine;
    property Tabulation: String read GetTabulation;

  end;
  
implementation

end.
