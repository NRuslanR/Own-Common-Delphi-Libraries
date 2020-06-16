// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Smezipfile.pas' rev: 10.00

#ifndef SmezipfileHPP
#define SmezipfileHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smezipfile
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct TCommonFileHeader
{
	
public:
	Word VersionNeededToExtract;
	Word GeneralPurposeBitFlag;
	Word CompressionMethod;
	unsigned LastModFileTimeDate;
	unsigned Crc32;
	unsigned CompressedSize;
	unsigned UncompressedSize;
	Word FilenameLength;
	Word ExtraFieldLength;
} ;
#pragma pack(pop)

#pragma pack(push,1)
struct TFileHeader
{
	
public:
	unsigned CentralFileHeaderSignature;
	Word VersionMadeBy;
	#pragma pack(push,1)
	TCommonFileHeader CommonFileHeader;
	#pragma pack(pop)
	Word FileCommentLength;
	Word DiskNumberStart;
	Word InternalFileAttributes;
	unsigned ExternalFileAttributes;
	unsigned RelativeOffsetOfLocalHeader;
	AnsiString FileName;
	AnsiString ExtraField;
	AnsiString FileComment;
} ;
#pragma pack(pop)

#pragma pack(push,1)
struct TEndOfCentralDir
{
	
public:
	unsigned EndOfCentralDirSignature;
	Word NumberOfThisDisk;
	Word NumberOfTheDiskWithTheStart;
	Word TotalNumberOfEntriesOnThisDisk;
	Word TotalNumberOfEntries;
	unsigned SizeOfTheCentralDirectory;
	unsigned OffsetOfStartOfCentralDirectory;
	Word ZipfileCommentLength;
} ;
#pragma pack(pop)

class DELPHICLASS TLocalFile;
class PASCALIMPLEMENTATION TLocalFile : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	unsigned FLocalFileHeaderSignature;
	#pragma pack(push,1)
	TCommonFileHeader FCommonFileHeader;
	#pragma pack(pop)
	AnsiString FFileName;
	AnsiString FExtraField;
	AnsiString FCompressedData;
	unsigned FCentralFileHeaderSignature;
	Word FCentralVersionMadeBy;
	#pragma pack(push,1)
	TCommonFileHeader FCentralCommonFileHeader;
	#pragma pack(pop)
	Word FCentralFileCommentLength;
	Word FCentralDiskNumberStart;
	Word FCentralInternalFileAttributes;
	unsigned FCentralExternalFileAttributes;
	unsigned FCentralRelativeOffsetOfLocalHeader;
	AnsiString FCentralFileName;
	AnsiString FCentralExtraField;
	AnsiString FCentralFileComment;
	
protected:
	bool FHeaderRead;
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall LoadFileFromStream(Classes::TStream* AStream);
	void __fastcall LoadCentralDirectoryFromStream(Classes::TStream* AStream);
	
__published:
	__property unsigned LocalFileHeaderSignature = {read=FLocalFileHeaderSignature, write=FLocalFileHeaderSignature, nodefault};
	__property TCommonFileHeader CommonFileHeader = {read=FCommonFileHeader, write=FCommonFileHeader};
	__property AnsiString FileName = {read=FFileName, write=FFileName};
	__property AnsiString ExtraField = {read=FExtraField, write=FExtraField};
	__property AnsiString CompressedData = {read=FCompressedData, write=FCompressedData};
	__property unsigned CentralFileHeaderSignature = {read=FCentralFileHeaderSignature, write=FCentralFileHeaderSignature, nodefault};
	__property Word CentralVersionMadeBy = {read=FCentralVersionMadeBy, write=FCentralVersionMadeBy, nodefault};
	__property TCommonFileHeader CentralCommonFileHeader = {read=FCentralCommonFileHeader, write=FCentralCommonFileHeader};
	__property Word CentralFileCommentLength = {read=FCentralFileCommentLength, write=FCentralFileCommentLength, nodefault};
	__property Word CentralDiskNumberStart = {read=FCentralDiskNumberStart, write=FCentralDiskNumberStart, nodefault};
	__property Word CentralInternalFileAttributes = {read=FCentralInternalFileAttributes, write=FCentralInternalFileAttributes, nodefault};
	__property unsigned CentralExternalFileAttributes = {read=FCentralExternalFileAttributes, write=FCentralExternalFileAttributes, nodefault};
	__property unsigned CentralRelativeOffsetOfLocalHeader = {read=FCentralRelativeOffsetOfLocalHeader, write=FCentralRelativeOffsetOfLocalHeader, nodefault};
	__property AnsiString CentralFileName = {read=FCentralFileName, write=FCentralFileName};
	__property AnsiString CentralExtraField = {read=FCentralExtraField, write=FCentralExtraField};
	__property AnsiString CentralFileComment = {read=FCentralFileComment, write=FCentralFileComment};
