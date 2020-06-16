unit AbstractDatabaseMessagingService;

interface

uses

  MessagingServiceCommonObjects,
  MessagingServiceUnit,
  VariantTypeUnit,
  QueryExecutor,
  SysUtils,
  Classes;

type

  TDatabaseMessagingServiceSchemaData = class

    public

      MessageTableName: String;

      MessageNameColumnName: String;
      MessageContentColumnName: String;
      MessageSenderColumnName: String;
      MessageReceiversColumnName: String;
      MessageAttachmentsColumnName: String;

      MessageNameQueryParamName: String;
      MessageContentQueryParamName: String;
      MessageSenderQueryParamName: String;
      MessageReceiversQueryParamName: String;
      MessageAttachmentsQueryParamName: String;
      
  end;

  TAbstractDatabaseMessagingServiceException = class (Exception)

  end;

  TAbstractDatabaseMessagingService =
    class (TInterfacedObject, IMessagingService)

      private

        FSchemaData: TDatabaseMessagingServiceSchemaData;
        FQueryExecutor: IQueryExecutor;
        
        FPreparedMessageDataInsertingQueryPattern: String;

      protected

        procedure SetSchemaData(const Value: TDatabaseMessagingServiceSchemaData);

        function PreparedMessageDataInsertingQueryPattern: String;
        
      protected

        function PrepareMessageDataInsertingQueryPattern(
          SchemaData: TDatabaseMessagingServiceSchemaData
        ): String; virtual;

      protected

        function MapMessageDataInsertingQueryParamsFrom(Message: IMessage): TQueryParams; virtual;

        function MapMessageNameDataFrom(const MessageName: String): Variant; virtual;
        function MapMessageContentDataFrom(const MessageContent: TStrings): Variant; virtual;
        function MapMessageSenderDataFrom(MessageSender: IMessageMember): Variant; virtual;
        function MapMessageReceiversDataFrom(MessageReceivers: IMessageMembers): Variant; virtual;
        function MapMessageAttachmentsDataFrom(MessageAttachments: IMessageAttachments): Variant; virtual;

      protected

        procedure ExecuteMessageDataInsertingQuery(
          const QueryText: String;
          QueryParams: TQueryParams
        ); virtual;

        procedure ExecuteMessageDataInsertingQueryAsync(
          const QueryText: String;
          QueryParams: TQueryParams;
          Message: IMessage;
          RelatedState: TObject;
          OnMessageSentEventHandler: TOnMessageSentEventHandler;
          OnMessageSendingFailedEventHandler: TOnMessageSendingFailedEventHandler
        ); virtual;
        
      protected

        procedure OnModificationQuerySuccessedEventHandler(
          Sender: TObject;
          RowsAffected: Integer;
          RelatedState: TObject
        );

        procedure OnModificationQueryFailedEventHandler(
          Sender: TObject;
          const Error: Exception;
          RelatedState: TObject
        );

      protected

        procedure InternalSendMessageAsync(
          Message: IMessage;
          OnMessageSentEventHandler: TOnMessageSentEventHandler = nil;
          OnMessageSendingFailedEventHandler: TOnMessageSendingFailedEventHandler = nil;
          RelatedState: TObject = nil
        ); virtual;

      public

        destructor Destroy; override;
        constructor Create(
          SchemaData: TDatabaseMessagingServiceSchemaData;
          QueryExecutor: IQueryExecutor
        );
        
        function GetSelf: TObject;

        function CreateMessageInstance: IMessage; virtual;
        function CreateMessagesInstance: IMessages; virtual;

        procedure SendMessage(Message: IMessage); virtual;
        procedure SendMessages(Messages: IMessages); virtual;

        procedure SendMessageAsync(
          Message: IMessage;
          OnMessageSentEventHandler: TOnMessageSentEventHandler = nil;
          OnMessageSendingFailedEventHandler: TOnMessageSendingFailedEventHandler = nil;
          RelatedState: TObject = nil
        ); virtual;

        procedure SendMessagesAsync(
          Messages: IMessages;
          OnMessageSentEventHandler: TOnMessageSentEventHandler = nil;
          OnMessageSendingFailedEventHandler: TOnMessageSendingFailedEventHandler = nil;
          RelatedState: TObject = nil
        ); virtual;

      published

        property QueryExecutor: IQueryExecutor
        read FQueryExecutor write FQueryExecutor;

        property SchemaData: TDatabaseMessagingServiceSchemaData
        read FSchemaData write SetSchemaData;

    end;

