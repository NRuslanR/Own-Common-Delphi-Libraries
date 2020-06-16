unit SynapseEmailMessagingServiceUnit;

interface

uses

  SysUtils,
  Classes,
  smtpsend,
  mimemess,
  mimepart,
  ssl_openssl,
  synautil,
  AbstractEmailMessagingServiceUnit,
  MessagingServiceUnit;

type

  TSynapseEmailMessagingService = class (TAbstractEmailMessagingService)

    private

      FSMTPClient: TSMTPSend;

      function TransformReceiversInfoToStringForSending(
        MessageReceivers: IMessageMembers
      ): String;

    protected

      procedure ConnectToMailServer; override;

      function EncodeEmailMessageForSending(Message: TEmailMessage): TObject; override;

      procedure SendEncodedEmailMessage(
        EncodedEmailMessage: TObject;
        Sender: IMessageMember;
        Receivers: IMessageMembers
      ); override;

      procedure DisconnectFromMailServer; override;

    public

      destructor Destroy; override;
      constructor Create; override;

  end;

implementation

{ TSynapseEmailMessagingService }

procedure TSynapseEmailMessagingService.ConnectToMailServer;
begin

  FSMTPClient.TargetHost := ServerAddress;
  FSMTPClient.TargetPort := IntToStr(ServerPort);
  FSMTPClient.UserName := UserName;
  FSMTPClient.Password := Password;
  FSMTPClient.FullSSL := UseTLS;

  if FSMTPClient.Login then begin

    if UseTLS then
      if not FSMTPClient.AuthDone then
        raise Exception.Create('Не удалось авторизоваться на почтовом сервере');
  end

  else raise Exception.Create('Не удалось подключиться к почтовому серверу');

end;

constructor TSynapseEmailMessagingService.Create;
begin

  inherited;

  FSMTPClient := TSMTPSend.Create;
  
end;

destructor TSynapseEmailMessagingService.Destroy;
begin

  FreeAndNil(FSMTPClient);
  inherited;
  
end;

procedure TSynapseEmailMessagingService.DisconnectFromMailServer;
begin

  FSMTPClient.Logout;
  
end;

function TSynapseEmailMessagingService.EncodeEmailMessageForSending(
  Message: TEmailMessage
): TObject;
var MimeMessage: TMimeMess;
    MessageRootPart: TMimePart;
    Attachment: IMessageAttachment;
    Attachments: IMessageAttachments;
begin

  MimeMessage := TMimeMess.Create;

  MimeMessage.Header.Subject := Message.Name;
  MimeMessage.Header.From := Message.Sender.Identifier;
  MimeMessage.Header.ToList.DelimitedText :=
    TransformReceiversInfoToStringForSending(Message.Receivers);

  MessageRootPart := MimeMessage.AddPartMultipart('mixed', nil);

  MimeMessage.AddPartText(Message.Content, MessageRootPart);
  
  Attachments := Message.Attachments;

  if Attachments.Count > 0 then begin

    for Attachment in Attachments do begin

      MimeMessage.AddPartBinaryFromFile(
        Attachment.FilePath, MessageRootPart
      );

    end;
    
  end;

  MimeMessage.EncodeMessage;

  Result := MimeMessage;
  
end;

procedure TSynapseEmailMessagingService.SendEncodedEmailMessage(
  EncodedEmailMessage: TObject;
  Sender: IMessageMember;
  Receivers: IMessageMembers
);
var MimeMessage: TMimeMess;
    Receiver: IMessageMember;
begin

  MimeMessage := EncodedEmailMessage as TMimeMess;

  if not FSMTPClient.MailFrom(Sender.Identifier, 0) then
    raise Exception.Create(
            'Не удалось передать информацию ' +
            'об отправителе почтового сообщения'
          );

  for Receiver in Receivers do begin

     if not FSMTPClient.MailTo(Receiver.Identifier) then
      raise Exception.CreateFmt(
              'Не удалось передать информацию ' +
              'о получателе "%s, %s" почтового сообщения',
              [Receiver.Identifier, Receiver.DisplayName]
            );

  end;

  if not FSMTPClient.MailData(MimeMessage.Lines) then
    raise Exception.Create(
            'Не удалось передать данные почтового сообщения'
          );
  
end;

function TSynapseEmailMessagingService.TransformReceiversInfoToStringForSending(
  MessageReceivers: IMessageMembers
): String;
var MessageReceiver: IMessageMember;
    MessageReceiverInfoString: String;
begin

  Result := '';

  for MessageReceiver in MessageReceivers do begin

    MessageReceiverInfoString :=
      '"' + MessageReceiver.DisplayName + '"' +
      ' <' + MessageReceiver.Identifier + '>';

    if Result = '' then
      Result := MessageReceiverInfoString

    else Result := Result + ', ' + MessageReceiverInfoString;

  end;

end;

end.
