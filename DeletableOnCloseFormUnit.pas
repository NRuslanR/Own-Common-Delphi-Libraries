unit DeletableOnCloseFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type

  TOnDeleteEventHandler =
    procedure (Sender: TObject) of object;

  TDeletableOnCloseForm = class(TForm)

    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  protected
    { Private declarations }

    FDeleteOnClose: Boolean;
    FOnDeleteEventHandler: TOnDeleteEventHandler;

    procedure RaiseOnDeleteEventHandler;

  public
    { Public declarations }

    property DeleteOnClose: Boolean read FDeleteOnClose write FDeleteOnClose;
    property OnDeleteEventHandler: TOnDeleteEventHandler
    read FOnDeleteEventHandler write FOnDeleteEventHandler;

  end;

implementation

{$R *.dfm}

procedure TDeletableOnCloseForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  if FDeleteOnClose then begin

    RaiseOnDeleteEventHandler;

    Action := caFree;

  end;

end;

procedure TDeletableOnCloseForm.RaiseOnDeleteEventHandler;
begin

  if Assigned(FOnDeleteEventHandler) then
    FOnDeleteEventHandler(Self);

end;

end.
