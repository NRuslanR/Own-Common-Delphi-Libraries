unit BaseExcelReportCreatorUnit;

interface
  uses ComObj, SysUtils, Windows, Dialogs, Classes, Graphics, Variants;

  type
    TReportOutputType = (roFile, roPrinter);
    TReportPageOrientation = (poPortrait = 1, poLandscape = 2);
    TCreateReportStatus = (crOk, crFailed, crDiscarded);

    TBaseExcelReportCreator = class
      strict protected
        FReportName: string;
        FColumns: TStrings;
        FReportData: TList;
        FFileName: string;
        FReportNameFont: TFont;
        FColumnsFont: TFont;
        FReportDataFont: TFont;
        FReportOutputType: TReportOutputType;
        FPrintCopyCount: integer;
        FPrinterName: string;
        FPageOrientation: TReportPageOrientation;

        function ActivateExcelApp: Variant;
        procedure InsertTitle(excelApp: Variant);
        procedure InsertColumns(excelApp: Variant);
        procedure InsertReportData(excelApp: Variant);
        procedure ResizeToContent(excelApp: Variant);
        procedure SaveToFile(excelApp: Variant);
        procedure Print(excelApp: Variant);
        procedure OutputReportData(excelApp: Variant);

        procedure DeactivateExcelApp(excelApp: Variant);

        function CreateFont(const Size: integer;
        const Style: TFontStyles; const Name: TFontName; const Color: TColor = clBlack): TFont;

      public
        destructor Destroy; override;

        constructor Create(const ReportOutputType: TReportOutputType = roFile); overload;
        constructor Create(const ReportName: string; const ReportOutputType: TReportOutputType = roFile); overload;
        constructor Create(const ReportName: string; Columns: TStrings; const ReportOutputType: TReportOutputType = roFile); overload;
        constructor Create(const ReportName: string; Columns: TStrings;
                            ReportData: TList; const ReportOutputType: TReportOutputType = roFile); overload;

        property ReportName: string read FReportName write FReportName;
        property Columns: TStrings read FColumns;
        property ReportData: TList read FReportData;
        property ReportNameFont: TFont read FReportNameFont write FReportNameFont;
        property ColumnsFont: TFont read FReportNameFont write FReportNameFont;
        property ReportDataFont: TFont read FReportNameFont write FReportNameFont;
        property FileName : string read FFileName write FFileName;
        property ReportOutputType : TReportOutputType read FReportOutputType write FReportOutputType;
        property PrintCopyCount: integer read FPrintCopyCount write FPrintCopyCount;
        property PrinterName: string read FPrinterName write FPrinterName;
        property PageOrientation: TReportPageOrientation read FPageOrientation write FPageOrientation;

        function AddReportDataRows(ReportDataRows: TList): integer;
        function AddReportDataRow(ReportDataRow: TStrings): integer; overload;
        function AddReportDataRow(ReportDataRow: array of string): integer; overload;
        function RemoveReportDataRow(const RowIdx: integer): boolean;
        function CreateReport: TCreateReportStatus;
        function RemoveColumn(const ColIdx: integer): boolean;
        function AddColumn(Column: string): integer;
        function AddColumns(Columns: TStrings): integer; overload;
        function AddColumns(Columns: array of string): integer; overload;

        procedure ClearReportData;
        procedure ClearColumns;
    end;

implementation

{ TBaseExcelReportCreator }

procedure TBaseExcelReportCreator.ClearColumns;
begin
  FColumns.Clear;
end;

// удаляет данные для построения отчета Excel
procedure TBaseExcelReportCreator.ClearReportData;
var row: TStrings;
    idx: integer;
begin
  for idx := 0 to FReportData.Count - 1 do begin
    row := TStrings(FReportData[idx]);
    row.Free;
  end;
  FReportData.Clear;
end;

constructor TBaseExcelReportCreator.Create(const ReportOutputType: TReportOutputType);
begin
  inherited Create;
  FColumns := TStringList.Create;
  FReportData := TList.Create;
  FReportNameFont := CreateFont(14, [fsBold], 'Arial');
  FColumnsFont := CreateFont(12, [fsBold], 'Arial');
  FReportDataFont := CreateFont(12, [], 'Arial');
  FReportOutputType := ReportOutputType;
  FPageOrientation := poPortrait;
