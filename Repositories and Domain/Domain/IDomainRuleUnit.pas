unit IDomainRuleUnit;

interface

uses

  DomainObjectUnit;

type

  IDomainRule = interface

    function IsSatisfiedBy(DomainObject: TDomainObject): Boolean;

  end;
  
implementation

end.
