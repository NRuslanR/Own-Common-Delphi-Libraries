unit TestForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm9 = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

uses
  DialogFormUnit;

{$R *.dfm}

procedure TForm9.Button1Click(Sender: TObject);
var InteractMode: TInteractMode;
begin

  if CheckBox1.Checked then
    InteractMode := imEditing

  else InteractMode:= imView;

  TDialogForm.Create(Self, InteractMode).SHowModal;

end;

end.
