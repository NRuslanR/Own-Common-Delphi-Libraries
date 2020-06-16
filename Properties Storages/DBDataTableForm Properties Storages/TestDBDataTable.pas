unit TestDBDataTable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBDataTableFormUnit, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxControls, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, ZConnection, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ActnList, ImgList, PngImageList, cxGridLevel, cxClasses,
  cxGridCustomView, cxGrid, cxButtons, ComCtrls, pngimage, ExtCtrls, StdCtrls,
  ToolWin;

type
  TTestDBDataTableForm = class(TDBDataTableForm)
    ZQuery1: TZQuery;
    ZConnection1: TZConnection;
    DataRecordGridTableViewColumn1: TcxGridDBColumn;
    DataRecordGridTableViewColumn2: TcxGridDBColumn;
    DataRecordGridTableViewColumn3: TcxGridDBColumn;
    DataRecordGridTableViewColumn4: TcxGridDBColumn;
    DataRecordGridTableViewColumn5: TcxGridDBColumn;
  private
    { Private declarations }

  protected

    procedure Init(
      const Caption: String = ''; ADataSet:
      TDataSet = nil
    ); override;
    
  public
    { Public declarations }
  end;

var
  TestDBDataTableForm: TTestDBDataTableForm;

implementation

{$R *.dfm}

{ TDBDataTableForm1 }

procedure TTestDBDataTableForm.Init(const Caption: String; ADataSet: TDataSet);
begin

  inherited;

  MustSaveFilterFormStateBeforeClosing := True;

end;

end.
