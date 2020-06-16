unit PostgresDatabaseMessagingServiceTestFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ZConnection,
  QueryExecutor, QueryDataReader,
  MessagingServiceUnit,
  ZQueryExecutor,
  PostgresDatabaseMessagingService,
  AbstractDatabaseMessagingService,
  StdCtrls;

type
  TPostgresDatabaseMessagingServiceTestForm = class(TForm)
    ZConnection1: TZConnection;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private

    procedure OnMessageSentEventHandler(
      Sender: TObject;
      Message: IMessage
    );

    procedure OnMessageSendingFailedEventHandler(
      Sender: TObject;
      Message: IMessage;
      const Error: Exception
    );
    
  private
    { Private declarations }

    FMessagingService: IMessagingService;

    function CreateMessageInstance: IMessage;
    procedure CreatePostgresDatabaseMessagingService;

    procedure RunSyncMessageSendingTest;
    procedure RunAsyncMessageSendingTest;

  public
    { Public declarations }
  end;

var
  PostgresDatabaseMessagingServiceTestForm: TPostgresDatabaseMessagingServiceTestForm;

implementation

uses

  AuxWindowsFunctionsUnit;
  
{$R *.dfm}

procedure TPostgresDatabaseMessagingServiceTestForm.Button1Click(
  Sender: TObject);
begin

  RunSyncMessageSendingTest
  
end;

procedure TPostgresDatabaseMessagingServiceTestForm.Button2Click(
  Sender: TObject);
begin

  RunAsyncMessageSendingTest;
  
end;

function TPostgresDatabaseMessagingServiceTestForm.CreateMessageInstance: IMessage;
var Message: IMessage;
    Receiver: IMessageMember;
    Attachment: IMessageAttachment;
begin

  Message := FMessagingService.CreateMessageInstance;

  Message.Name := 'TestName';
  Message.Content.Add('TestContent1');
  Message.Content.Add('TestContent2');
  Message.Sender.Identifier := 'rr.nigmatullin.0900@ump.local';
  Message.Sender.DisplayName := 'Нигматуллин Руслан';

  Receiver := Message.Receivers.Add;

  Receiver.Identifier := 'rr.nigmatullin.0900@ump.local';
  Receiver.DisplayName := 'Нигматуллин Руслан';

  Attachment := Message.Attachments.Add;

  Attachment.FilePath :=
    '\\server-file\Test\clp-20190415-1452120.jpg';

  Attachment := Message.Attachments.Add;

  Attachment.FilePath :=
    '\\server-file\Test\2019-10-10 14_22_55-.png';

  Result := Message;
  
end;

procedure TPostgresDatabaseMessagingServiceTestForm.CreatePostgresDatabaseMessagingService;
var SchemaData: TDatabaseMessagingServiceSchemaData;
begin

  SchemaData := TDatabaseMessagingServiceSchemaData.Create;

  SchemaData.MessageTableName := 'sys.sendemail_queue';
  SchemaData.MessageNameColumnName := 'mailsubject';
  SchemaData.MessageContentColumnName := 'mailbody';
  SchemaData.MessageReceiversColumnName := 'mailto';
  SchemaData.MessageAttachmentsColumnName := 'attachments';
  SchemaData.MessageNameQueryParamName := 'p' + SchemaData.MessageNameColumnName;
  SchemaData.MessageContentQueryParamName := 'p' + SchemaData.MessageContentColumnName;
  SchemaData.MessageReceiversQueryParamName := 'p' + SchemaData.MessageReceiversColumnName;
  SchemaData.MessageAttachmentsQueryParamName := 'p' + SchemaData.MessageAttachmentsColumnName;

  FMessagingService :=
    TPostgresDatabaseMessagingService.Create(
      SchemaData,
      TZQueryExecutor.Create(ZConnection1)
    );

end;

procedure TPostgresDatabaseMessagingServiceTestForm.FormCreate(Sender: TObject);
begin

  CreatePostgresDatabaseMessagingService;

end;

procedure TPostgresDatabaseMessagingServiceTestForm.
  OnMessageSendingFailedEventHandler(
    Sender: TObject; Message:
    IMessage;
    const Error: Exception
  );
begin

  ShowErrorMessage(
    Self.Handle,
    Format(
      'Сообщение "%s" не отправлено:' + sLineBreak + '%s',
      [
        Message.Name,
        Error.Message
      ]
    ),
    'Ошибка'
  );
  
end;

procedure TPostgresDatabaseMessagingServiceTestForm.
  OnMessageSentEventHandler(
    Sender: TObject;
    Message: IMessage
  );
begin

  ShowInfoMessage(
    Self.Handle,
    Format(
      'Сообщение "%s" отправлено !',
      [Message.Name]
    ),
    'Сообщение'
  );
  
end;

procedure TPostgresDatabaseMessagingServiceTestForm.RunAsyncMessageSendingTest;
var Message: IMessage;
begin

  Message := CreateMessageInstance;

  FMessagingService.SendMessageAsync(
    Message,
    OnMessageSentEventHandler,
    OnMessageSendingFailedEventHandler
  );
  
end;

procedure TPostgresDatabaseMessagingServiceTestForm.
  RunSyncMessageSendingTest;
var Message: IMessage;
begin

  Message := CreateMessageInstance;

  FMessagingService.SendMessage(Message);
  
end;

end.