end;

constructor TBaseExcelReportCreator.Create(const ReportName: string;
  Columns: TStrings; const ReportOutputType: TReportOutputType);
begin
  Create(ReportName, ReportOutputType);
  FColumns := Columns;
end;

constructor TBaseExcelReportCreator.Create(const ReportName: string;
  Columns: TStrings; ReportData: TList; const ReportOutputType: TReportOutputType);
begin
  Create(ReportName, Columns, ReportOutputType);
  FReportData := ReportData;
end;

function TBaseExcelReportCreator.CreateFont(const Size: integer;
  const Style: TFontStyles; const Name: TFontName; const Color: TColor): TFont;
begin
  result := TFont.Create;
  result.Style := Style;
  result.Size := Size;
  result.Name := Name;
  result.Color := Color;
end;

function TBaseExcelReportCreator.CreateReport: TCreateReportStatus;
var excelApp: Variant;
begin
try
  try
    excelApp := ActivateExcelApp;
    InsertTitle(excelApp);
    InsertColumns(excelApp);
    InsertReportData(excelApp);
    ResizeToContent(excelApp);
    OutputReportData(excelApp);
    result := crOk;
  except
    on e: EOleException do begin
      if e.ErrorCode = -2146827284 then begin
        result := crDiscarded;
        excelApp.WorkBooks[1].Close(SaveChanges := false);
      end
      else result := crFailed;
    end;
    on e: Exception do
      result := crFailed;
  end;
finally
  if not VarIsNull(excelApp) then begin
    DeactivateExcelApp(excelApp);
  end;
end;
end;

procedure TBaseExcelReportCreator.DeactivateExcelApp(excelApp: Variant);
begin
  excelApp.Quit;
  excelApp := 0;
end;

destructor TBaseExcelReportCreator.Destroy;
begin
  FreeAndNil(FColumns);
  ClearReportData;
  FreeAndNil(FReportData);
  inherited;
end;

function TBaseExcelReportCreator.ActivateExcelApp: Variant;
begin
  result := CreateOleObject('Excel.Application');
  result.Workbooks.Add;
  result.Visible := false;
end;

function TBaseExcelReportCreator.AddColumn(Column: string): integer;
begin
  result := FColumns.Add(Column);
end;

function TBaseExcelReportCreator.AddColumns(Columns: array of string): integer;
var col_name: string;
begin
  result := -1;
  for col_name in Columns do
    result := FColumns.Add(col_name);
end;

function TBaseExcelReportCreator.AddColumns(Columns: TStrings): integer;
begin
  FColumns.AddStrings(Columns);
  result := FColumns.Count - 1;
end;

function TBaseExcelReportCreator.AddReportDataRow(ReportDataRow: TStrings): integer;
begin
  result := FReportData.Add(ReportDataRow);
end;

function TBaseExcelReportCreator.AddReportDataRow(
  ReportDataRow: array of string): integer;
var aux: TStrings;
    cell: string;
begin
  aux := nil;
  try
    try
      aux := TStringList.Create;

      for cell in ReportDataRow do
        aux.Add(cell);

      result := FReportData.Add(Pointer(aux));
    except
     result := -1;
    end;
  finally

  end;
end;

function TBaseExcelReportCreator.AddReportDataRows(
  ReportDataRows: TList): integer;
var row: TStrings;
    idx: integer;
    last_inserted: integer;
begin
  result := -1;
  for idx := 0 to ReportDataRows.Count - 1 do begin
    row := TStrings(ReportDataRows[idx]);
    last_inserted := FReportData.Add(Pointer(row));
  end;
  result := last_inserted;
end;

procedure TBaseExcelReportCreator.InsertColumns(excelApp: Variant);
var Sheet: Variant;
    idx, col_count: integer;