public:
	#pragma option push -w-inl
	/* TCollectionItem.Create */ inline __fastcall virtual TLocalFile(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLocalFile(void) { }
	#pragma option pop
	
};


class DELPHICLASS TLocalFiles;
class PASCALIMPLEMENTATION TLocalFiles : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
public:
	TLocalFile* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TComponent* FControl;
	TLocalFile* __fastcall GetLocalFile(int Index);
	void __fastcall SetLocalFile(int Index, TLocalFile* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TLocalFiles(Classes::TComponent* ACntrl);
	HIDESBASE TLocalFile* __fastcall Add(void);
	__property Classes::TComponent* OwnerControl = {read=FControl};
	__property TLocalFile* Items[int Index] = {read=GetLocalFile, write=SetLocalFile/*, default*/};
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TLocalFiles(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZipArchive;
class PASCALIMPLEMENTATION TZipArchive : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TLocalFiles* Files;
	#pragma pack(push,1)
	TEndOfCentralDir EndOfCentralDirectory;
	#pragma pack(pop)
	AnsiString ZipFileComment;
	AnsiString __fastcall GetUncompressed(int i);
	void __fastcall SetUncompressed(int i, const AnsiString AValue);
	void __fastcall UpdateCompressedHeader(int i, unsigned lenValue, unsigned ContentCrc32);
	int __fastcall GetCount(void);
	
public:
	__fastcall virtual TZipArchive(Classes::TComponent* AOwner);
	__fastcall virtual ~TZipArchive(void);
	int __fastcall GetIndexByFileName(const AnsiString AFileName);
	AnsiString __fastcall DecompressFileName(const AnsiString AFileName);
	void __fastcall LoadFromFile(const AnsiString FileName);
	void __fastcall LoadFromStream(const Classes::TStream* ZipFileStream);
	void __fastcall AddFile(const AnsiString name, unsigned FAttribute);
	void __fastcall SaveToFile(const AnsiString filename);
	void __fastcall SaveToStream(Classes::TStream* ZipFileStream);
	void __fastcall WriteUncompressedStreamToFile(int i, Classes::TStream* AUncompressedStream);
	void __fastcall GetFileNames(Classes::TStrings* lstFiles);
	__property int Count = {read=GetCount, nodefault};
	__property AnsiString Uncompressed[int i] = {read=GetUncompressed, write=SetUncompressed};
};


class DELPHICLASS EZipFileCRCError;
class PASCALIMPLEMENTATION EZipFileCRCError : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall EZipFileCRCError(const AnsiString Msg) : Sysutils::Exception(Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall EZipFileCRCError(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall EZipFileCRCError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall EZipFileCRCError(int Ident, System::TVarRec const * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall EZipFileCRCError(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall EZipFileCRCError(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall EZipFileCRCError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall EZipFileCRCError(System::PResStringRec ResStringRec, System::TVarRec const * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~EZipFileCRCError(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#define EIndexOutOfBounds "Index out of bounds"

}	/* namespace Smezipfile */
using namespace Smezipfile;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Smezipfile
