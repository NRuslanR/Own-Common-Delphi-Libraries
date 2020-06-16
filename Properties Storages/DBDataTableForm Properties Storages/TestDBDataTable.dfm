inherited TestDBDataTableForm: TTestDBDataTableForm
  Caption = 'TestDBDataTableForm'
  ExplicitWidth = 761
  ExplicitHeight = 714
  PixelsPerInch = 96
  TextHeight = 13
  inherited DataOperationToolBar: TToolBar
    inherited RefreshSeparator: TToolButton
      ExplicitHeight = 44
    end
    inherited ExportDataToolButton: TToolButton
      ExplicitWidth = 81
    end
  end
  inherited DataRecordMovingToolBar: TToolBar
    inherited FirstDataRecordToolButton: TToolButton
      ExplicitWidth = 24
    end
    inherited PrevDataRecordToolButton: TToolButton
      ExplicitWidth = 24
    end
    inherited NextDataRecordToolButton: TToolButton
      ExplicitWidth = 24
    end
    inherited LastDataRecordToolButton: TToolButton
      ExplicitWidth = 24
    end
  end
  inherited ClientAreaPanel: TPanel
    inherited DataRecordGrid: TcxGrid
      inherited DataRecordGridTableView: TcxGridDBTableView
        object DataRecordGridTableViewColumn1: TcxGridDBColumn
          Caption = #1048#1084#1103
          DataBinding.FieldName = 'name'
          Width = 200
        end
        object DataRecordGridTableViewColumn2: TcxGridDBColumn
          Caption = #1060#1072#1084#1080#1083#1080#1103
          DataBinding.FieldName = 'surname'
          Width = 94
        end
        object DataRecordGridTableViewColumn3: TcxGridDBColumn
          DataBinding.FieldName = 'is_foreign'
          Width = 139
        end
        object DataRecordGridTableViewColumn4: TcxGridDBColumn
          DataBinding.FieldName = 'department_id'
          Width = 117
        end
        object DataRecordGridTableViewColumn5: TcxGridDBColumn
          DataBinding.FieldName = 'today'
          Width = 161
        end
      end
    end
  end
  inherited TargetDataSource: TDataSource
    DataSet = ZQuery1
  end
  object ZQuery1: TZQuery
    Connection = ZConnection1
    Active = True
    SQL.Strings = (
      'select *, now() today from doc.v_employees')
    Params = <>
    Left = 496
    Top = 64
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
end
