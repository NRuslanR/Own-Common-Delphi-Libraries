unit AbstractDataSetFactory;

interface

uses

  AbstractDataSetHolder,
  SysUtils,
  Classes;

type

  TAbstractDataSetHolderFactory = class abstract

    public

      function CreateDataSetHolder(
        DataSetFieldDefs: TAbstractDataSetFieldDefs
      ): TAbstractDataSetHolder; virtual; abstract;
      
  end;

implementation

end.
