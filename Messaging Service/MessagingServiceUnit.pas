unit MessagingServiceUnit;

interface

uses

  SysUtils,
  Classes,
  IGetSelfUnit;
  
type

  IMessageMember = interface

    function GetIdentifier: Variant;
    procedure SetIdentifier(const Value: Variant);

    function GetDisplayName: String;
    procedure SetDisplayName(const Value: String);
    
    property Identifier: Variant read GetIdentifier write SetIdentifier;
    property DisplayName: String read GetDisplayName write SetDisplayName;

  end;

  IMessageMembersEnumerator = interface

    function GetCurrent: IMessageMember;
    function MoveNext: Boolean;
    property Current: IMessageMember read GetCurrent;
    
  end;
  
  IMessageMembers = interface

    function GetMemberCount: Integer;
    
    function GetMessageMemberByIndex(Index: Integer): IMessageMember;

    function Add: IMessageMember;

    procedure Remove(MessageMember: IMessageMember);

    function GetEnumerator: IMessageMembersEnumerator;
    
    property Items[Index: Integer]: IMessageMember
    read GetMessageMemberByIndex;

    property Count: Integer read GetMemberCount;

  end;

  TAbstractMessageMembers = class;

  TAbstractMessageMembersEnumerator = class (TInterfacedObject, IMessageMembersEnumerator)

    private

      FMessageMemberListEnumerator: TListEnumerator;
      
    public

      constructor Create(MessageMembers: TAbstractMessageMembers);

      function GetCurrent: IMessageMember;
      function MoveNext: Boolean;

  end;

  TAbstractMessageMembers = class abstract (TInterfacedObject, IMessageMembers)

    protected

      type

        TMessageMemberHolder = class

            MessageMember: IMessageMember;

          public

            constructor Create(MessageMember: IMessageMember);

        end;
        
    protected

      FMemberList: TList;

      procedure ClearMessageMemberHolders;
      function CreateMessageMemberInstance: IMessageMember; virtual; abstract;

    public

      destructor Destroy; override;
      constructor Create; virtual;

      function GetMessageMemberByIndex(Index: Integer): IMessageMember;

      function GetMemberCount: Integer;

      function Add: IMessageMember;

      function GetEnumerator: IMessageMembersEnumerator;
      
      procedure Remove(MessageMember: IMessageMember);

      property Items[Index: Integer]: IMessageMember
      read GetMessageMemberByIndex; default;

  end;

  IMessageAttachments = interface;
  
  IMessage = interface (IGetSelf)

    function GetName: String;
    procedure SetName(const Value: String);

    function GetContent: TStrings;
    procedure SetContent(const Value: TStrings);
    procedure SetContentAsText(const Text: String);
    
    function GetSender: IMessageMember;
    function GetReceivers: IMessageMembers;
    
    function GetAttachments: IMessageAttachments;
    
    property Name: String read GetName write SetName;
    property Content: TStrings read GetContent write SetContent;
    property Sender: IMessageMember read GetSender;
    property Receivers: IMessageMembers read GetReceivers;
    property Attachments: IMessageAttachments read GetAttachments;

  end;

  IMessagesEnumerator = interface

    function GetCurrent: IMessage;
    function MoveNext: Boolean;

    property Current: IMessage read GetCurrent;

  end;

  TAbstractMessages = class;

  TAbstractMessagesEnumerator = class (TInterfacedObject, IMessagesEnumerator)

    protected

      FMessageListEnumerator: TListEnumerator;
      
    public

      constructor Create(AbstractMessages: TAbstractMessages);
      
      function GetCurrent: IMessage;
      function MoveNext: Boolean;

      property Current: IMessage read GetCurrent;

  end;
  
  IMessages = interface

    function AddNewMessage: IMessage;
    procedure PutMessage(Message: IMessage);
    
    procedure Remove(Message: IMessage);

    procedure Clear;

    function GetEnumerator: IMessagesEnumerator;

    function GetMessageCount: Integer;

    property Count: Integer read GetMessageCount;
    
  end;

  TAbstractMessages = class (TInterfacedObject, IMessages)

    protected

      type

        TMessageHolder = class

          Message: IMessage;

          constructor Create(Message: IMessage);
          
        end;

    private

      FMessageList: TList;

    protected

      procedure ValidateMessageType(Message: IMessage); virtual;
      
      function CreateMessageInstance: IMessage; virtual; abstract;

      procedure AddMessageInMessageList(Message: IMessage);

      function FindHolderForMessage(Message: IMessage): TMessageHolder;
      
    public

      destructor Destroy; override;
      constructor Create; virtual;
      
      function AddNewMessage: IMessage;
      procedure PutMessage(Message: IMessage);
      procedure Remove(Message: IMessage);

      procedure Clear;

      function GetEnumerator: IMessagesEnumerator;

      function GetMessageCount: Integer;

      property Count: Integer read GetMessageCount;

  end;

  IMessageAttachment = interface

    function GetFilePath: String;
    procedure SetFilePath(const FilePath: String);

    property FilePath: String read GetFilePath write SetFilePath;

  end;

  IMessageAttachmentsEnumerator = interface

    function GetCurrent: IMessageAttachment;
    function MoveNext: Boolean;
    property Current: IMessageAttachment read GetCurrent;

  end;

  IMessageAttachments = interface

    function GetAttachmentCount: Integer;
    
    function GetAttachmentByIndex(Index: Integer): IMessageAttachment;

    function Add: IMessageAttachment;
    procedure Remove(Attachment: IMessageAttachment);

    property Attachments[Index: Integer]: IMessageAttachment
    read GetAttachmentByIndex; default;

    function GetEnumerator: IMessageAttachmentsEnumerator;

    property Count: Integer read GetAttachmentCount;
    
  end;

  TAbstractMessageAttachments = class;

  TAbstractMessageAttachmentsEnumerator = class (TInterfacedObject, IMessageAttachmentsEnumerator)

    private

      FAttachmentListEnumerator: TListEnumerator;

    public

      constructor Create(MessageAttachments: TAbstractMessageAttachments);

      function GetCurrent: IMessageAttachment;
      function MoveNext: Boolean;
      
  end;

  TAbstractMessageAttachments = class abstract (TInterfacedObject, IMessageAttachments)

    protected

      type

        TAttachmentInstanceHolder = class

            AttachmentInstance: IMessageAttachment;

          constructor Create(AttachmentInstance: IMessageAttachment);

        end;

    protected

      FAttachmentList: TList;

      procedure ClearAttachments;
      
      function CreateMessageAttachmentInstance: IMessageAttachment; virtual; abstract;

      function GetAttachmentByIndex(Index: Integer): IMessageAttachment;
      
    public

      destructor Destroy; override;
      constructor Create; virtual;

      function Add: IMessageAttachment;

      procedure Remove(Attachment: IMessageAttachment);

      function GetAttachmentCount: Integer;

      function GetEnumerator: IMessageAttachmentsEnumerator;

      property Items[Index: Integer]: IMessageAttachment
      read GetAttachmentByIndex; default;

  end;

  TOnMessageSentEventHandler =
    procedure (
      Sender: TObject;
      Message: IMessage;
      RelatedState: TObject
    ) of object;

  TOnMessageSendingFailedEventHandler =
    procedure (
      Sender: TObject;
      Message: IMessage;
      const Error: Exception;
      RelatedState: TObject
    ) of object;
    
  IMessagingService = interface (IGetSelf)

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

  end;
  