implementation

uses

  Variants,
  AuxDebugFunctionsUnit;

type

  TAsyncSendingMessageEventHandlersData = class

    Message: IMessage;

    RelatedState: TObject;

    OnMessageSentEventHandler: TOnMessageSentEventHandler;
    OnMessageSendingFailedEventHandler: TOnMessageSendingFailedEventHandler;

    constructor Create(

      Message: IMessage;

      RelatedState: TObject;

      OnMessageSentEventHandler: TOnMessageSentEventHandler;
      OnMessageSendingFailedEventHandler: TOnMessageSendingFailedEventHandler

    );

  end;
  
{ TAbstractDatabaseMessagingService }

constructor TAbstractDatabaseMessagingService.Create(
  SchemaData: TDatabaseMessagingServiceSchemaData;
  QueryExecutor: IQueryExecutor
);
begin

  inherited Create;

  Self.SchemaData := SchemaData;
  Self.QueryExecutor := QueryExecutor;
  
  FPreparedMessageDataInsertingQueryPattern :=
    PrepareMessageDataInsertingQueryPattern(SchemaData);
    
end;

function TAbstractDatabaseMessagingService.CreateMessageInstance: IMessage;
begin

  Result := TCommonMessage.Create;
  
end;

function TAbstractDatabaseMessagingService.CreateMessagesInstance: IMessages;
begin

  Result := TCommonMessages.Create;

end;

destructor TAbstractDatabaseMessagingService.Destroy;
begin

  FreeAndNil(FSchemaData);
  
  inherited;

end;

procedure TAbstractDatabaseMessagingService.
  ExecuteMessageDataInsertingQuery(
    const QueryText: String;
    QueryParams: TQueryParams
  );
begin

  FQueryExecutor.ExecuteModificationQuery(
    QueryText,
    QueryParams
  );

end;

procedure TAbstractDatabaseMessagingService.
  ExecuteMessageDataInsertingQueryAsync(
    const QueryText: String;
    QueryParams: TQueryParams;
    Message: IMessage;
    RelatedState: TObject;
    OnMessageSentEventHandler: TOnMessageSentEventHandler;
    OnMessageSendingFailedEventHandler: TOnMessageSendingFailedEventHandler
  );
begin

  FQueryExecutor.ExecuteModificationQueryAsync(
    QueryText,
    QueryParams,

    TAsyncSendingMessageEventHandlersData.Create(
      Message,
      RelatedState,
      OnMessageSentEventHandler,
      OnMessageSendingFailedEventHandler
    ),
    
    OnModificationQuerySuccessedEventHandler,
    OnModificationQueryFailedEventHandler
  );

end;

function TAbstractDatabaseMessagingService.GetSelf: TObject;
begin

  Result := Self;
  
end;

procedure TAbstractDatabaseMessagingService.InternalSendMessageAsync(
  Message: IMessage;
  OnMessageSentEventHandler: TOnMessageSentEventHandler;
  OnMessageSendingFailedEventHandler: TOnMessageSendingFailedEventHandler;
  RelatedState: TObject
);
var MessageDataInsertingQueryParams: TQueryParams;
begin

  MessageDataInsertingQueryParams :=
    MapMessageDataInsertingQueryParamsFrom(Message);

  try

    ExecuteMessageDataInsertingQueryAsync(
      PreparedMessageDataInsertingQueryPattern,
      MessageDataInsertingQueryParams,
      Message,
      RelatedState,
      OnMessageSentEventHandler,
      OnMessageSendingFailedEventHandler
    );

  finally

    FreeAndNil(MessageDataInsertingQueryParams);

  end;

end;

function TAbstractDatabaseMessagingService.MapMessageAttachmentsDataFrom(
  MessageAttachments: IMessageAttachments): Variant;
var MessageAttachment: IMessageAttachment;
    AttachmentListString: String;
