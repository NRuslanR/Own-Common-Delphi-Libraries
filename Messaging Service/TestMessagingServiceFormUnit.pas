unit TestMessagingServiceFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP,
  IdMessage, IdAttachment, IdAttachmentFile, IdEMailAddress,
  IdSSLOpenSSL, StdCtrls;

type
  TForm5 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }

    procedure TestEmailMessageService;

  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses

  MessagingServiceUnit,
  AuxDebugFunctionsUnit,
  ssl_openssl,
  blcksock,
  SynapseEmailMessagingServiceUnit, AbstractEmailMessagingServiceUnit;

{$R *.dfm}

procedure TForm5.Button1Click(Sender: TObject);
begin

  TestEmailMessageService;

end;

procedure TForm5.TestEmailMessageService;
var MessagingService: IMessagingService; //TSynapseEmailMessagingService;
    Message: IMessage;
    MessageMembers: IMessageMembers;
    Vitaly, Ruslan: IMessageMember;
    Attachments: IMessageAttachments;
    Attachment: IMessageAttachment;
begin

  MessagingService := TSynapseEmailMessagingService.Create;

  with MessagingService.Self as TSynapseEmailMessagingService do begin

    UserName := 'rr.nigmatullin.0900';
    Password := 'Brainsort123';
    ServerAddress := 'postfix.ump.local';
    ServerPort := 465;
    UseTLS := True;

  end;

  Message := MessagingService.CreateMessageInstance;

  Message.Name := 'Тестовая тема (Тестовая тема (Тестовая тема))';
  Message.Content.Add('(Исходящий) Номер документа: НЕТ НОМЕРА ДОК-А');
  Message.Content.Add('Название документа: НЕТ НАЗВАНИЯ');
  Message.Content.Add('Содержание документа: НЕТ СОДЕРЖАНИЯ');
  Message.Content.Add('Дата создания: ' + DateToStr(Now));
  Message.Content.Add('Примечания: ДОКУМЕНТИКООБОРОТ !!! ДОКУМЕНТООБОРОТ !!!');

  Message.Sender.Identifier := 'rr.nigmatullin.0900@ump.local';
  Message.Sender.DisplayName := 'Нигматулин Руслан';

  MessageMembers := Message.Receivers;
  
  Vitaly := MessageMembers.Add;

  Vitaly.Identifier := 'vv.belanov.0900@ump.local';
  Vitaly.DisplayName := 'Виталий Беланов';

  Ruslan := MessageMembers.Add;

  Ruslan.Identifier := 'rr.nigmatullin.0900@ump.local';
  Ruslan.DisplayName := 'Нигматулин Руслан';

  Attachments := Message.Attachments;

  Attachment := Attachments.Add;

  Attachment.FilePath :=
    'C:\Documents and Settings\59968\Рабочий стол\DelphiExamples2\БР2.997.000 МЭ\БР2.997.000 МЭ.pdf';

  Attachment := Attachments.Add;

  Attachment.FilePath :=
    'C:\Documents and Settings\59968\Рабочий стол\DelphiExamples2\БР2.964.022 Сапун\БР2.964.022 Сапун.pdf';

  Attachment := Attachments.Add;

  Attachment.FilePath :=
    'C:\Documents and Settings\59968\Мои документы\Borland Studio Projects\Desktop Document Flow System\Foundations\Tasks\Задачи текущие1.xls';

  Attachment := Attachments.Add;
  
  Attachment.FilePath :=
    'C:\Documents and Settings\59968\Мои документы\Borland Studio Projects\Desktop Document Flow System\Foundations\Tasks\manager_new.doc';

  MessagingService.SendMessage(Message);

end;

end.
