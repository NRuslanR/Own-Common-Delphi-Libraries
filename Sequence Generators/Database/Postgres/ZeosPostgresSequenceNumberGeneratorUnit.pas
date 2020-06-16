unit ZeosPostgresSequenceNumberGeneratorUnit;

interface

uses

  INumberGeneratorUnit,
  DBSequenceNumberGeneratorUnit,
  SysUtils,
  Classes,
  ZConnection;

type

  TZeosPostgresSequenceNumberGenerator = class (TDBSequenceNumberGenerator)

    private

      FConnection: TZConnection;

    protected

      function GetConnection: TComponent; override;
      procedure SetConnection(Connection: TComponent); override;

      function LoadCurrentNumberFromDatabase: LongInt; override;
      procedure SaveCurrentNumberToDatabase(
        const PreviousNumber: Variant
      ); override;

  end;


implementation

uses

  AuxZeosFunctions,
  ZDataset,
  Variants;

{ TZeosPostgresSequenceNumberGenerator }

function TZeosPostgresSequenceNumberGenerator.GetConnection: TComponent;
begin

  Result := FConnection;

end;

procedure TZeosPostgresSequenceNumberGenerator.SetConnection(
  Connection: TComponent);
begin

  FConnection := Connection as TZConnection;

end;

function TZeosPostgresSequenceNumberGenerator.LoadCurrentNumberFromDatabase: LongInt;
var QueryText: String;
    CurrentNumberVariant: Variant;
begin

  QueryText :=
    Format(
      'SELECT %s FROM %s WHERE %s FOR UPDATE',
      [
        NumberFieldName,
        TableName,
        FilterStatement
      ]
    );

  try

    CurrentNumberVariant :=
      CreateAndExecuteQueryWithResults(
        FConnection,
        QueryText,
        [], [],
        [NumberFieldName]
      );

    if VarIsNull(CurrentNumberVariant) then
      raise TCurrentNumberNotFoundException.Create('');

    Result := CurrentNumberVariant[0];
    
  finally

  end;
  
end;

procedure TZeosPostgresSequenceNumberGenerator.SaveCurrentNumberToDatabase(
  const PreviousNumber: Variant
);
var QueryText: String;
begin

  QueryText :=
    Format(
      'UPDATE %s SET %s=%d',
      [
        TableName,
        NumberFieldName,
        FCurrentNumber
      ]
    );

  if not VarIsNull(PreviousNumber) then
    QueryText :=
      QueryText + Format(' WHERE %s=%d',
                         [NumberFieldName, Integer(PreviousNumber)]
                  );
  

  if FilterStatement <> '' then
    QueryText := QueryText + ' AND ' + FilterStatement;

  CreateAndExecuteQuery(
    FConnection,
    QueryText,
    [],
    [],
    False
  );

end;

end.
