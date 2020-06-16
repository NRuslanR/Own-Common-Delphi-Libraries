unit TestFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm5 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Panel1: TPanel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses
  AbstractRepositoryUnit, AbstractRepositoryCriteriaUnit,
  UnaryRepositoryCriterionUnit, BinaryRepositoryCriterionUnit,
  ArithmeticRepositoryCriterionOperationsUnit,
  BoolLogicalRepositoryCriterionBindingsUnit,
   ConstRepositoryCriterionUnit,
   BoolLogicalNegativeRepositoryCriterionUnit,
   ConstDBRepositoryCriterionUnit,
   UnaryZeosDBRepositoryCriterionUnit,
   UnitingRepositoryCriterionUnit, Unit1, Unit2,
   Unit3, MyClassUnit,
   ZConnection, ZDataset, MyNestedClassUnit, DomainObjectUnit,
   DomainObjectListUnit, DocRepositoryUnit,
   ContainsRepositoryCriterionOperationUnit;

{$R *.dfm}

procedure TForm5.Button1Click(Sender: TObject);
var Repository: TAbstractRepository;
    Criterion: TUnitingRepositoryCriterion;
    a : array of TAbstractRepositoryCriterion;
    j: array of Variant;
begin

  Criterion :=

  TUnitingRepositoryCriterion.Create(
    TMyRepositoryCriterionBinding.Create,
    [
      TUnaryZeosDBRepositoryCriterion.Create(
        'rt', 2132132132131, TEqualityRepositoryCriterionOperation.Create
      ),

      TUnitingRepositoryCriterion.Create(
        TBoolOrBinding.Create,
        [
          TUnaryZeosDBRepositoryCriterion.Create(
            'some', 233, TLessOrEqualRepositoryCriterionOperation.Create
          ),
          TUnitingRepositoryCriterion.Create(
            TBoolAndBinding.Create,
            [
              TUnaryZeosDBRepositoryCriterion.Create(
                'field1', 19, TLessRepositoryCriterionOperation.Create
              ),
              TUnaryZeosDBRepositoryCriterion.Create(
                'field2', 'abcd', TEqualityRepositoryCriterionOperation.Create
              ),
              TUnaryZeosDBRepositoryCriterion.Create(
                'field3', Now, TGreaterOrEqualRepositoryCriterionOperation.Create
              ),

              TUnitingRepositoryCriterion.Create(
                TBoolOrBinding.Create,
                [
                    TUnaryZeosDBRepositoryCriterion.Create(
                      'field4', 20, TGreaterRepositoryCriterionOperation.Create
                    ),
                    TUnaryZeosDBRepositoryCriterion.Create(
                      'field5', Now, TEqualityRepositoryCriterionOperation.Create
                    )
                ]
              )
            ]
          ),
          TBoolNegativeRepositoryCriterion.Create(
              TUnaryRepositoryCriterion.Create(
                'zzz', 432.423423423, TEqualityRepositoryCriterionOperation.Create
              )
          )
      ]
      )
    ]
  );

  OutputDebugString(PChar(Criterion.Expression));

  Criterion.Free;

end;

procedure TForm5.Button3Click(Sender: TObject);
var i, j: TMyClass;
begin

  i := TMyClass.Create;
  j := TMyClass.Create;

  i.Number := 1;
  i.Enum := first;
  i.Name := 'abc';
  i.Date := Now;
  i.Float := 32.23;
  i.Double := 32.323223;
  i.Generic := 'dasdasdas';
  i.ZObject := nil;
  i.NestedObject := TMyNestedClass.Create;
  i.NestedObject.NestedName := 'Name';
  i.NestedObject.NestedDateTime := Now;

  j.Number := 1;
  j.Enum := first;
  j.Name := 'abc';
  j.Date := Now;
  j.Float := 32.23;
  j.Double := 32.323223;
  j.Generic := 'dasdasdas';
  j.ZObject := nil;
  j.NestedObject := TMyNestedClass.Create;
  j.NestedObject.NestedName := 'Name';
  j.NestedObject.NestedDateTime := Now;

end;

procedure TForm5.Button4Click(Sender: TObject);
var Conn: TZConnection;
    Query: TZQuery;
begin

  Conn := TZConnection.Create(Self);

  Conn.HostName := 'srv-pg2';
  Conn.Port := 5432;
  Conn.Protocol := 'postgresql-8';
  Conn.Database := 'ump_nightly';
  Conn.User := 'u_59968';
  Conn.Password := '123456';

  Conn.Connect;

  Conn.ExecuteDirect('select * from omo.spr_services limit 100');

end;

procedure TForm5.Button5Click(Sender: TObject);
var DocRep: TDocumentRepository;
    Doc: TDocument;
    Conn: TZConnection;
    contains: TContainsRepositoryCriterionOperationClass;
    uniting: TUnitingRepositoryCriterionClass;
    binding: TBoolAndBindingClass;
    unary: TUnaryRepositoryCriterionClass;
    cr: TUnitingRepositoryCriterion;
    docList: TDomainObjectList;
    dom: TDomainObject;

begin

  Conn := TZConnection.Create(Self);

  Conn.HostName := 'srv-pg';
  Conn.Port := 5432;
  Conn.Protocol := 'postgresql-8';
  Conn.Database := 'ump';
  Conn.User := 'u_59968';
  Conn.Password := '123456';

  DocRep := TDocumentRepository.Create(Conn);

  Doc := TDocument.Create;
  Doc.Identity := 1;
  Doc.Name := 'AAAAAAAAAAa';
  Doc.Number := '41111';
  Doc.CreationDate := Now;
  Doc.Content := 'ZZZZZZZZZZZZZZZZZ';
  Doc.TypeId := 4;

  uniting := DocRep.GetUnitingRepositoryCriterionClass;
  binding := DocRep.GetAndBindingRepositoryCriterionClass;
  unary := DocRep.GetUnaryRepositoryCriterionClass;


  cr := uniting.Create(
    binding.Create,
    [
        unary.Create('Identity',
          1,
          DocRep.GetGreaterRepositoryCriterionOperationClass.Create
        )
      ]
  );

  docList := DocRep.FindDomainObjectsByCriteria(cr);

  for dom in docList do begin

    doc := dom as TDocument;

    OutputDebugString(PChar(
    Format('[%s, %s, %s, %s, %s, %d]',
    [VarToStr(Doc.Identity),Doc.Name, Doc.Number,
    VarToStr(Doc.CreationDate), Doc.Content, Doc.TypeId]
    )));

  end;

  OutputDebugString('dasdas');

end;

procedure TForm5.Button6Click(Sender: TObject);
var e : TC;
begin

  e := TC.Create;

  e.M;

end;

end.
