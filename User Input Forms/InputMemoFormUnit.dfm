object InputMemoForm: TInputMemoForm
  Left = 0
  Top = 0
  Caption = 'InputMemoForm'
  ClientHeight = 175
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    386
    175)
  PixelsPerInch = 96
  TextHeight = 13
  object InputMemo: TMemo
    Left = 8
    Top = 8
    Width = 370
    Height = 128
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    ExplicitHeight = 153
  end
  object OKButton: TcxButton
    Left = 216
    Top = 142
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1050
    Default = True
    TabOrder = 1
    OnClick = OKButtonClick
    ExplicitTop = 167
  end
  object CancelButton: TcxButton
    Left = 303
    Top = 142
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = CancelButtonClick
    ExplicitTop = 167
  end
end
