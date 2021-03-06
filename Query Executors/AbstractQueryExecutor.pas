unit AbstractQueryExecutor;

interface

uses

  QueryExecutor,
  DataReader,
  SysUtils,
  Classes;

type

  TAbstractQueryExecutor = class abstract (TInterfacedObject, IQueryExecutor)

    protected

      function CreateQueryExecutingErrorFromException(const E: Exception): TQueryExecutingError; virtual;

    public

      function ExecuteSelectionQuery(
        const Query: String;
        Params: TQueryParams = nil
      ): IDataReader; virtual; abstract;

      procedure ExecuteSelectionQueryAsync(
        const Query: String;
        Params: TQueryParams;
        RelatedState: TObject = nil;
        OnSelectionQuerySuccessedEventHandler: TOnSelectionQuerySuccessedEventHandler = nil;
        OnSelectionQueryFailedEventHandler: TOnSelectionQueryFailedEventHandler = nil
      ); virtual; abstract;

      function ExecuteModificationQuery(
        const Query: String;
        Params: TQueryParams
      ): Integer; virtual; abstract;

      procedure ExecuteModificationQueryAsync(
        const Query: String;
        Params: TQueryParams;
        RelatedState: TObject = nil;
        OnModificationQuerySuccessedEventHandler: TOnModificationQuerySuccessedEventHandler = nil;
        OnModificationQueryFailedEventHandler: TOnModificationQueryFailedEventHandler = nil
      ); virtual; abstract;

      function GetSelf: TObject;

  end;
  
implementation

{ TAbstractQueryExecutor }

function TAbstractQueryExecutor.CreateQueryExecutingErrorFromException(
  const E: Exception): TQueryExecutingError;
begin

  Result := TQueryExecutingError.Create(E.Message);
  
end;

function TAbstractQueryExecutor.GetSelf: TObject;
begin

  Result := Self;
  
end;

end.
