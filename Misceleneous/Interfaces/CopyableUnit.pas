unit CopyableUnit;

interface

uses SysUtils, IGetSelfUnit;

type

  ICopyable = interface(IGetSelf)
  ['{1DDD8321-9911-414E-A3A8-41FE25F31E2F}']
  
    procedure CopyFrom(Copyable: TObject);
    procedure DeepCopyFrom(Copyable: TObject);

  end;

implementation

end.
