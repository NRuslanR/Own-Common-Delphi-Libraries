unit MyNestedClassUnit;

interface

uses FieldsEqualityImplementationUnit;

type

  TMyNestedClass = class (TFieldsEqualityImplementation)

    private

      FNestedName: String;
      FNestedDateTime: TDateTime;

    published

      property NestedName: string read FNestedName write FNestedName;
      property NestedDateTime: TDateTime read FNestedDateTime write FNestedDateTime;

  end;

implementation

end.
