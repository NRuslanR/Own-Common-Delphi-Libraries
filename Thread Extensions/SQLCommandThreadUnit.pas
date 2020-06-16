unit SQLCommandThreadUnit;

interface

  uses Windows, SysUtils, Classes, DB, StrUtils, ZAbstractDataset,
       ZAbstractRODataset, DataSetOperationThreadUnit, ZDataset,
       ZConnection, VariantListUnit;

  type

    TSQLCommandThread = class(TDataSetOperationThread)

      strict protected

        function GetSQLCommandText: String;
        procedure SetSQLCOmmandText(const SQLCommandText: String);

        function GetConnection: TZConnection;
        procedure SetConnection(Connection: TZConnection);

      public

        constructor Create; overload;

        constructor Create(
          Connection: TZConnection;
          const SQLCommandText: String;
          ADataOperationType: TDataOperationType;
          ACreateSuspended: Boolean = False
        ); overload;

        constructor Create(
          Connection: TZConnection;
          const SQLCommandText: String;
          const ParamNames: Array of String;
          const ParamValues: Array of Variant;
          ADataOperationType: TDataOperationType;
          ACreateSuspended: Boolean = False
        ); overload;

        constructor Create(
          Connection: TZConnection;
          const SQLCommandText: String;
          const ParamNames: TStrings;
          const ParamValues: TVariantList;
          ADataOperationType: TDataOperationType;
          ACreateSuspended: Boolean = False
        ); overload;

        procedure SetParamValue(const Name: String; const Value: Variant);

        property Connection: TZConnection read GetConnection write SetConnection;
        property SQLCommandText: String read GetSQLCommandText write SetSQLCommandText;

    end;

implementation

uses AuxZeosFunctions;

{ TSQLCommandThread }

constructor TSQLCommandThread.Create(
  Connection: TZConnection; const SQLCommandText: String;
  ADataOperationType: TDataOperationType; ACreateSuspended: Boolean);
var LDataSet: TZQuery;
begin

  LDataSet := TZQuery.Create(nil);
  LDataSet.Connection := Connection;
  LDataSet.SQL.Text := SQLCommandText;

  FreeDataSetOnFail := True;
  FreeDataSetOnCancellation := True;
  FreeDataSetOnSuccess := True;

  inherited Create(LDataSet, ADataOperationType, ACreateSuspended);

end;

constructor TSQLCommandThread.Create(Connection: TZConnection;
  const SQLCommandText: String;
  const ParamNames: array of String;
  const ParamValues: array of Variant;
  ADataOperationType: TDataOperationType;
  ACreateSuspended: Boolean
);
begin

  Create(Connection, SQLCommandText, ADataOperationType, ACreateSuspended);

  SetParamValues(FDataSet, ParamNames, ParamValues);

end;

constructor TSQLCommandThread.Create;
begin

  inherited Create(True);

end;

constructor TSQLCommandThread.Create(
  Connection: TZConnection;
  const SQLCommandText: String;
  const ParamNames: TStrings;
  const ParamValues: TVariantList;
  ADataOperationType: TDataOperationType;
  ACreateSuspended: Boolean
);
begin

  Create(Connection, SQLCommandText, ADataOperationType, ACreateSuspended);

  SetParamValues(FDataSet, ParamNames, ParamValues);
  
end;

function TSQLCommandThread.GetConnection: TZConnection;
begin

  Result := FDataSet.Connection as TZConnection;

end;

function TSQLCommandThread.GetSQLCommandText: String;
begin

  Result := TZQuery(FDataSet).SQL.Text;

end;

procedure TSQLCommandThread.SetConnection(Connection: TZConnection);
begin

  FDataSet.Connection := Connection;
  
end;

procedure TSQLCommandThread.SetParamValue(const Name: String;
  const Value: Variant);
begin

  FDataSet.ParamByName(Name).Value := Value;
  
end;

procedure TSQLCommandThread.SetSQLCOmmandText(const SQLCommandText: String);
begin

  TZQuery(FDataSet).SQL.Text := SQLCommandText;

end;

end.
