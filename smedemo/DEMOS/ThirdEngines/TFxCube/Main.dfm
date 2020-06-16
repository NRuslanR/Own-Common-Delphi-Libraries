object frmMain: TfrmMain
  Left = 192
  Top = 114
  Width = 696
  Height = 480
  Caption = 'SMExport: TFxCube export'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object FxGrid1: TFxGrid
    Left = 0
    Top = 64
    Width = 688
    Height = 382
    DefaultColWidth = 100
    DefaultRowHeight = 20
    CaptionColor = clActiveCaption
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clCaptionText
    CaptionFont.Height = -11
    CaptionFont.Name = 'MS Sans Serif'
    CaptionFont.Style = []
    DataColor = clInfoBk
    DataSumColor = clNone
    DataFont.Charset = DEFAULT_CHARSET
    DataFont.Color = clWindowText
    DataFont.Height = -11
    DataFont.Name = 'MS Sans Serif'
    DataFont.Style = []
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    LabelColor = clBtnFace
    LabelSumColor = clInactiveCaption
    LabelSumFont.Charset = DEFAULT_CHARSET
    LabelSumFont.Color = clWindowText
    LabelSumFont.Height = -11
    LabelSumFont.Name = 'MS Sans Serif'
    LabelSumFont.Style = []
    DecisionSource = FxSource1
    Dimensions = <
      item
        Color = clNone
        Alignment = taLeftJustify
        Subtotals = True
        Width = 80
      end
      item
        Color = clNone
        Alignment = taLeftJustify
        Subtotals = True
        Width = 80
      end
      item
        Color = clNone
        Alignment = taLeftJustify
        Subtotals = True
        Width = 80
      end
      item
        Color = clNone
        Alignment = taLeftJustify
        Subtotals = True
        Width = 80
      end>
    Totals = True
    ShowCubeEditor = False
    Align = alBottom
    Color = clBtnFace
    GridLineWidth = 1
    GridLineColor = clWindowText
    TabOrder = 0
  end
  object btnExport: TButton
    Left = 224
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Export'
    TabOrder = 1
    OnClick = btnExportClick
  end
  object FxCube1: TFxCube
    Active = True
    DataSet = tblTable1
    DimensionMap = <
      item
        FieldName = 'CustNo'
        Name = 'Customer'
        Params = 0
        ValueCount = 54
      end
      item
        BinType = binMonth
        FieldName = 'SaleDate'
        Name = 'SaleDate'
        Params = 0
        StartDate = 37987.000000000000000000
        ValueCount = 49
      end
      item
        FieldName = 'PaymentMethod'
        Name = 'Payment'
        Params = 0
        ValueCount = 7
      end
      item
        DimensionType = dimSum
        FieldName = 'ItemsTotal'
        Name = 'Total'
        Params = 0
        ValueCount = 0
      end>
    ShowProgressDialog = True
    Left = 48
    Top = 24
  end
  object FxSource1: TFxSource
    ControlType = xtCheck
    DecisionCube = FxCube1
    Left = 88
    Top = 24
    DimensionCount = 3
    SummaryCount = 1
    CurrentSummary = 0
    SparseRows = False
    SparseCols = False
    DimensionInfo = (
      2
      0
      1
      0
      -1
      'Customer'
      1
      0
      1
      0
      -1
      'SaleDate'
      1
      1
      1
      1
      -1
      'Payment')
  end
  object tblTable1: TTable
    Active = True
    DatabaseName = 'DBDEMOS'
    TableName = 'orders.db'
    Left = 8
    Top = 16
  end
  object SMEWizardDlg1: TSMEWizardDlg
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
    KeyGenerator = 'SMExport 4.64'
    SelectedRecord = False
    BlankIfZero = False
    RightToLeft = False
    Statistic.TotalCount = 0
    Statistic.Result = erInProgress
    Columns = <>
    DataEngine = SMEFxCubeDataEngine1
    ColumnSource = csDataEngine
    Formats = [teParadox, teDBase, teText, teHTML, teXLS, teExcel, teWord, teSYLK, teDIF, teWKS, teQuattro, teSQL, teXML, teAccess, teClipboard, teRTF, teSPSS, tePDF, teLDIF]
    RecordSeparator = #13#10
    Fixed = False
    TableType = teText
    FileName = 'SMExport.TXT'
    AddTitle = False
    CharacterSet = csANSI_WINDOWS
    ExportStyle.Style = esNormal
    ExportStyle.OddColor = clBlack
    ExportStyle.EvenColor = clBlack
    UserAccess.Specification = True
    Left = 128
    Top = 16
  end
  object SMEFxCubeDataEngine1: TSMEFxCubeDataEngine
    DecisionGrid = FxGrid1
    Left = 168
    Top = 24
  end
end
