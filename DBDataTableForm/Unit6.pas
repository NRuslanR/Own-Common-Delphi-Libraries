unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBDataTableFormUnit, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxControls, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, ZConnection, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ActnList, ImgList, PngImageList, cxGridLevel, cxClasses,
  cxGridCustomView, cxGrid, cxButtons, ComCtrls, pngimage, ExtCtrls, StdCtrls,
  ToolWin, cxTextEdit, ZSqlUpdate, cxLocalization,
  ZAbstractConnection, PngFunctions, dxSkinscxPC3Painter;

type
  TDBDataTableForm6 = class(TDBDataTableForm)
    ZQuery1: TZQuery;
    ZConnection1: TZConnection;
    cxgrdbclmnDataRecordGridTableViewColumn1: TcxGridDBColumn;
    DataRecordGridTableViewColumn1: TcxGridDBColumn;
    DataRecordGridTableViewColumn2: TcxGridDBColumn;
    ZQuery1name: TStringField;
    ZQuery1surname: TStringField;
    ZQuery1patronymic: TStringField;
    ZUpdateSQL1: TZUpdateSQL;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DBDataTableForm6: TDBDataTableForm6;

implementation

{$R *.dfm}

procedure TDBDataTableForm6.Button1Click(Sender: TObject);
begin

  ViewOnly := not ViewOnly;

end;

end.
