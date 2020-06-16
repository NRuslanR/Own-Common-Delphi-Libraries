unit ReferenceFormRecordViewModel;

interface

uses

  SysUtils,
  Classes;

type

  TReferenceFormRecordViewModel = class

    public

      Id: Variant;

      CanBeChanged: Variant;
      CanBeRemoved: Variant;

      constructor Create; virtual;
      
  end;

  TReferenceFormRecordViewModelClass = class of TReferenceFormRecordViewModel;

implementation

uses

  Variants;
  
{ TReferenceFormRecordViewModel }

constructor TReferenceFormRecordViewModel.Create;
begin

  inherited;

  Id := Null;
  CanBeRemoved := Null;
  CanBeChanged := Null;
  
end;

end.
