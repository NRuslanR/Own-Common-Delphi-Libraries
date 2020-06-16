object frmMain: TfrmMain
  Left = 192
  Top = 114
  Width = 376
  Height = 95
  Caption = 'SMExport: save the bmp-file  to MS Word'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000BBB00BB00000000BBBBB0B000000000B00BB00B000000000B0B
    BBBBAAAAAA00BB00BBB00A0000A00000000000A0A0A0B000000B00A0A000BBBB
    BBBB00AAAA00BBB0000B00A00A0000BBB00000A00A0A000BBBBB000A000A00BB
    B00000AAAAAABBB0000B00000000BBBBBBBB00000000B000000B00000000FFFF
    00008CFF000005FF000066FF0000A003000031BD0000FFD500007ED7000000C3
    00001EDB0000C7DA0000E0EE0000C7C000001EFF000000FF00007EFF0000}
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlAction: TPanel
    Left = 0
    Top = 0
    Width = 368
    Height = 41
    Align = alTop
    TabOrder = 0
    object lblURL: TLabel
      Left = 32
      Top = 16
      Width = 128
      Height = 13
      Cursor = crHandPoint
      Caption = 'http://www.scalabium.com'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object btnExport: TButton
      Left = 264
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Export'
      TabOrder = 0
      OnClick = btnExportClick
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    DefaultExt = 'bmp'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 184
    Top = 16
  end
  object SMExportToWord1: TSMExportToWord
    AnimatedStatus = True
    DataFormats.DateSeparator = '/'
    DataFormats.TimeSeparator = ':'
    DataFormats.FourDigitYear = True
    DataFormats.LeadingZerosInDate = True
    DataFormats.ThousandSeparator = #160
    DataFormats.DecimalSeparator = ','
    DataFormats.CurrencyString = #1088'.'
    DataFormats.BooleanTrue = 'True'
    DataFormats.BooleanFalse = 'False'
    DataFormats.UseRegionalSettings = False
    KeyGenerator = 'SMExport 4.61'
    SelectedRecord = False
    BlankIfZero = False
    RightToLeft = False
    Statistic.TotalCount = 0
    Statistic.Result = erInProgress
    Columns = <>
    DataEngine = SMEVirtualDataEngine1
    ColumnSource = csDataEngine
    FileName = 'SMExport.DOC'
    AddTitle = True
    CharacterSet = csANSI_WINDOWS
    ExportStyle.Style = esNormal
    ExportStyle.OddColor = clBlack
    ExportStyle.EvenColor = clBlack
    Left = 224
    Top = 32
  end
  object SMEVirtualDataEngine1: TSMEVirtualDataEngine
    OnFirst = SMEVirtualDataEngine1First
    OnNext = SMEVirtualDataEngine1Next
    OnCount = SMEVirtualDataEngine1Count
    OnFillColumns = SMEVirtualDataEngine1FillColumns
    OnGetValue = SMEVirtualDataEngine1GetValue
    Left = 256
    Top = 32
  end
end
