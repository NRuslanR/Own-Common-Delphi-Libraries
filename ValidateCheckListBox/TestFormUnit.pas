unit TestFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ValidateCheckListBoxUnit, Buttons;

type
  TForm15 = class(TForm)
    ValidateCheckListBox1: TValidateCheckListBox;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form15: TForm15;

implementation

{$R *.dfm}

procedure TForm15.BitBtn1Click(Sender: TObject);
begin

  ValidateCheckListBox1.IsValid;
  
end;

end.
