unit MyClassUnit;

interface

uses SysUtils, Classes, FieldsEqualityImplementationUnit, MyNestedClassUnit;

type

  TEnum = (first, second, third);

  TMyClass = class (TFieldsEqualityImplementation)

    private

      FNumber: Integer;
      FName: String;
      FDate: TDateTime;
      FFloat: Single;
      FDouble: Extended;
      FGeneric: Variant;
      FEnum: TEnum;
      FObject: TObject;
      FNestedObject: TMyNestedClass;

    published

      property Number: Integer read FNumber write FNumber;
      property Name: String read FName write FName;
      property Date: TDateTime read FDate write FDate;
      property Float: Single read FFloat write FFloat;
      property Double: Extended read FDouble write FDouble;
      property Generic: Variant read FGeneric write FGeneric;
      property Enum: TEnum read FEnum write FEnum;
      property ZObject: TObject read FObject write FObject;
      property NestedObject: TMyNestedClass read FNestedObject write FNestedObject;

  end;

  TA = class

    public

      procedure M; virtual;

  end;

  TB = class (TA)

   public

    procedure M; override;

  end;

  TC = class (TB)

   public

    procedure M; override;

  end;

implementation

uses Windows;
{ TC }

procedure TC.M;
begin

  OutputDebugString(PChar(String(Self.ClassType.ClassName)));
  OutputDebugString(PChar(String(Self.ClassType.ClassParent.ClassName)));

  inherited;

end;

{ TB }

procedure TB.M;
begin

  OutputDebugString(PChar(String(Self.ClassType.ClassName)));
  OutputDebugString(PChar(String(Self.ClassParent.ClassName)));

  inherited;
  
end;

{ TA }

procedure TA.M;
begin

  OutputDebugString(PChar(String(Self.ClassName)));
  OutputDebugString(PChar(String(Self.ClassParent.ClassName)));

end;

end.