implementation

uses

  AuxCollectionFunctionsUnit;
  
{ TAbstractMessageAttachments.TAttachmentInstanceHolder }

constructor TAbstractMessageAttachments.TAttachmentInstanceHolder.Create(
  AttachmentInstance: IMessageAttachment);
begin

  inherited Create;

  Self.AttachmentInstance := AttachmentInstance;
  
end;

{ TAbstractMessageAttachments }

function TAbstractMessageAttachments.Add: IMessageAttachment;
begin

  Result := CreateMessageAttachmentInstance;

  FAttachmentList.Add(TAttachmentInstanceHolder.Create(Result));

end;

procedure TAbstractMessageAttachments.ClearAttachments;
var AttachmentInstanceHolder: TAttachmentInstanceHolder;
    I: Integer;
begin

  for I := 0 to FAttachmentList.Count - 1 do begin

    AttachmentInstanceHolder :=
      TAttachmentInstanceHolder(FAttachmentList[I]);

    AttachmentInstanceHolder.Free;
    
  end;

end;

constructor TAbstractMessageAttachments.Create;
begin

  inherited;

  FAttachmentList := TList.Create;
  
end;

destructor TAbstractMessageAttachments.Destroy;
begin

  ClearAttachments;
  inherited;
  
end;

function TAbstractMessageAttachments.GetAttachmentByIndex(
  Index: Integer): IMessageAttachment;
