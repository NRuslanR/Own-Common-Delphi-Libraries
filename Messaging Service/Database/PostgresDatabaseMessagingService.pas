unit PostgresDatabaseMessagingService;

interface

uses

  QueryExecutor,
  AbstractDatabaseMessagingService,
  MessagingServiceUnit,
  SysUtils,
  Classes;

type

  TPostgresDatabaseMessagingService = class (TAbstractDatabaseMessagingService)

    protected

      function MapMessageContentDataFrom(const MessageContent: TStrings): Variant; override;
      function MapMessageAttachmentsDataFrom(MessageAttachments: IMessageAttachments): Variant; override;

    protected

      function PrepareMessageDataInsertingQueryPattern(
        SchemaData: TDatabaseMessagingServiceSchemaData
      ): String; override;

    protected

      procedure ChangeMessageDataInsertingQueryData(
        const SourceQuery: String;
        QueryParams: TQueryParams;
        var ChangedQuery: String
      );
      
      procedure ExecuteMessageDataInsertingQuery(
        const QueryText: String;
        QueryParams: TQueryParams
      ); override;

      procedure ExecuteMessageDataInsertingQueryAsync(
        const QueryText: String;
        QueryParams: TQueryParams;
        Message: IMessage;
        RelatedState: TObject;
        OnMessageSentEventHandler: TOnMessageSentEventHandler;
        OnMessageSendingFailedEventHandler: TOnMessageSendingFailedEventHandler
      ); override;
    
  end;

implementation

uses

  AuxiliaryStringFunctions,
  StrUtils,
  Variants;
  
{ TPostgresDatabaseMessagingService }

procedure TPostgresDatabaseMessagingService.
  ChangeMessageDataInsertingQueryData(
    const SourceQuery: String;
    QueryParams: TQueryParams;
    var ChangedQuery: String
  );
begin

  ChangedQuery :=
    ReplaceStr(
      SourceQuery,
      ':' + QueryParams[SchemaData.MessageAttachmentsQueryParamName].ParamName,
      VarToStr(QueryParams[SchemaData.MessageAttachmentsQueryParamName].ParamValue)
    );

  ChangedQuery :=
    ReplaceStr(
      ChangedQuery,
      ':' + QueryParams[SchemaData.MessageContentQueryParamName].ParamName,
      VarToStr(QueryParams[SchemaData.MessageContentQueryParamName].ParamValue)
  );
  
  QueryParams.RemoveByName(SchemaData.MessageContentQueryParamName);
  QueryParams.RemoveByName(SchemaData.MessageAttachmentsQueryParamName);
  QueryParams.RemoveByName(SchemaData.MessageSenderQueryParamName);
  
end;

procedure TPostgresDatabaseMessagingService.ExecuteMessageDataInsertingQuery(
  const QueryText: String;
  QueryParams: TQueryParams
);
var UpdatedQueryText: String;
begin

  ChangeMessageDataInsertingQueryData(
    QueryText, QueryParams, UpdatedQueryText
  );

  inherited ExecuteMessageDataInsertingQuery(
    UpdatedQueryText,
    QueryParams
  );

end;

procedure TPostgresDatabaseMessagingService.
  ExecuteMessageDataInsertingQueryAsync(
    const QueryText: String;
    QueryParams: TQueryParams;
    Message: IMessage;
    RelatedState: TObject;
    OnMessageSentEventHandler: TOnMessageSentEventHandler;
    OnMessageSendingFailedEventHandler: TOnMessageSendingFailedEventHandler
  );
var UpdatedQueryText: String;
begin

  ChangeMessageDataInsertingQueryData(
    QueryText, QueryParams, UpdatedQueryText
  );
  
  inherited ExecuteMessageDataInsertingQueryAsync(
    UpdatedQueryText,
    QueryParams,
    Message,
    RelatedState,
    OnMessageSentEventHandler,
    OnMessageSendingFailedEventHandler
  );
  
end;

function TPostgresDatabaseMessagingService.MapMessageAttachmentsDataFrom(
  MessageAttachments: IMessageAttachments
): Variant;
var MessageAttachment: IMessageAttachment;
    AttachmentPostgresStringArray: String;
    PostgresFilePathString: String;
begin

  if MessageAttachments.Count = 0 then begin

    Result := 'NULL::::text[]';
    Exit;
    
  end;

  for MessageAttachment in MessageAttachments do begin

    PostgresFilePathString :=
      'E' + QuotedStr('"' + EscapeFilePathSpecChars(MessageAttachment.FilePath + '"'));

    if AttachmentPostgresStringArray = '' then
      AttachmentPostgresStringArray := PostgresFilePathString

    else
      AttachmentPostgresStringArray :=
        AttachmentPostgresStringArray + ',' + PostgresFilePathString;
    
  end;

  AttachmentPostgresStringArray :=
    'ARRAY[' + AttachmentPostgresStringArray + ']';

  Result := AttachmentPostgresStringArray;
  
end;

function TPostgresDatabaseMessagingService.MapMessageContentDataFrom(
  const MessageContent: TStrings): Variant;
var I: Integer;
    MessageLine: String;
begin

  for I := 0 to MessageContent.Count - 1 do begin

    MessageLine := QuotedStr(MessageContent[I]);

    if Result = '' then
      Result := MessageLine

    else
      Result := Result + ' || E' + QuotedStr('<br>') + ' || ' + MessageLine;

  end;

end;

function TPostgresDatabaseMessagingService.
  PrepareMessageDataInsertingQueryPattern(
    SchemaData: TDatabaseMessagingServiceSchemaData
  ): String;
begin

  Result :=
    Format(
      'SELECT sys.sendemail_queue_add(:%s,:%s,:%s,now()::::timestamp without time zone,:%s)',
      [
        SchemaData.MessageReceiversQueryParamName,
        SchemaData.MessageNameQueryParamName,
        SchemaData.MessageContentQueryParamName,
        SchemaData.MessageAttachmentsQueryParamName
      ]
    );
    
end;

end.
