unit AbstractEmailMessagingServiceUnit;

interface

uses

  SysUtils,
  Classes,
  MessagingServiceUnit;

type

  TEmailMessage = class;
  
  TEmailMessageMember = class (TInterfacedObject, IMessageMember)

    private

      FEmailAddress: String;
      FOfficialName: String;
      
    public

      constructor Create; overload;
      constructor Create(const EmailAddress, OfficialName: String); overload;
      
      function GetIdentifier: Variant;
      procedure SetIdentifier(const Value: Variant);

      function GetDisplayName: String;
      procedure SetDisplayName(const Value: String);

  end;

  TEmailMessageMembers = class (TAbstractMessageMembers)

    protected

      function CreateMessageMemberInstance: IMessageMember; override;

    public

      constructor Create; override;
      
  end;

  TEmailMessageAttachment = class (TInterfacedObject, IMessageAttachment)

    private

      FFilePath: String;
      
    public

      constructor Create;

      function GetFilePath: String;
      procedure SetFilePath(const FilePath: String);

  end;

  TEmailMessageAttachments = class (TAbstractMessageAttachments)

    protected

      function CreateMessageAttachmentInstance: IMessageAttachment; override;

    public

      constructor Create; override;

  end;

  TEmailMessage = class (TInterfacedObject, IMessage)

    private

      FName: String;
      FContent: TStringList;
      FEmailMessageSender: IMessageMember;
      FEmailMessageReceivers: IMessageMembers;
      FEmailMessageAttachments: IMessageAttachments;

    public

      destructor Destroy; override;
      constructor Create;

      function GetSelf: TObject;
      
      function GetName: String;
      procedure SetName(const Value: String);

      function GetContent: TStrings;
      procedure SetContent(const Value: TStrings);
      procedure SetContentAsText(const Text: String);

      function GetSender: IMessageMember;
      function GetReceivers: IMessageMembers;

      function GetAttachments: IMessageAttachments;

    published

      property Name: String read GetName write SetName;
      property Content: TStrings read GetContent write SetContent;
      property Sender: IMessageMember read GetSender;
      property Receivers: IMessageMembers read GetReceivers;
      property Attachments: IMessageAttachments read GetAttachments;

  end;

  TEmailMessages = class (TAbstractMessages)

    protected

      function CreateMessageInstance: IMessage; override;
      
  end;

  TAbstractEmailMessagingService = class abstract (TInterfacedObject, IMessagingService)

    protected

      FServerAddress: String;
      FServerPort: Integer;
      FUserName: String;
      FPassword: String;
      FUseTLS: Boolean;

      procedure ConnectToMailServer; virtual; abstract;

      function EncodeEmailMessageForSending(Message: TEmailMessage): TObject; virtual; abstract;

      procedure SendEncodedEmailMessage(
        EncodedEmailMessage: TObject;
        Sender: IMessageMember;
        Receivers: IMessageMembers
      ); virtual; abstract;

      procedure DisconnectFromMailServer; virtual; abstract;

      function GetPassword: String;
      function GetServerAddress: String;
      function GetServerPort: Integer;
      function GetUserName: String;
      function GetUseTLS: Boolean;
      procedure SetPassword(const Value: String);
      procedure SetServerAddress(const Value: String);
      procedure SetServerPort(const Value: Integer);
      procedure SetUserName(const Value: String);
      procedure SetUseTLS(const Value: Boolean);

    public

      constructor Create; virtual;

      function CreateMessageInstance: IMessage;
      function CreateMessagesInstance: IMessages;

      procedure SendMessage(Message: IMessage);
      procedure SendMessages(Messages: IMessages);

      procedure SendMessageAsync(
        Message: IMessage;
        OnMessageSentEventHandler: TOnMessageSentEventHandler = nil;
        OnMessageSendingFailedEventHandler: TOnMessageSendingFailedEventHandler = nil;
        RelatedState: TObject = nil
      );

      procedure SendMessagesAsync(
        Messages: IMessages;
        OnMessageSentEventHandler: TOnMessageSentEventHandler = nil;
        OnMessageSendingFailedEventHandler: TOnMessageSendingFailedEventHandler = nil;
        RelatedState: TObject = nil
      );

      function GetSelf: TObject;
      
    published
    
      property ServerAddress: String read GetServerAddress write SetServerAddress;
      property ServerPort: Integer read GetServerPort write SetServerPort;
      property UserName: String read GetUserName write SetUserName;
      property Password: String read GetPassword write SetPassword;
      property UseTLS: Boolean read GetUseTLS write SetUseTLS;
      
  end;

implementation

uses

  AuxDebugFunctionsUnit;
  
{ TEmailMessageMember }

constructor TEmailMessageMember.Create;
begin

  inherited;

end;

constructor TEmailMessageMember.Create(
  const EmailAddress, OfficialName: String
);
begin

  inherited Create;

  FEmailAddress := EmailAddress;
  FOfficialName := OfficialName;
  
end;

function TEmailMessageMember.GetDisplayName: String;
begin

  Result := FOfficialName;

end;

function TEmailMessageMember.GetIdentifier: Variant;
begin

  Result := FEmailAddress;
  
end;

procedure TEmailMessageMember.SetDisplayName(const Value: String);
begin

  FOfficialName := Value;
  
end;

procedure TEmailMessageMember.SetIdentifier(const Value: Variant);
begin

  FEmailAddress := Value;
  
end;

{ TEmailMessage }