var AttachmentInstanceHolder: TAttachmentInstanceHolder;
begin

  AttachmentInstanceHolder :=
    TAttachmentInstanceHolder(FAttachmentList[Index]);

  Result := AttachmentInstanceHolder.AttachmentInstance;

end;

function TAbstractMessageAttachments.GetAttachmentCount: Integer;
begin

  Result := FAttachmentList.Count;
  
end;

function TAbstractMessageAttachments.GetEnumerator: IMessageAttachmentsEnumerator;
begin

  Result := TAbstractMessageAttachmentsEnumerator.Create(Self);
  
end;

procedure TAbstractMessageAttachments.Remove(Attachment: IMessageAttachment);
var AttachmentInstanceHolder: TAttachmentInstanceHolder;
    I: Integer;
begin

  for I := 0 to FAttachmentList.Count - 1 do begin

    AttachmentInstanceHolder :=
      TAttachmentInstanceHolder(FAttachmentList[I]);

    if AttachmentInstanceHolder.AttachmentInstance = Attachment then begin

      FAttachmentList.Delete(I);
      AttachmentInstanceHolder.Destroy;
      
      Exit;

    end;

  end;


end;

{ TAbstractMessageMembers.TMessageMemberHolder }

constructor TAbstractMessageMembers.TMessageMemberHolder.Create(
  MessageMember: IMessageMember);
begin

  inherited Create;

  Self.MessageMember := MessageMember;
  
end;

{ TAbstractMessageMembers }

function TAbstractMessageMembers.Add: IMessageMember;
var MessageMember: IMessageMember;
begin

  MessageMember := CreateMessageMemberInstance;

  FMemberList.Add(TMessageMemberHolder.Create(MessageMember));

  Result := MessageMember;
  
end;

procedure TAbstractMessageMembers.ClearMessageMemberHolders;
var MessageMemberHolder: TMessageMemberHolder;
    I: Integer;
begin

  for I := 0 to FMemberList.Count - 1 do begin

    MessageMemberHolder := TMessageMemberHolder(FMemberList);

    MessageMemberHolder.Free;
    
  end;

end;

constructor TAbstractMessageMembers.Create;
begin

  inherited;

  FMemberList := TList.Create;

end;

destructor TAbstractMessageMembers.Destroy;
begin

  FreeAndNil(FMemberList);
  inherited;

end;

function TAbstractMessageMembers.GetEnumerator: IMessageMembersEnumerator;
begin

  Result := TAbstractMessageMembersEnumerator.Create(Self);
  
end;

function TAbstractMessageMembers.GetMemberCount: Integer;
begin

  Result := FMemberList.Count;
  
end;

function TAbstractMessageMembers.GetMessageMemberByIndex(
  Index: Integer): IMessageMember;
var MessageMemberHolder: TMessageMemberHolder;
begin

  MessageMemberHolder := TMessageMemberHolder(FMemberList[Index]);

  Result := MessageMemberHolder.MessageMember;
  
end;

procedure TAbstractMessageMembers.Remove(MessageMember: IMessageMember);
var MessageMemberHolder: TMessageMemberHolder;
    I: Integer;
begin

  for I := 0 to FMemberList.Count - 1 do begin

    MessageMemberHolder := TMessageMemberHolder(FMemberList[I]);

    if MessageMemberHolder.MessageMember = MessageMember then begin

      FMemberList.Delete(I);
      MessageMemberHolder.Destroy;
      
    end;

  end;

end;

{ TAbstractMessageAttachmentsEnumerator }

constructor TAbstractMessageAttachmentsEnumerator.Create(
  MessageAttachments: TAbstractMessageAttachments
);
begin

  inherited Create;

  FAttachmentListEnumerator :=
    TListEnumerator.Create(
      MessageAttachments.FAttachmentList
    );

