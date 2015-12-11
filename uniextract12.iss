[Setup]
AppName=Universal Extractor
AppVerName=Universal Extractor 1.2
AppPublisher=Jared Breland
AppPublisherURL=http://www.legroom.net/mysoft
AppSupportURL=http://www.legroom.net/mysoft
AppUpdatesURL=http://www.legroom.net/mysoft
DefaultDirName={pf}\Universal Extractor
DisableDirPage=false
DefaultGroupName=Universal Extractor
OutputDir=Y:\windows\Packages\Universal_Extractor\uniextract_12
SourceDir=Y:\windows\Packages\Universal_Extractor\uniextract_12
OutputBaseFilename=uniextract12
SolidCompression=true
Compression=lzma/ultra
InternalCompressLevel=ultra
;SolidCompression=false
;Compression=none
;InternalCompressLevel=none
AlwaysShowComponentsList=false
DisableReadyPage=true
AppVersion=1.2
ShowLanguageDialog=auto
VersionInfoVersion=1.2
VersionInfoCompany=Jared Breland
VersionInfoDescription=Package for Universal Extractor
ChangesEnvironment=true
ChangesAssociations=true
AllowUNCPath=false
AllowNoIcons=true
UninstallDisplayIcon={app}\bin\UniExtract.exe
WizardSmallImageFile=Y:\windows\Packages\Universal_EXtractor\support\Icons\uniextract_inno.bmp

[CustomMessages]
forcedesc=&Force association with all supported archive formats%nWarning: This may overwrite existing associations.

[Tasks]
Name: associate; Description: &Enable Explorer context menu integration; Flags: checkablealone
Name: associate\force; Description: {cm:forcedesc}; Flags: dontinheritcheck unchecked
Name: modifypath; Description: Add Universal Extractor to your system &path

[Files]
;Source: UniExtract.au3; DestDir: {app}; Flags: ignoreversion
Source: ..\license.txt; DestDir: {app}; Flags: ignoreversion
Source: ..\todo.txt; DestDir: {app}; Flags: ignoreversion
Source: ..\support\Icons\UniExtract_files.ico; DestDir: {app}; DestName: UniExtract.ico; Flags: ignoreversion
Source: bin\*; DestDir: {app}\bin; Flags: ignoreversion recursesubdirs
Source: docs\*; DestDir: {app}\docs; Flags: ignoreversion

[Icons]
Name: {commonprograms}\Universal Extractor; Filename: {app}\bin\UniExtract.exe; WorkingDir: {app}

