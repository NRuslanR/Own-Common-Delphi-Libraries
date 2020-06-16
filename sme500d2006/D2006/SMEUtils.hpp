// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Smeutils.pas' rev: 10.00

#ifndef SmeutilsHPP
#define SmeutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smeutils
{
//-- type declarations -------------------------------------------------------
typedef AnsiString SMEUTF8String;

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool __fastcall DirectoryExists(const AnsiString Name);
extern PACKAGE bool __fastcall ForceDirectories(AnsiString Dir);
extern PACKAGE bool __fastcall SMEOpenSaveFileDialog(unsigned ParentHandle, AnsiString DefExt, const AnsiString Filter, const AnsiString InitialDir, const AnsiString Title, AnsiString &FileName, bool IsOpenDialog);
extern PACKAGE AnsiString __fastcall GetLoggedUserName();
extern PACKAGE AnsiString __fastcall GetXMLDateTime(System::TDateTime Value);
extern PACKAGE AnsiString __fastcall SMEUtf8Encode(const WideString WS);
extern PACKAGE AnsiString __fastcall ReplaceTags(const AnsiString S, const AnsiString OldTag, const AnsiString NewTag);

}	/* namespace Smeutils */
using namespace Smeutils;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Smeutils