begin
  Sheet := excelApp.Workbooks[1].WorkSheets[1];
  col_count := FColumns.Count;
  Sheet.Rows[2].Font.Bold := fsBold in FColumnsFont.Style;
  Sheet.Rows[2].Font.Size := FColumnsFont.Size;
  Sheet.Rows[2].Font.Color := FColumnsFont.Color;
  Sheet.Rows[2].Font.Name := FColumnsFont.Name;

  for idx := 0 to col_count - 1 do begin
    Sheet.Cells[2,idx + 1] := FColumns[idx];
  end;
end;

procedure TBaseExcelReportCreator.InsertReportData(excelApp: Variant);
var Sheet: Variant;
    idx, row_idx, col_idx: integer;
    row_cells: TStrings;
begin
  Sheet := excelApp.Workbooks[1].WorkSheets[1];
  row_idx := 3;

  for idx := 0 to FReportData.Count - 1 do begin
    Sheet.Rows[row_idx].Font.Bold := fsBold in FReportDataFont.Style;
    Sheet.Rows[row_idx].Font.Size := FReportDataFont.Size;
    Sheet.Rows[row_idx].Font.Color := FReportDataFont.Color;
    Sheet.Rows[row_idx].Font.Name := FReportDataFont.Name;

    row_cells := TStrings(FReportData[idx]);

    for col_idx := 0 to row_cells.Count - 1 do begin
      Sheet.Cells[row_idx, col_idx + 1] := row_cells[col_idx];
    end;

    inc(row_idx);
  end;
end;

procedure TBaseExcelReportCreator.InsertTitle(excelApp: Variant);
var Sheet: Variant;
    titleIdx: integer;
begin
  Sheet := excelApp.Workbooks[1].WorkSheets[1];
  titleIdx := (FColumns.Count shr 1) + (FColumns.Count and 1);

  Sheet.Rows[1].Font.Bold := fsBold in FReportNameFont.Style;;
  Sheet.Rows[1].Font.Size := FReportNameFont.Size;
  Sheet.Rows[1].Font.Color := FReportNameFont.Color;
  Sheet.Rows[1].Font.Name := FReportNameFont.Name;

  Sheet.Cells[1,titleIdx] := FReportName;
end;

procedure TBaseExcelReportCreator.OutputReportData(excelApp: Variant);
begin
  if FReportOutputType = roFile then
    SaveToFile(excelApp)
  else if FReportOutputType = roPrinter then
    Print(excelApp);
end;

procedure TBaseExcelReportCreator.Print(excelApp: Variant);
var WorkBook, Sheet: Variant;
begin
  WorkBook := excelApp.WorkBooks[1];
  Sheet := WorkBook.WorkSheets[1];
  Sheet.PageSetup.Orientation := FPageOrientation;

  Sheet.PrintOut(Copies := FPrintCopyCount, ActivePrinter := FPrinterName);
  WorkBook.Close(SaveChanges := false);
end;

constructor TBaseExcelReportCreator.Create(const ReportName: string; const ReportOutputType: TReportOutputType);
begin
   Create(ReportOutputType);
   FReportName := ReportName;
end;

function TBaseExcelReportCreator.RemoveColumn(const ColIdx: integer): boolean;
begin
  try
    FColumns.Delete(ColIdx);
    result := true;
  except
    result := false;
  end;
end;

function TBaseExcelReportCreator.RemoveReportDataRow(
  const RowIdx: integer): boolean;
begin
  try
    FReportData.Delete(RowIdx);
    result := true;
  except
    result := false;
  end;
end;

procedure TBaseExcelReportCreator.ResizeToContent(excelApp: Variant);
var Sheet, Range, startCell, endCell: Variant;
begin
  Sheet := excelApp.Workbooks[1].WorkSheets[1];
  startCell := Sheet.Cells[2,1];
  endCell := Sheet.Cells[3 + FReportData.Count - 1,FColumns.Count];
  Range := Sheet.Range[startCell, endCell];
  Range.Columns.AutoFit;
end;

procedure TBaseExcelReportCreator.SaveToFile(excelApp: Variant);
begin
  excelApp.Workbooks[1].SaveAs(FFileName);
end;

end.
