unit TableViewFilterFormFilterBuilderUnit;

interface

uses SysUtils, Classes, TableViewFilterFormUnit,
     cxGraphics, cxControls, cxLookAndFeels,
     cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinsDefaultPainters,
     dxSkinscxPC3Painter, cxCustomData, cxFilter, cxData, cxDataStorage,
     cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
     cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Grids;

type

  TFilterCondition = (

    fcEqual,
    fcNotEqual,
    fcLess,
    fcGreater,
    fcLessEqual,
    fcGreaterEqual,
    fcLike,
    fcNotLike,
    fcBetween,
    fcNotBetween

  );

  TTableViewFilterFormFilterBuilder = class abstract (TObject)

    strict protected

      FTableViewFilterForm: TTableViewFilterForm;

    public

      destructor Destroy; override;
      constructor Create(ATableViewFilterForm: TTableViewFilterForm);

      procedure AddFilterExpression(
        AItem: TObject;
        const ACondition: TFilterCondition;
        const AValue

      ); virtual; abstract;

      procedure ApplyFilter; virtual; abstract;

  end;

implementation

{ TTableViewFilterFormFilterBuilder }

constructor TTableViewFilterFormFilterBuilder.Create(
  ATableViewFilterForm: TTableViewFilterForm);
begin

  inherited Create;

  FTableViewFilterForm := ATableViewFilterForm;
  
end;

destructor TTableViewFilterFormFilterBuilder.Destroy;
begin

  inherited;

end;

end.