end;

function TAbstractMessageAttachmentsEnumerator.GetCurrent: IMessageAttachment;
var AttachmentHolder: TAbstractMessageAttachments.TAttachmentInstanceHolder;
begin

  AttachmentHolder :=
    TAbstractMessageAttachments.TAttachmentInstanceHolder(
      FAttachmentListEnumerator.GetCurrent
    );

  Result := AttachmentHolder.AttachmentInstance;

end;

function TAbstractMessageAttachmentsEnumerator.MoveNext: Boolean;
begin

  Result := FAttachmentListEnumerator.MoveNext;
  
end;

{ TAbstractMessageMembersEnumerator }

constructor TAbstractMessageMembersEnumerator.Create(
  MessageMembers: TAbstractMessageMembers
);
begin

  inherited Create;

  FMessageMemberListEnumerator :=
    TListEnumerator.Create(
      MessageMembers.FMemberList
    );

end;

function TAbstractMessageMembersEnumerator.GetCurrent: IMessageMember;
var MessageMemberHolder: TAbstractMessageMembers.TMessageMemberHolder;
begin

  MessageMemberHolder :=
    TAbstractMessageMembers.TMessageMemberHolder(
      FMessageMemberListEnumerator.GetCurrent
    );

  Result := MessageMemberHolder.MessageMember;

end;

function TAbstractMessageMembersEnumerator.MoveNext: Boolean;
begin

  Result := FMessageMemberListEnumerator.MoveNext;

end;

{ TAbstractMessagesEnumerator }

constructor TAbstractMessagesEnumerator.Create(
  AbstractMessages: TAbstractMessages);
begin

  FMessageListEnumerator :=
    TListEnumerator.Create(
      AbstractMessages.FMessageList
    );
    
end;

function TAbstractMessagesEnumerator.GetCurrent: IMessage;
var MessageHolder: TAbstractMessages.TMessageHolder;
begin

  MessageHolder :=
    TAbstractMessages.TMessageHolder(
      FMessageListEnumerator.GetCurrent
    );

  Result := MessageHolder.Message;

end;

function TAbstractMessagesEnumerator.MoveNext: Boolean;
begin

  Result := FMessageListEnumerator.MoveNext;
  
end;

{ TAbstractMessages.TMessageHolder }

constructor TAbstractMessages.TMessageHolder.Create(Message: IMessage);
begin

  inherited Create;

  Self.Message := Message;
  
end;

{ TAbstractMessages }

procedure TAbstractMessages.AddMessageInMessageList(Message: IMessage);
begin

  ValidateMessageType(Message);
  
  FMessageList.Add(TMessageHolder.Create(Message));
  
end;

function TAbstractMessages.AddNewMessage: IMessage;
begin

  Result := CreateMessageInstance;

  PutMessage(Result);
  
end;

procedure TAbstractMessages.Clear;
begin

  FreeListItems(FMessageList);

end;

constructor TAbstractMessages.Create;
begin

  inherited;

  FMessageList := TList.Create;

end;

destructor TAbstractMessages.Destroy;
begin

  FreeListWithItems(FMessageList);
  
  inherited;

end;

function TAbstractMessages.FindHolderForMessage(
  Message: IMessage): TMessageHolder;
var I: Integer;
begin

  for I := 0 to FMessageList.Count - 1 do begin

    Result := TMessageHolder(FMessageList[I]);

    if Result.Message = Message then Exit;

  end;

  Result := nil;

end;

function TAbstractMessages.GetEnumerator: IMessagesEnumerator;
begin

  Result := TAbstractMessagesEnumerator.Create(Self);
  
end;

function TAbstractMessages.GetMessageCount: Integer;
begin

  Result := FMessageList.Count;
  
end;

procedure TAbstractMessages.PutMessage(Message: IMessage);
begin

  AddMessageInMessageList(Message);
  
end;

procedure TAbstractMessages.Remove(Message: IMessage);
var MessageHolder: TMessageHolder;
begin

  MessageHolder := FindHolderForMessage(Message);

  FMessageList.Extract(MessageHolder);

  MessageHolder.Destroy;
  
end;

procedure TAbstractMessages.ValidateMessageType(Message: IMessage);
begin

end;

end.
