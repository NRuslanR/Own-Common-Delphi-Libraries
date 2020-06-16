unit TableData;

interface

uses

  SysUtils;

type

  ITableData = interface

    function RowCount: Integer;
    function ColumnCount: Integer;

    function GetCellValue(RowIndex, ColumnIndex: Integer): Variant;
    procedure SetCellValue(RowIndex, ColumnIndex: Integer; Value: Variant);

    property CellValues[RowIndex, ColumnIndex: Integer]: Variant
    read GetCellValue write SetCellValue; default;
    
  end;

implementation

end.
