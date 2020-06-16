unit DBSequenceNumberGeneratorUnit;

interface

uses

  SequenceNumberGeneratorUnit,
  SysUtils,
  Classes;

type

  TDBSequenceNumberGenerator = class (TSequenceNumberGenerator)

    protected

      FNumberFieldName: String;
      FTableName: String;
      FFilterStatement: String;

      function InternalGetNextNumber: LongInt; override;
      procedure InternalReset; override;

      function GetConnection: TComponent; virtual; abstract;
      procedure SetConnection(Connection: TComponent); virtual; abstract;

      function LoadCurrentNumberFromDatabase: LongInt; virtual; abstract;
      procedure SaveCurrentNumberToDatabase(
        const PreviousNumber: Variant
      ); virtual; abstract;

    public

      constructor Create(Connection: TComponent);

      property Connection: TComponent
      read GetConnection write SetConnection;

      property NumberFieldName: String
      read FNumberFieldName write FNumberFieldName;

      property TableName: String
      read FTableName write FTableName;

      property FilterStatement: String
      read FFilterStatement write FFilterStatement;
      
  end;

implementation

uses

  Variants;
  
{ TDBSequenceNumberGenerator }

constructor TDBSequenceNumberGenerator.Create(Connection: TComponent);
begin

  inherited Create;

  Self.Connection := Connection;
  
end;

function TDBSequenceNumberGenerator.InternalGetNextNumber: LongInt;
var PreviousNumber: LongInt;
begin

  FCurrentNumber := LoadCurrentNumberFromDatabase;

  PreviousNumber := FCurrentNumber;
  
  Inc(FCurrentNumber);

  SaveCurrentNumberToDatabase(PreviousNumber);

  Result := FCurrentNumber;
  
end;

procedure TDBSequenceNumberGenerator.InternalReset;
begin

  inherited;

  SaveCurrentNumberToDatabase(Null);
  
end;

end.
