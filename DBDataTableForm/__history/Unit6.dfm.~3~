inherited DBDataTableForm6: TDBDataTableForm6
  Caption = 'DBDataTableForm6'
  PixelsPerInch = 96
  TextHeight = 13
  inherited SearchByColumnPanel: TScrollBox
    inherited btnPrevFoundOccurrence: TcxButton
      LookAndFeel.SkinName = ''
    end
    inherited btnNextFoundOccurrence: TcxButton
      LookAndFeel.SkinName = ''
    end
  end
  inherited ClientAreaPanel: TPanel
    inherited DataRecordGrid: TcxGrid
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
    object Button1: TButton
      Left = 560
      Top = 6
      Width = 107
      Height = 25
      Caption = 'enable/disable'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  inherited TargetDataSource: TDataSource
    DataSet = ZQuery1
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
    Protocol = 'postgresql-8'
    HostName = 'srv-pg2'
    Port = 5432
    Database = 'ump_nightly'
    User = 'u_59968'
    Password = '123456'
    Connected = True
    Left = 528
    Top = 64
  end
  object ZUpdateSQL1: TZUpdateSQL
    UseSequenceFieldForRefreshSQL = False
    Left = 560
    Top = 64
  end
end
