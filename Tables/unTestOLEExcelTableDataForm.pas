unit unTestOLEExcelTableDataForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OLEExcelTableData, TableData, StdCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private

    procedure TestOleExcelTableData;

  public

  end;

var
  Form3: TForm3;

implementation

uses

  AuxDebugFunctionsUnit;
  
{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin

  TestOleExcelTableData;

end;

procedure TForm3.TestOleExcelTableData;
var TableData: ITableData;
    I, J: Integer;
    Value: Variant;
begin

  TableData :=
    TOLEExcelTableData.Create(
      'C:\Users\admin\Documents\Code Gear\Projects\' +
      'FuelCharacteristicsAccountingSystem\����������' +
      ' ������\����������\��_�����������62.xlsx'
    );
    
  for I := 0 to TableData.RowCount - 1 do begin

    for J := 0 to TableData.ColumnCount - 1 do begin

      Value := TableData[I, J];
        
    end;

  end;

  TableData[1, 1] := 'TEST SM';

end;

end.
