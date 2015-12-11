[Setup]
AppName=Universal Extractor
AppVerName=Universal Extractor 1.3.1
AppPublisher=Jared Breland
AppPublisherURL=http://www.legroom.net/mysoft
AppSupportURL=http://www.legroom.net/mysoft
AppUpdatesURL=http://www.legroom.net/mysoft
DefaultDirName={pf}\Universal Extractor
DisableDirPage=false
DefaultGroupName=Universal Extractor
DisableProgramGroupPage=true
OutputDir=Y:\software\uniextract\uniextract_131
SourceDir=Y:\software\uniextract\uniextract_131
OutputBaseFilename=uniextract131
SolidCompression=true
Compression=lzma/ultra
InternalCompressLevel=ultra
;SolidCompression=false
;Compression=none
;InternalCompressLevel=none
AlwaysShowComponentsList=false
DisableReadyPage=false
AppVersion=1.3.1
ShowLanguageDialog=auto
VersionInfoVersion=1.3.1
VersionInfoCompany=Jared Breland
VersionInfoDescription=Package for Universal Extractor
ChangesEnvironment=true
ChangesAssociations=true
AllowUNCPath=false
AllowNoIcons=true
UninstallDisplayIcon={app}\bin\UniExtract.exe
WizardSmallImageFile=Y:\software\uniextract\support\Icons\uniextract_inno.bmp

[CustomMessages]
;forcedesc=Force &association with all supported archive formats%nWarning: This may overwrite existing associations.

[Tasks]
Name: associate; Description: &Enable Explorer context menu integration; Flags: checkablealone
Name: associate\files; Description: Add UniExtract &Files... to context menu
Name: associate\here; Description: Add UniExtract &Here to context menu
Name: associate\subdir; Description: Add UniExtract to &Subdir to context menu
Name: associate\force; Description: Force &association with all supported archive formats; Flags: dontinheritcheck unchecked
Name: modifypath; Description: Add Universal Extractor to your system &path
Name: startmenuicon; Description: Create a Start &Menu icon
Name: desktopicon; Description: Create a &desktop icon; Flags: unchecked
Name: quicklaunchicon; Description: Create a &Quick Launch icon; Flags: unchecked

[Files]
;Source: UniExtract.au3; DestDir: {app}; Flags: ignoreversion
Source: ..\uniextract_changelog.txt; DestDir: {app}; DestName: changelog.txt; Flags: ignoreversion
Source: ..\uniextract_license.txt; DestDir: {app}; DestName: license.txt; Flags: ignoreversion
Source: ..\uniextract_todo.txt; DestDir: {app}; DestName: todo.txt; Flags: ignoreversion
Source: ..\support\Icons\UniExtract_files.ico; DestDir: {app}; DestName: UniExtract.ico; Flags: ignoreversion
Source: bin\*; DestDir: {app}\bin; Flags: ignoreversion recursesubdirs
Source: docs\*; DestDir: {app}\docs; Flags: ignoreversion

[Icons]
Name: {commonprograms}\Universal Extractor; Filename: {app}\bin\UniExtract.exe; WorkingDir: {app}; Tasks: startmenuicon
Name: {userdesktop}\Universal Extractor; Filename: {app}\bin\UniExtract.exe; WorkingDir: {app}; Tasks: desktopicon
Name: {userappdata}\Microsoft\Internet Explorer\Quick Launch\Universal Extractor; Filename: {app}\bin\UniExtract.exe; WorkingDir: {app}; Tasks: quicklaunchicon

