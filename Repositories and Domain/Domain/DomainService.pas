unit DomainService;

interface

uses

  IGetSelfUnit;

type

  IDomainService = interface (IGetSelf)


  end;

  IStandardDomainService = interface (IDomainService)

  end;
  
  
implementation

end.
