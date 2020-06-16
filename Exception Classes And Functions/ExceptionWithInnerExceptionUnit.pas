unit ExceptionWithInnerExceptionUnit;

interface

uses SysUtils;

type

  TExceptionWithInnerException = class (Exception)

    protected

      FInnerException: Exception;

      function GetInnerException: Exception;
      procedure SetInnerException(AInnerException: Exception);

    public

      constructor Create(
        const Msg: String;
        AInnerException: Exception = nil
      );

      constructor CreateFmt(
        const Msg: String;
        const Args: array of const;
        AInnerException: Exception = nil
      );
      
      destructor Destroy; override;

      property InnerException: Exception
      read GetInnerException write SetInnerException;

  end;

implementation

{ TPDFDocumentRenderingThreadException }

constructor TExceptionWithInnerException.Create(
  const Msg: String;
  AInnerException: Exception
);
begin

  inherited Create(Msg);

  InnerException := AInnerException;

end;

constructor TExceptionWithInnerException.CreateFmt(
  const Msg: String;
  const Args: array of const;
  AInnerException: Exception
);
begin

  inherited CreateFmt(Msg, Args);

  InnerException := AInnerException;

end;

destructor TExceptionWithInnerException.Destroy;
begin

  FreeAndNil(FInnerException);
  inherited;

end;

function TExceptionWithInnerException.GetInnerException: Exception;
begin

  Result := FInnerException;
  
end;

procedure TExceptionWithInnerException.SetInnerException(
  AInnerException: Exception);
begin

  FInnerException := AInnerException;
  
end;

end.