[Registry]
; Paths
Root: HKLM; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\UniExtract.exe; ValueType: string; ValueData: {app}\bin\UniExtract.exe; Flags: uninsdeletekey; Tasks: modifypath
Root: HKLM; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\UniExtract.exe; ValueType: string; ValueName: Path; ValueData: {app}\bin; Tasks: modifypath
Root: HKCR; SubKey: UniExtract; ValueType: string; ValueData: Universal Extractor Archive; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: UniExtract\DefaultIcon; ValueType: string; ValueData: {app}\UniExtract.ico; Tasks: associate
Root: HKCR; SubKey: UniExtract\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Tasks: associate and associate\files
Root: HKCR; SubKey: UniExtract\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: UniExtract\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Tasks: associate and associate\here
Root: HKCR; SubKey: UniExtract\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: UniExtract\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Tasks: associate and associate\subdir
Root: HKCR; SubKey: UniExtract\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

; Native Associations
Root: HKCR; SubKey: .dl_\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: .dl_\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: .dl_\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: .dl_\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: .dl_\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: .dl_\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: .ex_\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: .ex_\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: .ex_\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: .ex_\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: .ex_\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: .ex_\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: .in_\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: .in_\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: .in_\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: .in_\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: .in_\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: .in_\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: .oc_\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: .oc_\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: .oc_\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: .oc_\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: .oc_\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: .oc_\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: .sr_\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: .sr_\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: .sr_\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: .sr_\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: .sr_\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: .sr_\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: .sy_\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: .sy_\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: .sy_\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: .sy_\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: .sy_\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: .sy_\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: exefile\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: exefile\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: exefile\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: exefile\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: exefile\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: exefile\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: dllfile\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: dllfile\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: dllfile\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: dllfile\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: dllfile\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: dllfile\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: expandfile\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: expandfile\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: expandfile\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: expandfile\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: expandfile\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: expandfile\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: chm.file\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: chm.file\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: chm.file\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: chm.file\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: chm.file\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: chm.file\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: hlpfile\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: hlpfile\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: hlpfile\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: hlpfile\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: hlpfile\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: hlpfile\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: Msi.Package\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: Msi.Package\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: Msi.Package\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: Msi.Package\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: Msi.Package\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: Msi.Package\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

