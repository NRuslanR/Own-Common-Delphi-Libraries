inherited DBDataTableForm3: TDBDataTableForm3
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'DBDataTableForm3'
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
        OnEditing = DataRecordGridTableViewEditing
        OnEditChanged = DataRecordGridTableViewEditChanged
        OnEditValueChanged = DataRecordGridTableViewEditValueChanged
      end
    end
  end
  inherited DataOperationActionList: TActionList
    inherited actExit: TAction
      Visible = False
    end
  end
  inherited TargetDataSource: TDataSource
    DataSet = ZQuery1
  end
  object ZQuery1: TZQuery
    Connection = ZConnection1
    SQL.Strings = (
      'select * from omo.spr_services')
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
