object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Form5'
  ClientHeight = 734
  ClientWidth = 1016
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    1016
    734)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 16
    Width = 185
    Height = 25
    Caption = 'GetSomeCriterionExpression'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 24
    Top = 8
    Width = 393
    Height = 169
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 8
    Top = 183
    Width = 1000
    Height = 543
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 2
  end
  object Button2: TButton
    Left = 453
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 3
  end
  object Button3: TButton
    Left = 640
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 488
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Button4'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 423
    Top = 136
    Width = 236
    Height = 25
    Caption = 'TestZeosDBRepository'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 552
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button6'
    TabOrder = 7
    OnClick = Button6Click
  end
end
