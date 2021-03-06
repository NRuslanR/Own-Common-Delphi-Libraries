unit Cloneable;

interface

uses

  ClonableUnit;

type

  TCloneable = class (TInterfacedObject, IClonable)

    public

      function Clone: TObject; virtual; abstract;

      function GetSelf: TObject;
          
  end;

implementation

{ TAbstractCloneable }


function TCloneable.GetSelf: TObject;
begin

  Result := Self;
  
end;

end.
