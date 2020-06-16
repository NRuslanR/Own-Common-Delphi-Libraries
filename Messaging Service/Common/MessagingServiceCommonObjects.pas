unit MessagingServiceCommonObjects;

interface

uses

  IGetSelfUnit,
  MessagingServiceUnit,
  SysUtils,
  Classes;

type

  TCommonMessageMember = class (TInterfacedObject, IMessageMember)

    protected

      FIdentifier: Variant;
      FDisplayName: String;
      
    public

      constructor Create;

      function GetIdentifier: Variant;
      procedure SetIdentifier(const Value: Variant);

      function GetDisplayName: String;
      procedure SetDisplayName(const Value: String);

      property Identifier: Variant read GetIdentifier write SetIdentifier;
      property DisplayName: String read GetDisplayName write SetDisplayName;

  end;
  
  TCommonMessageMembers = class (TAbstractMessageMembers)

    protected

      function CreateMessageMemberInstance: IMessageMember; override;
      
  end;
  
  TCommonMessage = class (TInterfacedObject, IMessage)

    protected

      FName: String;
      FContent: TStringList;
      FSender: IMessageMember;
      FReceivers: IMessageMembers;
      FAttachments: IMessageAttachments;
      
    public

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

      property Name: String read GetName write SetName;
      property Content: TStrings read GetContent write SetContent;
      property Sender: IMessageMember read GetSender;
      property Receivers: IMessageMembers read GetReceivers;
      property Attachments: IMessageAttachments read GetAttachments;

  end;

  TCommonMessages = class (TAbstractMessages)

    protected

      function CreateMessageInstance: IMessage; override;

    public

      constructor Create; override;
      
  end;

  TCommonMessageAttachment = class (TInterfacedObject, IMessageAttachment)

    protected

      FFilePath: String;
      
    public

      function GetFilePath: String;
      procedure SetFilePath(const FilePath: String);

      property FilePath: String read GetFilePath write SetFilePath;

  end;

  TCommonMessageAttachments = class (TAbstractMessageAttachments)

    protected

      function CreateMessageAttachmentInstance: IMessageAttachment; override;
    
  end;

implementation

uses

  Variants;
  
{ TCommonMessageMember }

constructor TCommonMessageMember.Create;
begin

  inherited;

  FIdentifier := Null;
  
end;

function TCommonMessageMember.GetDisplayName: String;
begin

  Result := FDisplayName;

end;

function TCommonMessageMember.GetIdentifier: Variant;
begin

  Result := FIdentifier;

end;

procedure TCommonMessageMember.SetDisplayName(const Value: String);
begin

  FDisplayName := Value;
  
end;

procedure TCommonMessageMember.SetIdentifier(const Value: Variant);
begin

  FIdentifier := Value;
  
end;

{ TCommonMessageMembers }

function TCommonMessageMembers.CreateMessageMemberInstance: IMessageMember;
begin

  Result := TCommonMessageMember.Create;
  
end;

{ TCommonMessage }

constructor TCommonMessage.Create;
begin

  inherited;

  FContent := TStringList.Create;
  FSender := TCommonMessageMember.Create;
  FReceivers := TCommonMessageMembers.Create;
  FAttachments := TCommonMessageAttachments.Create;
  
end;

function TCommonMessage.GetAttachments: IMessageAttachments;
begin

  Result := FAttachments;
  
end;

function TCommonMessage.GetContent: TStrings;
begin

  Result := FContent;
  
end;

function TCommonMessage.GetName: String;
begin

  Result := FName;
  
end;

function TCommonMessage.GetReceivers: IMessageMembers;
begin

  Result := FReceivers;

end;

function TCommonMessage.GetSelf: TObject;
begin

  Result := Self;
  
end;

function TCommonMessage.GetSender: IMessageMember;
begin

  Result := FSender;
  
end;

procedure TCommonMessage.SetContent(const Value: TStrings);
begin

  FContent.Assign(Value);
  
end;

procedure TCommonMessage.SetContentAsText(const Text: String);
begin

  FContent.Text := Text;

end;

procedure TCommonMessage.SetName(const Value: String);
begin

  FName := Value;
  
end;

{ TCommonMessageAttachment }

function TCommonMessageAttachment.GetFilePath: String;
begin

  Result := FFilePath;

end;

procedure TCommonMessageAttachment.SetFilePath(const FilePath: String);
begin

  FFilePath := FilePath;
  
end;

{ TCommonMessageAttachments }

function TCommonMessageAttachments.CreateMessageAttachmentInstance: IMessageAttachment;
begin

  Result := TCommonMessageAttachment.Create;
  
end;

{ TCommonMessages }

constructor TCommonMessages.Create;
begin

  inherited;

end;

function TCommonMessages.CreateMessageInstance: IMessage;
begin

  Result := TCommonMessage.Create;
  
end;

end.
