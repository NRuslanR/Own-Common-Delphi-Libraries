unit DocRepositoryUnit;

interface

uses AbstractZeosDBRepositoryUnit, DomainObjectUnit, DBTableMappingUnit,
      Classes;

type

  TDocument = class (TDomainObject)

      private

        FName: String;
        FNumber: string;
        FCreationDate: TDateTime;
        FContent: String;
        FTypeId: Integer;

      published

        property Name: String read FName write FName;
        property Number: string read FNumber write FNumber;
        property CreationDate: TDateTime read FCreationDate write FCreationDate;
        property Content: String read FContent write FContent;
        property TypeId: Integer read FTypeId write FTypeId;

  end;

  TDocumentRepository = class (TAbstractZeosDBRepository)

    protected

      procedure CustomizeTableMapping(
        TableMapping: TDBTableMapping
      )
      ; override;

    public

      constructor Create; overload;
        constructor Create(Connection: TComponent); overload;
        constructor Create(
          Connection: TComponent;
          DecoratedDBRepository: TAbstractZeosDBRepository
        ); overload;

      function FindDocumentById(const Id: Integer): TDocument;
      procedure AddDocument(Document: TDocument);
      procedure UpdateDocument(Document: TDocument);
      procedure RemoveDocument(Document: TDocument);

  end;

implementation

{ TDocumentRepository }

procedure TDocumentRepository.AddDocument(Document: TDocument);
begin

  Add(Document);

end;

constructor TDocumentRepository.Create;
begin

  inherited;

end;

constructor TDocumentRepository.Create(Connection: TComponent);
begin

  inherited;

end;

constructor TDocumentRepository.Create(Connection: TComponent;
  DecoratedDBRepository: TAbstractZeosDBRepository);
begin

  inherited;

end;

procedure TDocumentRepository.CustomizeTableMapping(
  TableMapping: TDBTableMapping
);
begin

  TableMapping.SetTableNameMapping('doc.service_notes', TDocument);

  TableMapping.AddColumnMappingForSelect('id', 'Identity');
  TableMapping.AddColumnMappingForSelect('name', 'Name');
  TableMapping.AddColumnMappingForSelect('document_number', 'Number');
  TableMapping.AddColumnMappingForSelect('creation_date', 'CreationDate');
  TableMapping.AddColumnMappingForSelect('type_id', 'TypeId');
  TableMapping.AddColumnMappingForSelect('content', 'Content');

  TableMapping.AddColumnMappingForModification('name', 'Name');
  TableMapping.AddColumnMappingForModification('document_number', 'Number');
  TableMapping.AddColumnMappingForModification('creation_date', 'CreationDate');
  TableMapping.AddColumnMappingForModification('type_id', 'TypeId');
  TableMapping.AddColumnMappingForModification('content', 'Content');

  TableMapping.AddPrimaryKeyColumnMapping('id', 'Identity');

end;

function TDocumentRepository.FindDocumentById(const Id: Integer): TDocument;
begin

  Result := FindDomainObjectByIdentity(Id) as TDocument;

end;

procedure TDocumentRepository.RemoveDocument(Document: TDocument);
begin

  Remove(Document);

end;

procedure TDocumentRepository.UpdateDocument(Document: TDocument);
begin

  Update(Document);

end;

end.
