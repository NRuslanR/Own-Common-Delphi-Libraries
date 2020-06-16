unit AuxAsyncZeosFunctions;

interface

uses ZConnection, ZDataset, DataSetOperationThreadUnit, VariantListUnit, SysUtils, Classes;

{
  Назначение:
    Асинхронное выполнение запроса к БД

  Параметры:
    DBConnection - соединение с БД,
    QueryText - текст запроса,
    ParamNames - перечень наименований параметров,
    ParamValues - перечень соответствующих значений параметров,
    IsSelect - признак операции
      (True - запрос на выборку данных,
       False - запрос на изменение данных (вставка, обновление, удаление),

    DataOperationSuccessEventHandler -
      объектная функция, вызываемая после успешного выполнения запроса,
      сигнатура procedure(Sender: TObject; DataSet: TDataSet) of object,
        Sender - объект потока, который выполнял запрос,
        DataSet - набор данных, который использовался для
          выполнения запроса


    DataOperationErrorEventHandler -
      объектная функция, вызываемая после возникновения ошибки
      во время выполнения запроса,
      сигнатура procedure(Sender: TObject;
                          DataSet: TDataSet;
                          const Error: Exception
                         ) of object,
        Sender - объект потока, который выполнял запрос,
        DataSet - набор данных, который использовался для
          выполнения запроса,
        Error - объект ошибки, возникшей во время
          выполнения запроса
}
procedure ExecuteQueryAsync(
  DBConnection: TZConnection;
  const QueryText: String;
  const ParamNames: Array of String;
  const ParamValues: Array of Variant;
  const IsSelect: Boolean = True;
  const DataOperationSuccessEventHandler: TOnDataOperationSuccessEvent = nil;
  const DataOperationErrorEventHandler: TOnDataOperationErrorOccurredEvent = nil;
  ArbitraryState: TObject = nil
); overload;

procedure ExecuteQueryAsync(
  DBConnection: TZConnection;
  const QueryText: String;
  const ParamNames: TStrings;
  const ParamValues: TVariantList;
  const IsSelect: Boolean = True;
  const DataOperationSuccessEventHandler: TOnDataOperationSuccessEvent = nil;
  const DataOperationErrorEventHandler: TOnDataOperationErrorOccurredEvent = nil;
  ArbitraryState: TObject = nil
); overload;

procedure ExecuteQueryAsync(
  DBConnection: TZConnection;
  const QueryText: String;
  const IsSelect: Boolean = True;
  const DataOperationSuccessEventHandler: TOnDataOperationSuccessEvent = nil;
  const DataOperationErrorEventHandler: TOnDataOperationErrorOccurredEvent = nil;
  ArbitraryState: TObject = nil
); overload;

{
  Назначение:
    Асинхронное выполнение запроса к БД

  Параметры:
    QueryObject - объект запроса с установленными
    текстом запроса и, возможно, значениями необходимых параметров,

    IsSelect - признак операции
      (True - запрос на выборку данных,
       False - запрос на изменение данных (вставка, обновление, удаление),

    DataOperationSuccessEventHandler -
      объектная функция, вызываемая после успешного выполнения запроса,
      сигнатура procedure(Sender: TObject; DataSet: TDataSet) of object,
        Sender - объект потока, который выполнял запрос,
        DataSet - набор данных, который использовался для
          выполнения запроса


    DataOperationErrorEventHandler -
      объектная функция, вызываемая после возникновения ошибки
      во время выполнения запроса,
      сигнатура procedure(Sender: TObject;
                          DataSet: TDataSet;
                          const Error: Exception
                         ) of object,
        Sender - объект потока, который выполнял запрос,
        DataSet - набор данных, который использовался для
          выполнения запроса,
        Error - объект ошибки, возникшей во время
          выполнения запроса
}
procedure ExecuteQueryAsync(
  QueryObject: TZQuery;
  const IsSelect: Boolean = True;
  const DataOperationSuccessEventHandler: TOnDataOperationSuccessEvent = nil;
  const DataOperationErrorEventHandler: TOnDataOperationErrorOccurredEvent = nil;
  ArbitraryState: TObject = nil
); overload;

{
  Назначение:
    Асинхронное выполнение запроса к БД

  Параметры:
    QueryObject - объект запроса,
    QueryText - текст запроса,
    ParamNames - перечень наименований параметров,
    ParamValues - перечень соответствующих значений параметров,

    IsSelect - признак операции
      (True - запрос на выборку данных,
       False - запрос на изменение данных (вставка, обновление, удаление),

    DataOperationSuccessEventHandler -
      объектная функция, вызываемая после успешного выполнения запроса,
      сигнатура procedure(Sender: TObject; DataSet: TDataSet) of object,
        Sender - объект потока, который выполнял запрос,
        DataSet - набор данных, который использовался для
          выполнения запроса


    DataOperationErrorEventHandler -
      объектная функция, вызываемая после возникновения ошибки
      во время выполнения запроса,
      сигнатура procedure(Sender: TObject;
                          DataSet: TDataSet;
                          const Error: Exception
                         ) of object,
        Sender - объект потока, который выполнял запрос,
        DataSet - набор данных, который использовался для
          выполнения запроса,
        Error - объект ошибки, возникшей во время
          выполнения запроса
}
procedure ExecuteQueryAsync(
  QueryObject: TZQuery;
  const QueryText: String;
  const ParamNames: Array of String;
  const ParamValues: Array of Variant;
  const IsSelect: Boolean = True;
  const DataOperationSuccessEventHandler: TOnDataOperationSuccessEvent = nil;
  const DataOperationErrorEventHandler: TOnDataOperationErrorOccurredEvent = nil;
  ArbitraryState: TObject = nil
); overload;

implementation

uses AuxZeosFunctions, SQLCommandThreadUnit;

procedure ExecuteQueryAsync(
  DBConnection: TZConnection;
  const QueryText: String;
  const IsSelect: Boolean = True;
  const DataOperationSuccessEventHandler: TOnDataOperationSuccessEvent = nil;
  const DataOperationErrorEventHandler: TOnDataOperationErrorOccurredEvent = nil;
  ArbitraryState: TObject = nil
); overload;
begin

  ExecuteQueryAsync(
    DBConnection, QueryText, [], [], IsSelect,
    DataOperationSuccessEventHandler, DataOperationErrorEventHandler,
    ArbitraryState
  );
  
end;

procedure ExecuteQueryAsync(
  DBConnection: TZConnection;
  const QueryText: String;
  const ParamNames: Array of String;
  const ParamValues: Array of Variant;
  const IsSelect: Boolean = True;
  const DataOperationSuccessEventHandler: TOnDataOperationSuccessEvent = nil;
  const DataOperationErrorEventHandler: TOnDataOperationErrorOccurredEvent = nil;
  ArbitraryState: TObject = nil
);
var ParamNameList: TStrings;
    ParamValueList: TVariantList;
begin

  ArrayOfQueryParamsDataToList(
    ParamNames, ParamValues,
    ParamNameList, ParamValueList
  );

  try

    ExecuteQueryAsync(
      DBConnection,
      QueryText,
      ParamNameList,
      ParamValueList,
      IsSelect,
      DataOperationSuccessEventHandler,
      DataOperationErrorEventHandler
    );

  finally

    FreeAndNil(ParamNameList);
    FreeAndNil(ParamValueList);

  end;
  
end;

procedure ExecuteQueryAsync(
  DBConnection: TZConnection;
  const QueryText: String;
  const ParamNames: TStrings;
  const ParamValues: TVariantList;
  const IsSelect: Boolean = True;
  const DataOperationSuccessEventHandler: TOnDataOperationSuccessEvent = nil;
  const DataOperationErrorEventHandler: TOnDataOperationErrorOccurredEvent = nil;
  ArbitraryState: TObject = nil
); overload;
var DataOperation: TDataOperationType;
    SQLCommandThread: TSQLCommandThread;
begin

  if IsSelect then
    DataOperation := opSelectData

  else DataOperation := opChangeData;

  SQLCommandThread := TSQLCommandThread.Create(
                        DBConnection,
                        QueryText,
                        ParamNames,
                        ParamValues,
                        DataOperation,
                        True
                      );

  SQLCommandThread.OnDataOperationSuccessEvent :=
    DataOperationSuccessEventHandler;

  SQLCommandThread.OnDataOperationErrorOccurredEvent :=
    DataOperationErrorEventHandler;

  SQLCommandThread.FreeOnTerminate := True;
  SQLCommandThread.RelatedState := ArbitraryState;

  SQLCommandThread.Resume;
  
end;

procedure ExecuteQueryAsync(
  QueryObject: TZQuery;
  const QueryText: String;
  const ParamNames: Array of String;
  const ParamValues: Array of Variant;
  const IsSelect: Boolean = True;
  const DataOperationSuccessEventHandler: TOnDataOperationSuccessEvent = nil;
  const DataOperationErrorEventHandler: TOnDataOperationErrorOccurredEvent = nil;
  ArbitraryState: TObject = nil
);
begin

  InitQuery(QueryObject, QueryText, ParamNames, ParamValues);

  ExecuteQueryAsync(
    QueryObject,
    IsSelect,
    DataOperationSuccessEventHandler,
    DataOperationErrorEventHandler,
    ArbitraryState
  );
  
end;

procedure ExecuteQueryAsync(
  QueryObject: TZQuery;
  const IsSelect: Boolean = True;
  const DataOperationSuccessEventHandler: TOnDataOperationSuccessEvent = nil;
  const DataOperationErrorEventHandler: TOnDataOperationErrorOccurredEvent = nil;
  ArbitraryState: TObject = nil
);
var DataOperation: TDataOperationType;
    SQLCommandThread: TSQLCommandThread;
begin

  if IsSelect then
    DataOperation := opSelectData

  else DataOperation := opChangeData;

  SQLCommandThread := TSQLCommandThread.Create(True);

  SQLCommandThread.FreeOnTerminate := True;
  SQLCommandThread.DataSet := QueryObject;
  SQLCommandThread.FreeDataSetOnSuccess := False;
  SQLCommandThread.FreeDataSetOnFail := False;
  SQLCommandThread.RelatedState := ArbitraryState;

  SQLCommandThread.OnDataOperationSuccessEvent :=
    DataOperationSuccessEventHandler;

  SQLCommandThread.OnDataOperationErrorOccurredEvent :=
    DataOperationErrorEventHandler;

  SQLCommandThread.Resume;
  
end;

end.
