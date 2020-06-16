inherited DBDataTableForm6: TDBDataTableForm6
  Caption = 'DBDataTableForm6'
  PixelsPerInch = 96
  TextHeight = 13
  inherited DataOperationToolBar: TToolBar
    Height = 88
    ButtonHeight = 38
    ButtonWidth = 72
    ExplicitHeight = 88
    inherited ChooseRecordsToolButton: TToolButton
      ExplicitWidth = 72
      ExplicitHeight = 38
    end
    inherited ChooseRecordsSeparator: TToolButton
      Left = 72
      ExplicitLeft = 72
      ExplicitHeight = 38
    end
    inherited AddDataToolButton: TToolButton
      Left = 80
      ExplicitLeft = 80
      ExplicitWidth = 72
      ExplicitHeight = 38
    end
    inherited CopySelectedDataRecordsToolButton: TToolButton
      Left = 152
      ExplicitLeft = 152
      ExplicitWidth = 72
      ExplicitHeight = 38
    end
    inherited ChangeDataToolButton: TToolButton
      Left = 224
      ExplicitLeft = 224
      ExplicitWidth = 72
      ExplicitHeight = 38
    end
    inherited DeleteDataToolButton: TToolButton
      Left = 296
      ExplicitLeft = 296
      ExplicitWidth = 72
      ExplicitHeight = 38
    end
    inherited RefreshDataToolButton: TToolButton
      Left = 368
      ExplicitLeft = 368
      ExplicitWidth = 72
      ExplicitHeight = 38
    end
    inherited ReserveToolButton1: TToolButton
      Left = 440
      ExplicitLeft = 440
      ExplicitWidth = 72
      ExplicitHeight = 38
    end
    inherited ReserveToolButton2: TToolButton
      Left = 512
      ExplicitLeft = 512
      ExplicitWidth = 72
      ExplicitHeight = 38
    end
    inherited RefreshSeparator: TToolButton
      ExplicitHeight = 46
    end
    inherited SelectFilterDataToolButton: TToolButton
      Top = 46
      ExplicitTop = 46
      ExplicitWidth = 72
      ExplicitHeight = 38
    end
    inherited SelectFilteredRecordsSeparator: TToolButton
      Left = 72
      Top = 46
      ExplicitLeft = 72
      ExplicitTop = 46
      ExplicitHeight = 38
    end
    inherited PrintDataToolButton: TToolButton
      Left = 80
      Top = 46
      ExplicitLeft = 80
      ExplicitTop = 46
      ExplicitWidth = 72
      ExplicitHeight = 38
    end
    inherited ExportDataToolButton: TToolButton
      Left = 152
      Top = 46
      ExplicitLeft = 152
      ExplicitTop = 46
      ExplicitWidth = 87
      ExplicitHeight = 38
    end
    inherited ExportDataSeparator: TToolButton
      Left = 239
      Top = 46
      ExplicitLeft = 239
      ExplicitTop = 46
      ExplicitHeight = 38
    end
    inherited ExitToolButton: TToolButton
      Left = 247
      Top = 46
      ExplicitLeft = 247
      ExplicitTop = 46
      ExplicitWidth = 72
      ExplicitHeight = 38
    end
  end
  inherited SearchByColumnPanel: TScrollBox
    inherited btnPrevFoundOccurrence: TcxButton
      LookAndFeel.SkinName = ''
    end
    inherited btnNextFoundOccurrence: TcxButton
      LookAndFeel.SkinName = ''
    end
  end
  inherited DataRecordMovingToolBar: TToolBar
    Top = 88
  end
  inherited ClientAreaPanel: TPanel
    Top = 110
    Height = 520
    inherited DataLoadingCanceledPanel: TPanel
      Top = 60
    end
    inherited WaitDataLoadingPanel: TPanel
      Top = 140
    end
    inherited DataRecordGrid: TcxGrid
      Height = 518
      inherited DataRecordGridTableView: TcxGridDBTableView
        object cxgrdbclmnDataRecordGridTableViewColumn1: TcxGridDBColumn
          DataBinding.FieldName = 'name'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 200
        end
        object DataRecordGridTableViewColumn1: TcxGridDBColumn
          DataBinding.FieldName = 'surname'
          Width = 200
        end
        object DataRecordGridTableViewColumn2: TcxGridDBColumn
          DataBinding.FieldName = 'patronymic'
          Width = 200
        end
      end
    end
  end
  inherited imgLstDisabled: TPngImageList
    Bitmap = {}
  end
  inherited imgLstEnabled: TPngImageList
    Bitmap = {}
  end
  object ZQuery1: TZQuery
    Connection = ZConnection1
    UpdateObject = ZUpdateSQL1
    SQL.Strings = (
      'with make_delay as (select pg_sleep(5))'
      'select '
      'name, surname, patronymic'
      'from doc.v_employees'
      'join make_delay on true')
    Params = <>
    Left = 496
    Top = 64
    object ZQuery1name: TStringField
      FieldName = 'name'
      Size = 200
    end
    object ZQuery1surname: TStringField
      FieldName = 'surname'
      Size = 200
    end
    object ZQuery1patronymic: TStringField
      FieldName = 'patronymic'
      Size = 200
    end
  end
  object ZConnection1: TZConnection
    ControlsCodePage = cCP_UTF16
    HostName = 'srv-pg2'
    Port = 5432
    Database = 'ump_nightly'
    User = 'u_59968'
    Password = '123456'
    Protocol = 'postgresql-8'
    Left = 528
    Top = 64
  end
  object ZUpdateSQL1: TZUpdateSQL
    UseSequenceFieldForRefreshSQL = False
    Left = 560
    Top = 64
  end
end
