unit SectionRecordViewModel;

interface

uses

  SysUtils,
  Classes;

type

  TSectionRecordViewModel = class

    public

      Id: Variant;
      ParentId: Variant;
      Name: String;

      constructor Create;
      
  end;

  TSectionRecordViewModelClass = class of TSectionRecordViewModel;

implementation

uses

  Variants;
  
{ TSectionRecordViewModel }

constructor TSectionRecordViewModel.Create;
begin

  inherited Create;

  Id := Null;
  ParentId := Null;
  
end;

end.
