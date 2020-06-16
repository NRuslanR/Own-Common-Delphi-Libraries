unit DomainObjectValueUnit;

interface

uses SysUtils, Classes, IDomainObjectValueUnit,
     ClonableUnit, EquatableUnit, CopyableUnit,
     DomainObjectBaseUnit, DomainException;

type

  TDomainObjectValueException = class (TDomainException)

  end;
  
  TDomainObjectValue = class abstract(TDomainObjectBase, IDomainObjectValue)

    public

  end;

implementation

{ TDomainObjectValue }


end.
