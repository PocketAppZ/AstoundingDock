                       ; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{634D2665-E85F-473A-B861-F75A3C4E7A25}
AppName=Astounding Dock
AppVerName=Astounding Dock 1.1.0.0
AppPublisher=Astounding Applications
DefaultDirName={pf}\Astounding Dock
DefaultGroupName=Astounding Dock
OutputDir=.
OutputBaseFilename=AstoundingDockSetup
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";

[Files]
; Internal
Source: "..\bin\Release\AstoundingDock.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\Release\AppBarInterface.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\Release\Win32Interface.dll"; DestDir: "{app}"; Flags: ignoreversion
; Windows
Source: "..\bin\Release\System.Reactive.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\Release\System.Reactive.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\Release\System.Windows.Interactivity.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\Release\Microsoft.Practices.ServiceLocation.dll"; DestDir: "{app}"; Flags: ignoreversion
; MVVM Light
Source: "..\bin\Release\GalaSoft.MvvmLight.Extras.WPF4.dll"; DestDir: "{app}"; Flags: ignoreversion
;Source: "..\bin\Release\GalaSoft.MvvmLight.Extras.WPF4.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\Release\GalaSoft.MvvmLight.WPF4.dll"; DestDir: "{app}"; Flags: ignoreversion
;Source: "C:\John\Dropbox\My Dropbox\Prgramming\Svn\AstoundingDock\bin\Release\GalaSoft.MvvmLight.WPF4.xml"; DestDir: "{app}"; Flags: ignoreversion
; Themes
Source: "..\bin\Release\Ballistic.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\Release\Developer.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\Release\Gemini.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\Release\Glass.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\Release\Odyssey.dll"; DestDir: "{app}"; Flags: ignoreversion
; Log4Net
Source: "..\bin\Release\log4net.dll"; DestDir: "{app}"; Flags: ignoreversion
;Source: "..\bin\Release\log4net.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\Release\log4net.config"; DestDir: "{app}"; Flags: ignoreversion
; Other Third Party
Source: "..\bin\Release\INIFileParser.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\Release\IconLib.dll"; DestDir: "{app}"; Flags: ignoreversion
;Source: "..\bin\Release\ListViewDragDropManager.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\Release\QuickZip.IO.PIDL.dll"; DestDir: "{app}"; Flags: ignoreversion
;.Net 4 Framework
Source: "..\Setup\dotNetFx40_Client_setup.exe"; DestDir: {tmp}; Flags: deleteafterinstall; Check: CheckForFramework

[Icons]
Name: "{group}\Astounding Dock"; Filename: "{app}\AstoundingDock.exe"
Name: "{group}\{cm:UninstallProgram,Astounding Dock}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\Astounding Dock"; Filename: "{app}\AstoundingDock.exe"; WorkingDir: "{app}"; Tasks: desktopicon

[Dirs]
Name: "{app}\"; Permissions: everyone-modify

[Registry]
; When you uninstall the application, remove the "RunApplicationOnStartup" registry key if it was created
root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "AstoundingDock"; Flags: dontcreatekey uninsdeletevalue

[Run]
Filename: "{tmp}\dotNetFx40_Client_setup.exe"; Parameters: "/q:a /c:""install /l /q"""; Check: CheckForFramework; StatusMsg: Microsoft Framework 4.0 Client Profile is be�ng installed. Please wait...
Filename: "{app}\AstoundingDock.exe"; Description: "{cm:LaunchProgram,Astounding Dock}"; Flags: nowait postinstall skipifsilent

[Code]
function IsDotNetDetected(version: string; service: cardinal): boolean;
// Indicates whether the specified version and service pack of the .NET Framework is installed.
//
// version -- Specify one of these strings for the required .NET Framework version:
//    'v1.1.4322'     .NET Framework 1.1
//    'v2.0.50727'    .NET Framework 2.0
//    'v3.0'          .NET Framework 3.0
//    'v3.5'          .NET Framework 3.5
//    'v4\Client'     .NET Framework 4.0 Client Profile
//    'v4\Full'       .NET Framework 4.0 Full Installation
//
// service -- Specify any non-negative integer for the required service pack level:
//    0               No service packs required
//    1, 2, etc.      Service pack 1, 2, etc. required
var
    key: string;
    install, serviceCount: cardinal;
    success: boolean;
begin
    key := 'SOFTWARE\Microsoft\NET Framework Setup\NDP\' + version;
    // .NET 3.0 uses value InstallSuccess in subkey Setup
    if Pos('v3.0', version) = 1 then begin
        success := RegQueryDWordValue(HKLM, key + '\Setup', 'InstallSuccess', install);
    end else begin
        success := RegQueryDWordValue(HKLM, key, 'Install', install);
    end;
    // .NET 4.0 uses value Servicing instead of SP
    if Pos('v4', version) = 1 then begin
        success := success and RegQueryDWordValue(HKLM, key, 'Servicing', serviceCount);
    end else begin
        success := success and RegQueryDWordValue(HKLM, key, 'SP', serviceCount);
    end;
    result := success and (install = 1) and (serviceCount >= service);
end;

Function CheckForFramework : boolean;
begin
  if IsDotNetDetected('v4\Client', 0) then begin
    Result := false;
  end else begin
    Result := true;
  end;
end;