object frmMain: TfrmMain
  Left = 192
  Top = 114
  BorderStyle = bsSingle
  Caption = 'SMExport: dxTreeList export'
  ClientHeight = 405
  ClientWidth = 582
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
  PixelsPerInch = 96
  TextHeight = 13
  object dxtData: TdxTreeList
    Left = 0
    Top = 72
    Width = 582
    Height = 333
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    Align = alBottom
    TabOrder = 0
    TreeLineColor = clGrayText
    Data = {
      FFFFFFFF05000000180000000000000000000000FFFFFFFF0000000000000000
      04000000020000004131040000004A6F686E030000003333330A00000032322F
      30352F32303034180000000000000000000000FFFFFFFF000000000000000004
      000000020000004132050000004D617269650200000036360A00000031322F30
      352F32303033180000000000000000000000FFFFFFFF00000000000000000400
      0000020000004231050000005065746572030000003234350A00000030352F30
      392F31393938180000000000000000000000FFFFFFFF00000000000000000400
      00000200000042320700000057696C6C69616D0200000036300A00000030332F
      30322F32303030180000000000000000000000FFFFFFFF000000000000000004
      000000020000004233050000005361726168030000003336350A00000031382F
      31312F32303031}
    object dxtlcDxTreeList1Column1: TdxTreeListColumn
      Caption = 'Code'
      BandIndex = 0
      RowIndex = 0
    end
    object dxtlcDxTreeList1Column2: TdxTreeListColumn
      Caption = 'Name'
      BandIndex = 0
      RowIndex = 0
    end
    object dxTreeList1Column3: TdxTreeListCalcColumn
      Caption = 'Value'
      BandIndex = 0
      RowIndex = 0
    end
    object dxTreeList1Column4: TdxTreeListDateColumn
      Caption = 'Last date'
      BandIndex = 0
      RowIndex = 0
    end
  end
  object btnExport: TButton
    Left = 176
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Export'
    TabOrder = 1
    OnClick = btnExportClick
  end
  object smeWizard: TSMEWizardDlg
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
    KeyGenerator = 'SMExport 4.50'
    SelectedRecord = False
    BlankIfZero = False
    RightToLeft = False
    Columns = <>
    DataEngine = SMEdxTreeListDataEngine1
    ColumnSource = csDataEngine
    Formats = [teParadox, teDBase, teText, teHTML, teXLS, teExcel, teWord, teSYLK, teDIF, teWKS, teQuattro, teSQL, teXML, teAccess, teClipboard, teRTF, teSPSS, tePDF, teLDIF]
    WizardStyle = wsWindows2000
    RecordSeparator = #13#10
    Fixed = False
    TableType = teText
    FileName = 'SMExport.TXT'
    AddTitle = True
    CharacterSet = csANSI_WINDOWS
    ExportStyle.Style = esNormal
    ExportStyle.OddColor = clBlack
    ExportStyle.EvenColor = clBlack
    UserAccess.Specification = True
    Left = 32
    Top = 40
  end
  object SMEdxTreeListDataEngine1: TSMEdxTreeListDataEngine
    dxTreeList = dxtData
    Left = 80
    Top = 40
  end
end