begin

  for MessageAttachment in MessageAttachments do begin

    if AttachmentListString = '' then
      AttachmentListString := MessageAttachment.FilePath

    else
      AttachmentListString :=
        AttachmentListString + ';' + MessageAttachment.FilePath;
         
  end;

  Result := AttachmentListString;

end;

function TAbstractDatabaseMessagingService.MapMessageDataInsertingQueryParamsFrom(
  Message: IMessage
): TQueryParams;
var CommonMessage: TCommonMessage;
begin

  if not (Message.Self is TCommonMessage) then
    raise TAbstractDatabaseMessagingServiceException.Create(
            'Не известен тип отправляемого сообщения ' +
            'для выполнения разбора'
          );

  CommonMessage := Message.Self as TCommonMessage;
  
  Result :=
    TQueryParams
    .Create
    .AddFluently(
      SchemaData.MessageNameQueryParamName,
      MapMessageNameDataFrom(CommonMessage.Name)
    )
    .AddFluently(
      SchemaData.MessageContentQueryParamName,
      MapMessageContentDataFrom(CommonMessage.Content)
    )
    .AddFluently(
      SchemaData.MessageSenderQueryParamName,
      MapMessageSenderDataFrom(CommonMessage.Sender)
    )
    .AddFluently(
      SchemaData.MessageReceiversQueryParamName,
      MapMessageReceiversDataFrom(CommonMessage.Receivers)
    )
    .AddFluently(
      SchemaData.MessageAttachmentsQueryParamName,
      MapMessageAttachmentsDataFrom(CommonMessage.Attachments)
    );

end;

function TAbstractDatabaseMessagingService.MapMessageContentDataFrom(
  const MessageContent: TStrings): Variant;
var ContentString: String;
    I: Integer;
begin

  for I := 0 to MessageContent.Count - 1 do begin

    if ContentString = '' then
      ContentString := MessageContent[I]

    else
      ContentString := ContentString + '\r\n' + MessageContent[I];

  end;

  Result := ContentString;
  
end;

function TAbstractDatabaseMessagingService.MapMessageNameDataFrom(
  const MessageName: String): Variant;
begin

  Result := MessageName;
  
end;

function TAbstractDatabaseMessagingService.MapMessageReceiversDataFrom(
  MessageReceivers: IMessageMembers
): Variant;
var MessageReceiver: IMessageMember;
    ReceiverListString: String;
begin

  for MessageReceiver in MessageReceivers do begin

    if ReceiverListString = '' then
      ReceiverListString := VarToStr(MessageReceiver.Identifier)

    else
      ReceiverListString :=
        ReceiverListString + ',' + VarToStr(MessageReceiver.Identifier);
  end;

  Result := ReceiverListString;

end;

function TAbstractDatabaseMessagingService.MapMessageSenderDataFrom(
  MessageSender: IMessageMember): Variant;
begin

  Result := VarToStr(MessageSender.Identifier);
  
end;

procedure TAbstractDatabaseMessagingService.
  OnModificationQueryFailedEventHandler(
    Sender: TObject;
    const Error: Exception;
    RelatedState: TObject
  );
var AsyncSendingMessageEventHandlersData: TAsyncSendingMessageEventHandlersData;
begin

  AsyncSendingMessageEventHandlersData :=
    RelatedState as TAsyncSendingMessageEventHandlersData;

  try

    if Assigned(AsyncSendingMessageEventHandlersData.OnMessageSendingFailedEventHandler)
    then begin

      AsyncSendingMessageEventHandlersData.OnMessageSendingFailedEventHandler(
        Self,
        AsyncSendingMessageEventHandlersData.Message,
        Error,
        AsyncSendingMessageEventHandlersData.RelatedState
      );
      
    end;
    
  finally

    FreeAndNil(AsyncSendingMessageEventHandlersData);
    
  end;

end;

procedure TAbstractDatabaseMessagingService.
  OnModificationQuerySuccessedEventHandler(
    Sender: TObject;
    RowsAffected: Integer;
    RelatedState: TObject
  );
var AsyncSendingMessageEventHandlersData: TAsyncSendingMessageEventHandlersData;
begin

  AsyncSendingMessageEventHandlersData :=
    RelatedState as TAsyncSendingMessageEventHandlersData;

  try

    if Assigned(AsyncSendingMessageEventHandlersData.OnMessageSentEventHandler)
    then begin

      AsyncSendingMessageEventHandlersData.OnMessageSentEventHandler(
        Self,
        AsyncSendingMessageEventHandlersData.Message,
        AsyncSendingMessageEventHandlersData.RelatedState
      );
      
    end;
    
  finally

    FreeAndNil(AsyncSendingMessageEventHandlersData);
    
  end;

