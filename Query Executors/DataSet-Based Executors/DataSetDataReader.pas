unit DataSetDataReader;

interface

uses

  AbstractDataReader,
  SysUtils,
  Classes,
  ZDataset,
  ZConnection,
  DB,
  AuxZeosFunctions;

type

  TDataSetDataReader = class (TAbstractDataReader)

    protected

      FDataSet: TDataSet;
      FIsFirstRecordPositionedEarlier: Boolean;

      procedure SetDataSet(Value: TDataSet); virtual;
      
    public

      destructor Destroy; override;
      constructor Create(DataSet: TDataSet);
      
      procedure Restart; override;
    
      function Next: Boolean; override;

      function GetRecordCount: Integer; override;
      function GetValue(const FieldName: String): Variant; override;
      function GetValueAsString(const FieldName: String): String; override;
      function GetValueAsInteger(const FieldName: String): Integer; override;
      function GetValueAsFloat(const FieldName: String): Double; override;
      function GetValueAsDateTime(const FieldName: String): TDateTime; override;
      function GetValueAsBoolean(const FieldName: String): Boolean; override;

      property Items[const FieldName: String]: Variant
      read GetValue; default;

      property DataSet: TDataSet
      read FDataSet write SetDataSet;

      function ToDataSet: TDataSet; override;
    
  end;
  
implementation

{ TDataSetDataReader }

constructor TDataSetDataReader.Create(DataSet: TDataSet);
begin

  inherited Create;

  Self.DataSet := DataSet;

  FIsFirstRecordPositionedEarlier := False;
  
end;

destructor TDataSetDataReader.Destroy;
begin

  FreeAndNil(FDataSet);
  inherited;

end;

function TDataSetDataReader.GetRecordCount: Integer;
begin

  Result := FDataSet.RecordCount;
  
end;

function TDataSetDataReader.GetValue(const FieldName: String): Variant;
begin

  Result := FDataSet.FieldByName(FieldName).AsVariant;
  
end;

function TDataSetDataReader.GetValueAsBoolean(
  const FieldName: String): Boolean;
begin

  Result := FDataSet.FieldByName(FieldName).AsBoolean;
  
end;

function TDataSetDataReader.GetValueAsDateTime(
  const FieldName: String): TDateTime;
begin

  Result := FDataSet.FieldByName(FieldName).AsDateTime;
end;

function TDataSetDataReader.GetValueAsFloat(
  const FieldName: String): Double;
begin

  Result := FDataSet.FieldByName(FieldName).AsFloat;
  
end;

function TDataSetDataReader.GetValueAsInteger(
  const FieldName: String): Integer;
begin

  Result := FDataSet.FieldByName(FieldName).AsInteger;
  
end;

function TDataSetDataReader.GetValueAsString(
  const FieldName: String): String;
begin

  Result := FDataSet.FieldByName(FieldName).AsString;
  
end;

function TDataSetDataReader.Next: Boolean;
begin

  if FIsFirstRecordPositionedEarlier then begin

    FDataSet.Next;

    Result := not FDataSet.Eof;

  end

  else begin

    Result := not FDataSet.Eof;

    FDataSet.First;

    FIsFirstRecordPositionedEarlier := True;
    
  end;
  
end;

procedure TDataSetDataReader.Restart;
begin

  FDataSet.First;
  
end;

procedure TDataSetDataReader.SetDataSet(Value: TDataSet);
begin

  FreeAndNil(FDataSet);
  
  FDataSet := Value;


end;

function TDataSetDataReader.ToDataSet: TDataSet;
begin

  Result := FDataSet;

  FDataSet := nil;
  
end;

end.
