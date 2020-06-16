object PostgresDatabaseMessagingServiceTestForm: TPostgresDatabaseMessagingServiceTestForm
  Left = 0
  Top = 0
  Caption = 'PostgresDatabaseMessagingServiceTestForm'
  ClientHeight = 821
  ClientWidth = 1006
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 273
    Height = 25
    Caption = 'Run Sync Message Sending Test'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 39
    Width = 273
    Height = 25
    Caption = 'Run Async Message Sending Test'
    TabOrder = 1
    OnClick = Button2Click
  end
  object ZConnection1: TZConnection
    Protocol = 'postgresql-8'
    HostName = 'srv-pg'
    Port = 5432
    Database = 'ump'
    User = 'u_59968'
    Password = '123456'
    Connected = True
    Left = 8
    Top = 80
  end
end
