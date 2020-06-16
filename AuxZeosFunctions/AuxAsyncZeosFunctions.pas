unit AuxAsyncZeosFunctions;

interface

uses ZConnection, ZDataset, DataSetOperationThreadUnit, VariantListUnit, SysUtils, Classes;

{
  ����������:
    ����������� ���������� ������� � ��

  ���������:
    DBConnection - ���������� � ��,
    QueryText - ����� �������,
    ParamNames - �������� ������������ ����������,
    ParamValues - �������� ��������������� �������� ����������,
    IsSelect - ������� ��������
      (True - ������ �� ������� ������,
       False - ������ �� ��������� ������ (�������, ����������, ��������),

    DataOperationSuccessEventHandler -
      ��������� �������, ���������� ����� ��������� ���������� �������,
      ��������� procedure(Sender: TObject; DataSet: TDataSet) of object,
        Sender - ������ ������, ������� �������� ������,
        DataSet - ����� ������, ������� ������������� ���
          ���������� �������


    DataOperationErrorEventHandler -
      ��������� �������, ���������� ����� ������������� ������
      �� ����� ���������� �������,
      ��������� procedure(Sender: TObject;
                          DataSet: TDataSet;
                          const Error: Exception
                         ) of object,
        Sender - ������ ������, ������� �������� ������,
        DataSet - ����� ������, ������� ������������� ���
          ���������� �������,
        Error - ������ ������, ��������� �� �����
          ���������� �������
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
  ����������:
    ����������� ���������� ������� � ��

  ���������:
    QueryObject - ������ ������� � ��������������
    ������� ������� �, ��������, ���������� ����������� ����������,

    IsSelect - ������� ��������
      (True - ������ �� ������� ������,
       False - ������ �� ��������� ������ (�������, ����������, ��������),

    DataOperationSuccessEventHandler -
      ��������� �������, ���������� ����� ��������� ���������� �������,
      ��������� procedure(Sender: TObject; DataSet: TDataSet) of object,
        Sender - ������ ������, ������� �������� ������,
        DataSet - ����� ������, ������� ������������� ���
          ���������� �������


    DataOperationErrorEventHandler -
      ��������� �������, ���������� ����� ������������� ������
      �� ����� ���������� �������,
      ��������� procedure(Sender: TObject;
                          DataSet: TDataSet;
                          const Error: Exception
                         ) of object,
        Sender - ������ ������, ������� �������� ������,
        DataSet - ����� ������, ������� ������������� ���
          ���������� �������,
        Error - ������ ������, ��������� �� �����
          ���������� �������
}
procedure ExecuteQueryAsync(
  QueryObject: TZQuery;
  const IsSelect: Boolean = True;
  const DataOperationSuccessEventHandler: TOnDataOperationSuccessEvent = nil;
  const DataOperationErrorEventHandler: TOnDataOperationErrorOccurredEvent = nil;
  ArbitraryState: TObject = nil
); overload;

{
  ����������:
    ����������� ���������� ������� � ��

  ���������:
    QueryObject - ������ �������,
    QueryText - ����� �������,
    ParamNames - �������� ������������ ����������,
    ParamValues - �������� ��������������� �������� ����������,

    IsSelect - ������� ��������
      (True - ������ �� ������� ������,
       False - ������ �� ��������� ������ (�������, ����������, ��������),

    DataOperationSuccessEventHandler -
      ��������� �������, ���������� ����� ��������� ���������� �������,
      ��������� procedure(Sender: TObject; DataSet: TDataSet) of object,
        Sender - ������ ������, ������� �������� ������,
        DataSet - ����� ������, ������� ������������� ���
          ���������� �������


    DataOperationErrorEventHandler -
      ��������� �������, ���������� ����� ������������� ������
      �� ����� ���������� �������,
      ��������� procedure(Sender: TObject;
                          DataSet: TDataSet;
                          const Error: Exception
                         ) of object,
        Sender - ������ ������, ������� �������� ������,
        DataSet - ����� ������, ������� ������������� ���
          ���������� �������,
        Error - ������ ������, ��������� �� �����
          ���������� �������
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