constructor TEmailMessage.Create;
begin

  inherited Create;

  FContent := TStringList.Create;
  FEmailMessageSender := TEmailMessageMember.Create;
  FEmailMessageReceivers := TEmailMessageMembers.Create;
  FEmailMessageAttachments := TEmailMessageAttachments.Create;

end;

destructor TEmailMessage.Destroy;
begin

  FreeAndNil(FContent);
  
  inherited;

end;

function TEmailMessage.GetAttachments: IMessageAttachments;
begin

  Result := FEmailMessageAttachments;
  
end;

function TEmailMessage.GetContent: TStrings;
begin

  Result := FContent;

end;

function TEmailMessage.GetName: String;
begin

  Result := FName;

end;

function TEmailMessage.GetReceivers: IMessageMembers;
begin

  Result := FEmailMessageReceivers;

end;

function TEmailMessage.GetSelf: TObject;
begin

  Result := Self;
  
end;

function TEmailMessage.GetSender: IMessageMember;
begin

  Result := FEmailMessageSender;
  
end;

procedure TEmailMessage.SetContent(const Value: TStrings);
begin

  FContent.Assign(Value);
  
end;

procedure TEmailMessage.SetContentAsText(const Text: String);
begin

  FContent.Text := Text;
  
end;

procedure TEmailMessage.SetName(const Value: String);
begin

  FName := Value;
  
end;

{ TEmailMessageAttachment }

constructor TEmailMessageAttachment.Create;
begin

  inherited Create;

end;

function TEmailMessageAttachment.GetFilePath: String;
begin

  Result := FFilePath;
  
end;

procedure TEmailMessageAttachment.SetFilePath(const FilePath: String);
begin

  FFilePath := FilePath;

end;

{ TEmailMessageAttachments }

constructor TEmailMessageAttachments.Create;
begin

  inherited Create;

end;

function TEmailMessageAttachments.CreateMessageAttachmentInstance: IMessageAttachment;
begin

  Result := TEmailMessageAttachment.Create;

end;

{ TEmailMessageMembers }

constructor TEmailMessageMembers.Create;
begin

  inherited Create;

end;

function TEmailMessageMembers.CreateMessageMemberInstance: IMessageMember;
begin

  Result := TEmailMessageMember.Create;

end;

{ TAbstractEmailMessagingService }

constructor TAbstractEmailMessagingService.Create;
begin

  inherited Create;
  
end;

function TAbstractEmailMessagingService.CreateMessageInstance: IMessage;
begin

  Result := TEmailMessage.Create;
  
end;

function TAbstractEmailMessagingService.CreateMessagesInstance: IMessages;
begin

  Result := TEmailMessages.Create;
  
end;

function TAbstractEmailMessagingService.GetPassword: String;
begin

  Result := FPassword;
  
end;

function TAbstractEmailMessagingService.GetSelf: TObject;
begin

  Result := Self;
  
end;

function TAbstractEmailMessagingService.GetServerAddress: String;
begin

  Result := FServerAddress;

end;

function TAbstractEmailMessagingService.GetServerPort: Integer;
begin

  Result := FServerPort;
  
end;

function TAbstractEmailMessagingService.GetUserName: String;
begin

  Result := FUserName;
  
end;

function TAbstractEmailMessagingService.GetUseTLS: Boolean;
begin

  Result := FUseTLS;

end;

procedure TAbstractEmailMessagingService.SendMessage(Message: IMessage);
var EncodedEmailMessage: TObject;
begin

  ConnectToMailServer;

  EncodedEmailMessage := EncodeEmailMessageForSending(Message.Self as TEmailMessage);

  SendEncodedEmailMessage(
    EncodedEmailMessage,
    Message.Sender,
    Message.Receivers
  );

  DisconnectFromMailServer;

end;

procedure TAbstractEmailMessagingService.SendMessageAsync(
  Message: IMessage;
  OnMessageSentEventHandler: TOnMessageSentEventHandler;
  OnMessageSendingFailedEventHandler: TOnMessageSendingFailedEventHandler;
  RelatedState: TObject
);
begin

  raise Exception.Create(
    'Отправка почтового сообщения в ' +
    'асинхронном режиме не реализована'
  );

end;

procedure TAbstractEmailMessagingService.SendMessages(Messages: IMessages);
var Message: IMessage;
begin

  { Refactor: перенести в более абстрактный класс,
    как реализацию по умолчанию }
  for Message in Messages do SendMessage(Message);
    
end;

procedure TAbstractEmailMessagingService.
  SendMessagesAsync(
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

    SendMessageAsync(
      Message,
      OnMessageSentEventHandler,
      OnMessageSendingFailedEventHandler,
      RelatedState
    );

  end;
  
end;

procedure TAbstractEmailMessagingService.SetPassword(const Value: String);
begin

  FPassword := Value;
  
end;

procedure TAbstractEmailMessagingService.SetServerAddress(const Value: String);
begin

  FServerAddress := Value;
  
end;

procedure TAbstractEmailMessagingService.SetServerPort(const Value: Integer);
begin

  FServerPort := Value;
  
end;

procedure TAbstractEmailMessagingService.SetUserName(const Value: String);
begin

  FUserName := Value;
  
end;

procedure TAbstractEmailMessagingService.SetUseTLS(const Value: Boolean);
begin

  FUseTLS := Value;

end;

{ TEmailMessages }

function TEmailMessages.CreateMessageInstance: IMessage;
begin

  Result := TEmailMessage.Create;
  
end;

end.
