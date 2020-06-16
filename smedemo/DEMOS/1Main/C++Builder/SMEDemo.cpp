//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("SMEDemo.res");
USEFORM("Main.cpp", frmSMExportDemo);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
                 Application->Initialize();
                 Application->Title = "SMExport suite v4.20: Demo Application";
                 Application->CreateForm(__classid(TfrmSMExportDemo), &frmSMExportDemo);
                 Application->Run();
        }
        catch (Exception &exception)
        {
                 Application->ShowException(&exception);
        }
        return 0;
}
//---------------------------------------------------------------------------