end;

function TAbstractDatabaseMessagingService.
  PreparedMessageDataInsertingQueryPattern: String;
begin

  Result := FPreparedMessageDataInsertingQueryPattern;
  
end;

function TAbstractDatabaseMessagingService.
  PrepareMessageDataInsertingQueryPattern(
    SchemaData: TDatabaseMessagingServiceSchemaData
  ): String;
begin

  Result :=
    Format(
      'INSERT INTO %s ' +
      '(%s,%s,%s,%s,%s) ' +
      'VALUES (:%s,:%s,:%s,:%s,:%s)',
      [
        SchemaData.MessageTableName,

        SchemaData.MessageNameColumnName,
        SchemaData.MessageContentColumnName,
        SchemaData.MessageSenderColumnName,
        SchemaData.MessageReceiversColumnName,
        SchemaData.MessageAttachmentsColumnName,

        SchemaData.MessageNameQueryParamName,
        SchemaData.MessageContentQueryParamName,
        SchemaData.MessageSenderQueryParamName,
        SchemaData.MessageReceiversColumnName,
        SchemaData.MessageAttachmentsQueryParamName
      ]
    );

end;

procedure TAbstractDatabaseMessagingService.SendMessage(Message: IMessage);
var MessageDataInsertingQueryParams: TQueryParams;
begin

  MessageDataInsertingQueryParams :=
    MapMessageDataInsertingQueryParamsFrom(Message);
  
  try

    ExecuteMessageDataInsertingQuery(
      PreparedMessageDataInsertingQueryPattern,
      MessageDataInsertingQueryParams
    );

  finally

    FreeAndNil(MessageDataInsertingQueryParams);
    
  end;

end;

procedure TAbstractDatabaseMessagingService.SendMessageAsync(
  Message: IMessage;
  OnMessageSentEventHandler: TOnMessageSentEventHandler;
  OnMessageSendingFailedEventHandler: TOnMessageSendingFailedEventHandler;
  RelatedState: TObject
);
begin

  InternalSendMessageAsync(
    Message,
    OnMessageSentEventHandler,
    OnMessageSendingFailedEventHandler
  );
  
end;

procedure TAbstractDatabaseMessagingService.SendMessages(Messages: IMessages);
var Message: IMessage;
begin

  { Refactor: перенести в более абстрактный класс,
    как реализацию по умолчанию }
  for Message in Messages do SendMessage(Message);

end;

procedure TAbstractDatabaseMessagingService.SendMessagesAsync(
  Messages: IMessages;
  OnMessageSentEventHandler: TOnMessageSentEventHandler;
  OnMessageSendingFailedEventHandler: TOnMessageSendingFailedEventHandler;
  RelatedState: TObject
);
var Message: IMessage;
begin

  { Refactor: перенести в более абстрактный класс,
    как реализацию по умолчанию }
  for Message in Messages do begin

    InternalSendMessageAsync(
      Message,
      OnMessageSentEventHandler,
      OnMessageSendingFailedEventHandler,
      RelatedState
    );
    
  end;

end;

procedure TAbstractDatabaseMessagingService.SetSchemaData(
  const Value: TDatabaseMessagingServiceSchemaData);
begin

  FreeAndNil(FSchemaData);
  
  FSchemaData := Value;

end;

{ TAsyncSendingMessageEventHandlersData }

constructor TAsyncSendingMessageEventHandlersData.Create(

  Message: IMessage;

  RelatedState: TObject;

  OnMessageSentEventHandler: TOnMessageSentEventHandler;
  OnMessageSendingFailedEventHandler: TOnMessageSendingFailedEventHandler

);
begin

  inherited Create;

  Self.Message := Message;

  Self.RelatedState := RelatedState;

  Self.OnMessageSentEventHandler := OnMessageSentEventHandler;
  Self.OnMessageSendingFailedEventHandler := OnMessageSendingFailedEventHandler;

end;

end.