; Additional Associations
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.001')
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.001')
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.001')
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.001')
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.001')
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.001')
Root: HKCR; Subkey: .001; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.001')
Root: HKCR; Subkey: .001; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.1,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.1')
Root: HKCR; SubKey: {reg:HKCR\.1,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.1')
Root: HKCR; SubKey: {reg:HKCR\.1,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.1')
Root: HKCR; SubKey: {reg:HKCR\.1,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.1')
Root: HKCR; SubKey: {reg:HKCR\.1,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.1')
Root: HKCR; SubKey: {reg:HKCR\.1,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.1')
Root: HKCR; Subkey: .1; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.1')
Root: HKCR; Subkey: .1; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.7z')
Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.7z')
Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.7z')
Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.7z')
Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.7z')
Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.7z')
Root: HKCR; Subkey: .7z; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.7z')
Root: HKCR; Subkey: .7z; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.ace')
Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.ace')
Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.ace')
Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.ace')
Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.ace')
Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.ace')
Root: HKCR; Subkey: .ace; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.ace')
Root: HKCR; Subkey: .ace; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.arc')
Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.arc')
Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.arc')
Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.arc')
Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.arc')
Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.arc')
Root: HKCR; Subkey: .arc; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.arc')
Root: HKCR; Subkey: .arc; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.arj')
Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.arj')
Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.arj')
Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.arj')
Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.arj')
Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.arj')
Root: HKCR; Subkey: .arj; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.arj')
Root: HKCR; Subkey: .arj; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.bin')
Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.bin')
Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.bin')
Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.bin')
Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.bin')
Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.bin')
Root: HKCR; Subkey: .bin; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.bin')
Root: HKCR; Subkey: .bin; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.bz2')
Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.bz2')
Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.bz2')
Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.bz2')
Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.bz2')
Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.bz2')
Root: HKCR; Subkey: .bz2; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.bz2')
Root: HKCR; Subkey: .bz2; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.cab')
Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.cab')
Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.cab')
Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.cab')
Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.cab')
Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.cab')
Root: HKCR; Subkey: .cab; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.cab')
Root: HKCR; Subkey: .cab; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.cpio')
Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.cpio')
Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.cpio')
Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.cpio')
Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.cpio')
Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.cpio')
Root: HKCR; Subkey: .cpio; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.cpio')
Root: HKCR; Subkey: .cpio; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.cue')
Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.cue')
Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.cue')
Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.cue')
Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.cue')
Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.cue')
Root: HKCR; Subkey: .cue; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.cue')
Root: HKCR; Subkey: .cue; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.deb')
Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.deb')
Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.deb')
Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.deb')
Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.deb')
Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.deb')
Root: HKCR; Subkey: .deb; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.deb')
Root: HKCR; Subkey: .deb; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.gz')
Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.gz')
Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.gz')
Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.gz')
Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.gz')
Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.gz')
Root: HKCR; Subkey: .gz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.gz')
Root: HKCR; Subkey: .gz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.img')
Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.img')
Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.img')
Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.img')
Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.img')
Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.img')
Root: HKCR; Subkey: .img; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.img')
Root: HKCR; Subkey: .img; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.iso')
Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.iso')
Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.iso')
Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.iso')
Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.iso')
Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.iso')
Root: HKCR; Subkey: .iso; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.iso')
Root: HKCR; Subkey: .iso; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.jar')
Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.jar')
Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.jar')
Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.jar')
Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.jar')
Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.jar')
Root: HKCR; Subkey: .jar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.jar')
Root: HKCR; Subkey: .jar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.kgb,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.kgb')
Root: HKCR; SubKey: {reg:HKCR\.kgb,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.kgb')
Root: HKCR; SubKey: {reg:HKCR\.kgb,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.kgb')
Root: HKCR; SubKey: {reg:HKCR\.kgb,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.kgb')
Root: HKCR; SubKey: {reg:HKCR\.kgb,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.kgb')
Root: HKCR; SubKey: {reg:HKCR\.kgb,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.kgb')
Root: HKCR; Subkey: .kgb; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.kgb')
Root: HKCR; Subkey: .kgb; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.kge,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.kge')
Root: HKCR; SubKey: {reg:HKCR\.kge,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.kge')
Root: HKCR; SubKey: {reg:HKCR\.kge,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.kge')
Root: HKCR; SubKey: {reg:HKCR\.kge,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.kge')
Root: HKCR; SubKey: {reg:HKCR\.kge,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.kge')
Root: HKCR; SubKey: {reg:HKCR\.kge,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.kge')
Root: HKCR; Subkey: .kge; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.kge')
Root: HKCR; Subkey: .kge; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.lha')
Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.lha')
Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.lha')
Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.lha')
Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lha')
Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lha')
Root: HKCR; Subkey: .lha; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.lha')
Root: HKCR; Subkey: .lha; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.lib,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.lib')
Root: HKCR; SubKey: {reg:HKCR\.lib,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.lib')
Root: HKCR; SubKey: {reg:HKCR\.lib,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.lib')
Root: HKCR; SubKey: {reg:HKCR\.lib,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.lib')
Root: HKCR; SubKey: {reg:HKCR\.lib,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lib')
Root: HKCR; SubKey: {reg:HKCR\.lib,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lib')
Root: HKCR; Subkey: .lib; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.lib')
Root: HKCR; Subkey: .lib; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.lzh')
Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.lzh')
Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.lzh')
Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.lzh')
Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lzh')
Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lzh')
Root: HKCR; Subkey: .lzh; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.lzh')
Root: HKCR; Subkey: .lzh; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.lzo')
Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.lzo')
Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.lzo')
Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.lzo')
Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lzo')
Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lzo')
Root: HKCR; Subkey: .lzo; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.lzo')
Root: HKCR; Subkey: .lzo; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.mht,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.mht')
Root: HKCR; SubKey: {reg:HKCR\.mht,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.mht')
Root: HKCR; SubKey: {reg:HKCR\.mht,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.mht')
Root: HKCR; SubKey: {reg:HKCR\.mht,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.mht')
Root: HKCR; SubKey: {reg:HKCR\.mht,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.mht')
Root: HKCR; SubKey: {reg:HKCR\.mht,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.mht')
Root: HKCR; Subkey: .mht; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.mht')
Root: HKCR; Subkey: .mht; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.rar')
Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.rar')
Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.rar')
Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.rar')
Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.rar')
Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.rar')
Root: HKCR; Subkey: .rar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.rar')
Root: HKCR; Subkey: .rar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.rpm,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.rpm')
Root: HKCR; SubKey: {reg:HKCR\.rpm,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.rpm')
Root: HKCR; SubKey: {reg:HKCR\.rpm,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.rpm')
Root: HKCR; SubKey: {reg:HKCR\.rpm,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.rpm')
Root: HKCR; SubKey: {reg:HKCR\.rpm,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.rpm')
Root: HKCR; SubKey: {reg:HKCR\.rpm,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.rpm')
Root: HKCR; Subkey: .rpm; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.rpm')
Root: HKCR; Subkey: .rpm; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.tar')
Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.tar')
Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.tar')
Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.tar')
Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.tar')
Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.tar')
Root: HKCR; Subkey: .tar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.tar')
Root: HKCR; Subkey: .tar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.tbz2')
Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.tbz2')
Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.tbz2')
Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.tbz2')
Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.tbz2')
Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.tbz2')
Root: HKCR; Subkey: .tbz2; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.tbz2')
Root: HKCR; Subkey: .tbz2; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.tgz')
Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.tgz')
Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.tgz')
Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.tgz')
Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.tgz')
Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.tgz')
Root: HKCR; Subkey: .tgz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.tgz')
Root: HKCR; Subkey: .tgz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.tz')
Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.tz')
Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.tz')
Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.tz')
Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.tz')
Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.tz')
Root: HKCR; Subkey: .tz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.tz')
Root: HKCR; Subkey: .tz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.uha,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.uha')
Root: HKCR; SubKey: {reg:HKCR\.uha,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.uha')
Root: HKCR; SubKey: {reg:HKCR\.uha,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.uha')
Root: HKCR; SubKey: {reg:HKCR\.uha,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.uha')
Root: HKCR; SubKey: {reg:HKCR\.uha,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.uha')
Root: HKCR; SubKey: {reg:HKCR\.uha,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.uha')
Root: HKCR; Subkey: .uha; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.uha')
Root: HKCR; Subkey: .uha; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.xpi')
Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.xpi')
Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.xpi')
Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.xpi')
Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.xpi')
Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.xpi')
Root: HKCR; Subkey: .xpi; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.xpi')
Root: HKCR; Subkey: .xpi; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.z')
Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.z')
Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.z')
Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.z')
Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.z')
Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.z')
Root: HKCR; Subkey: .z; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.z')
Root: HKCR; Subkey: .z; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.zip')
Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.zip')
Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.zip')
Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.zip')
Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.zip')
Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.zip')
Root: HKCR; Subkey: .zip; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .zip; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

[Code]
function RVE(ext: String): Boolean;
var
	regvalue: String;
begin
	RegQueryStringValue(HKEY_CLASSES_ROOT, ext, '', regvalue)
	if regvalue = '' then begin
		Result := False
	end else begin
		Result := True
	end;
end;

const
	ComponentList = '';
	TaskList = 'associate - Enable Explorer context menu integration, associate\files - Add UniExtract Files... to context menu, associate\here - Add UniExtract Here to context menu, associate\subdir - Add UniExtract to Subdir to context menu, associate\force - Force association with all supported archive formats, modifypath - Add Universal Extractor to your system path, startmenuicon - Create a Start Menu icon, desktopicon - Create a desktop icon, quicklaunchicon - Create a &Quick Launch icon';
#include "..\..\clihelp\clihelp.iss"

function ModPathDir(): String;
begin
	Result := ExpandConstant('{app}') + '\bin';
end;
#include "..\..\modpath\modpath.iss"