[Registry]
; Paths
Root: HKLM; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\UniExtract.exe; ValueType: string; ValueData: {app}\bin\UniExtract.exe; Flags: uninsdeletekey; Tasks: modifypath
Root: HKLM; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\UniExtract.exe; ValueType: string; ValueName: Path; ValueData: {app}\bin; Tasks: modifypath
Root: HKCR; SubKey: UniExtract; ValueType: string; ValueData: Universal Extractor Archive; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: UniExtract\DefaultIcon; ValueType: string; ValueData: {app}\UniExtract.ico; Tasks: associate
Root: HKCR; SubKey: UniExtract\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Tasks: associate
Root: HKCR; SubKey: UniExtract\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate
Root: HKCR; SubKey: UniExtract\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Tasks: associate
Root: HKCR; SubKey: UniExtract\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate
Root: HKCR; SubKey: UniExtract\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Tasks: associate
Root: HKCR; SubKey: UniExtract\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate
; Native Associations
Root: HKCR; SubKey: exefile\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: exefile\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate
Root: HKCR; SubKey: exefile\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: exefile\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate
Root: HKCR; SubKey: exefile\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: exefile\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate
Root: HKCR; SubKey: expandfile\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: expandfile\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate
Root: HKCR; SubKey: expandfile\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: expandfile\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate
Root: HKCR; SubKey: expandfile\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: expandfile\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate
Root: HKCR; SubKey: chm.file\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: chm.file\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate
Root: HKCR; SubKey: chm.file\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: chm.file\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate
Root: HKCR; SubKey: chm.file\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: chm.file\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate
Root: HKCR; SubKey: hlpfile\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: hlpfile\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate
Root: HKCR; SubKey: hlpfile\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: hlpfile\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate
Root: HKCR; SubKey: hlpfile\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: hlpfile\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate
Root: HKCR; SubKey: Msi.Package\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: Msi.Package\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate
Root: HKCR; SubKey: Msi.Package\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: Msi.Package\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate
Root: HKCR; SubKey: Msi.Package\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: Msi.Package\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate
; Additional Associations
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.001')
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.001')
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.001')
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.001')
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.001')
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.001')
Root: HKCR; Subkey: .001; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .001; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.7z')
Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.7z')
Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.7z')
Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.7z')
Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.7z')
Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.7z')
Root: HKCR; Subkey: .7z; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .7z; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.ace')
Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.ace')
Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.ace')
Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.ace')
Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.ace')
Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.ace')
Root: HKCR; Subkey: .ace; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .ace; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.arc')
Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.arc')
Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.arc')
Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.arc')
Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.arc')
Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.arc')
Root: HKCR; Subkey: .arc; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .arc; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.arj')
Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.arj')
Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.arj')
Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.arj')
Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.arj')
Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.arj')
Root: HKCR; Subkey: .arj; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .arj; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.bin')
Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.bin')
Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.bin')
Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.bin')
Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.bin')
Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.bin')
Root: HKCR; Subkey: .bin; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .bin; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.bz2')
Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.bz2')
Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.bz2')
Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.bz2')
Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.bz2')
Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.bz2')
Root: HKCR; Subkey: .bz2; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .bz2; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.cab')
Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.cab')
Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.cab')
Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.cab')
Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.cab')
Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.cab')
Root: HKCR; Subkey: .cab; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .cab; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.cpio')
Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.cpio')
Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.cpio')
Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.cpio')
Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.cpio')
Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.cpio')
Root: HKCR; Subkey: .cpio; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .cpio; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.cue')
Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.cue')
Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.cue')
Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.cue')
Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.cue')
Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.cue')
Root: HKCR; Subkey: .cue; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .cue; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.deb')
Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.deb')
Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.deb')
Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.deb')
Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.deb')
Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.deb')
Root: HKCR; Subkey: .deb; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .deb; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.gz')
Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.gz')
Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.gz')
Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.gz')
Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.gz')
Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.gz')
Root: HKCR; Subkey: .gz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .gz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.img')
Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.img')
Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.img')
Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.img')
Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.img')
Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.img')
Root: HKCR; Subkey: .img; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .img; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.iso')
Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.iso')
Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.iso')
Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.iso')
Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.iso')
Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.iso')
Root: HKCR; Subkey: .iso; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .iso; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.jar')
Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.jar')
Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.jar')
Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.jar')
Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.jar')
Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.jar')
Root: HKCR; Subkey: .jar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .jar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.lha')
Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.lha')
Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.lha')
Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.lha')
Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.lha')
Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.lha')
Root: HKCR; Subkey: .lha; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .lha; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.lzh')
Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.lzh')
Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.lzh')
Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.lzh')
Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.lzh')
Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.lzh')
Root: HKCR; Subkey: .lzh; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .lzh; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.lzo')
Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.lzo')
Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.lzo')
Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.lzo')
Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.lzo')
Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.lzo')
Root: HKCR; Subkey: .lzo; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .lzo; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.rar')
Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.rar')
Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.rar')
Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.rar')
Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.rar')
Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.rar')
Root: HKCR; Subkey: .rar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .rar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.lpm,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.lpm')
Root: HKCR; SubKey: {reg:HKCR\.lpm,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.lpm')
Root: HKCR; SubKey: {reg:HKCR\.lpm,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.lpm')
Root: HKCR; SubKey: {reg:HKCR\.lpm,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.lpm')
Root: HKCR; SubKey: {reg:HKCR\.lpm,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.lpm')
Root: HKCR; SubKey: {reg:HKCR\.lpm,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.lpm')
Root: HKCR; Subkey: .lpm; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .lpm; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.tar')
Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.tar')
Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.tar')
Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.tar')
Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.tar')
Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.tar')
Root: HKCR; Subkey: .tar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .tar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.tbz2')
Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.tbz2')
Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.tbz2')
Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.tbz2')
Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.tbz2')
Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.tbz2')
Root: HKCR; Subkey: .tbz2; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .tbz2; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.tgz')
Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.tgz')
Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.tgz')
Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.tgz')
Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.tgz')
Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.tgz')
Root: HKCR; Subkey: .tgz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .tgz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.tz')
Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.tz')
Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.tz')
Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.tz')
Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.tz')
Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.tz')
Root: HKCR; Subkey: .tz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .tz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.xpi')
Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.xpi')
Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.xpi')
Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.xpi')
Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.xpi')
Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.xpi')
Root: HKCR; Subkey: .xpi; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .xpi; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.z')
Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.z')
Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.z')
Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.z')
Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.z')
Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.z')
Root: HKCR; Subkey: .z; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .z; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force
Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract; ValueType: string; ValueData: UniExtract &Files...; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.zip')
Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force; Check: RVE('.zip')
Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract_here; ValueType: string; ValueData: UniExtract &Here; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.zip')
Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force; Check: RVE('.zip')
Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract_sub; ValueType: string; ValueData: UniExtract to &Subdir; Flags: uninsdeletekey; Tasks: associate and not associate\force; Check: RVE('.zip')
Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\bin\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force; Check: RVE('.zip')
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

function ModPathDir(): String;
begin
	Result := ExpandConstant('{app}') + '\bin';
end;
#include "..\..\modpath.iss"
