object frmMain: TfrmMain
  Left = 192
  Top = 114
  BorderStyle = bsSingle
  Caption = 'SMExport: export from dxDBGrid'
  ClientHeight = 446
  ClientWidth = 631
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dxdbgOrders: TdxDBGrid
    Left = 0
    Top = 48
    Width = 631
    Height = 398
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    KeyField = 'OrderNo'
    ShowGroupPanel = True
    ShowSummaryFooter = True
    SummaryGroups = <
      item
        DefaultGroup = True
        SummaryItems = <
          item
            ColumnName = 'dxdbgOrdersAmountPaid'
            SummaryField = 'AmountPaid'
            SummaryType = cstSum
          end
          item
            ColumnName = 'dxdbgOrdersItemsTotal'
            SummaryField = 'ItemsTotal'
            SummaryType = cstSum
          end
          item
            ColumnName = 'dxdbgOrdersOrderNo'
            SummaryField = 'OrderNo'
            SummaryType = cstCount
          end>
        Name = 'dxdbgOrdersSummaryGroup2'
      end>
    SummarySeparator = ', '
    Align = alBottom
    TabOrder = 0
    DataSource = srcOrders
    Filter.Criteria = {00000000}
    OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
    object dxdbgOrdersOrderNo: TdxDBGridMaskColumn
      BandIndex = 0
      RowIndex = 0
      FieldName = 'OrderNo'
    end
    object dxdbgOrdersCustNo: TdxDBGridMaskColumn
      Sorted = csUp
      Visible = False
      Width = 71
      BandIndex = 0
      RowIndex = 0
      FieldName = 'CustNo'
      SummaryFooterType = cstSum
      SummaryFooterField = 'AmountPaid'
      GroupIndex = 0
      SummaryType = cstCount
      SummaryField = 'OrderNo'
    end
    object dxdbgOrdersSaleDate: TdxDBGridDateColumn
      Width = 75
      BandIndex = 0
      RowIndex = 0
      FieldName = 'SaleDate'
    end
    object dxdbgOrdersShipDate: TdxDBGridDateColumn
      Width = 75
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ShipDate'
    end
    object dxdbgOrdersEmpNo: TdxDBGridMaskColumn
      BandIndex = 0
      RowIndex = 0
      FieldName = 'EmpNo'
    end
    object dxdbgOrdersTerms: TdxDBGridMaskColumn
      Width = 40
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Terms'
    end
    object dxdbgOrdersPaymentMethod: TdxDBGridMaskColumn
      Width = 83
      BandIndex = 0
      RowIndex = 0
      FieldName = 'PaymentMethod'
    end
    object dxdbgOrdersItemsTotal: TdxDBGridCurrencyColumn
      Width = 86
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ItemsTotal'
      SummaryFooterType = cstSum
      SummaryFooterField = 'ItemsTotal'
      Nullable = False
      SummaryType = cstSum
      SummaryField = 'ItemsTotal'
    end
    object dxdbgOrdersAmountPaid: TdxDBGridCurrencyColumn
      Width = 92
      BandIndex = 0
      RowIndex = 0
      FieldName = 'AmountPaid'
      SummaryFooterType = cstSum
      SummaryFooterField = 'AmountPaid'
      Nullable = False
      SummaryType = cstSum
      SummaryField = 'AmountPaid'
    end
  end
  object btnExport: TButton
    Left = 216
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Export'
    TabOrder = 1
    OnClick = btnExportClick
  end
  object srcOrders: TDataSource
    DataSet = tblOrders
    Left = 24
    Top = 16
  end
  object tblOrders: TTable
    Active = True
    DatabaseName = 'DBDEMOS'
    IndexFieldNames = 'CustNo'
    TableName = 'orders.db'
    Left = 64
    Top = 24
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
    KeyGenerator = 'SMExport 4.68'
    SelectedRecord = False
    BlankIfZero = False
    RightToLeft = False
    Statistic.TotalCount = 0
    Statistic.Result = erInProgress
    Columns = <>
    Bands = <>
    DataEngine = SMEdxDBGridDataEngine1
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
    Left = 312
    Top = 16
  end
  object SMEdxDBGridDataEngine1: TSMEdxDBGridDataEngine
    dxDBGrid = dxdbgOrders
    Left = 352
    Top = 16
  end
end
