[Setup]
AppName=Universal Extractor
AppVerName=Universal Extractor 1.6.1
AppVersion=1.6.1
AppPublisher=Jared Breland
AppPublisherURL=http://www.legroom.net/mysoft
AppSupportURL=http://www.legroom.net/mysoft
AppUpdatesURL=http://www.legroom.net/mysoft
DefaultDirName={pf}\Universal Extractor
DefaultGroupName=Universal Extractor
DisableDirPage=false
DisableProgramGroupPage=false
OutputBaseFilename=uniextract161
OutputDir=.\
SourceDir=.\
Compression=lzma2/ultra
InternalCompressLevel=ultra
SolidCompression=true
;Compression=none
;InternalCompressLevel=none
;SolidCompression=false
AlwaysShowComponentsList=false
DisableReadyPage=false
ShowLanguageDialog=auto
;ShowLanguageDialog=yes
LanguageDetectionMethod=uilanguage
VersionInfoVersion=1.6.1
VersionInfoCompany=Jared Breland
VersionInfoCopyright=GNU General Public License v2
VersionInfoDescription=Package for Universal Extractor
ChangesEnvironment=yes
ChangesAssociations=yes
AllowUNCPath=false
AllowNoIcons=true
UninstallDisplayIcon={app}\UniExtract.exe
WizardSmallImageFile=..\support\Icons\uniextract_inno.bmp
PrivilegesRequired=admin
MinVersion=0,5.0

[Languages]
; Native
Name: de; MessagesFile: compiler:Languages\German.isl
Name: en; MessagesFile: compiler:Default.isl
Name: es; MessagesFile: compiler:Languages\Spanish.isl
Name: nl; MessagesFile: compiler:Languages\Dutch.isl
Name: fr; MessagesFile: compiler:Languages\French.isl
Name: hu; MessagesFile: compiler:Languages\Hungarian.isl
Name: it; MessagesFile: compiler:Languages\Italian.isl
Name: pl; MessagesFile: compiler:Languages\Polish.isl
Name: pt; MessagesFile: compiler:Languages\Portuguese.isl
Name: pt_BR; MessagesFile: compiler:Languages\BrazilianPortuguese.isl
Name: ru; MessagesFile: compiler:Languages\Russian.isl
Name: sk; MessagesFile: compiler:Languages\Slovak.isl
; Third-Party
Name: ar; MessagesFile: ..\support\IS_Languages\Arabic-4-5.1.11.isl
Name: bg; MessagesFile: ..\support\IS_Languages\Bulgarian-5.1.11.isl
Name: ca; MessagesFile: ..\support\IS_Languages\Valencian-1-5.1.11.isl
Name: hr; MessagesFile: ..\support\IS_Languages\Croatian-5-5.1.11.isl
Name: ja; MessagesFile: ..\support\IS_Languages\Japanese-5-5.1.11.isl
Name: ko; MessagesFile: ..\support\IS_Languages\Korean-5-5.1.11.isl
Name: ro; MessagesFile: ..\support\IS_Languages\Romanian-6-5.1.11.isl
Name: th; MessagesFile: ..\support\IS_Languages\Thai-4.0.4.isl
Name: tr; MessagesFile: ..\support\IS_Languages\Turkish-3-5.1.11.isl
Name: zh_CN; MessagesFile: ..\support\IS_Languages\ChineseSimp-11-5.1.0.isl
Name: zh_TW; MessagesFile: ..\support\IS_Languages\ChineseTrad-2-5.1.0.isl

[CustomMessages]
;forcedesc=Force &association with all supported archive formats%nWarning: This may overwrite existing associations.

[Types]
Name: custom; Description: Select which optional components are installed; Flags: iscustom

[Components]
Name: docs; Description: {code:LangRead|COMP_DOCS}; Types: custom
Name: lang; Description: {code:LangRead|COMP_LANG}; Types: custom
Name: ace; Description: {code:LangRead|COMP_ACE}; Types: custom
Name: kgb; Description: {code:LangRead|COMP_KGB}; Types: custom
Name: pea; Description: {code:LangRead|COMP_PEA}; Types: custom
Name: sit; Description: {code:LangRead|COMP_SIT}; Types: custom

[Tasks]
Name: associate; Description: {code:LangRead|ASSOCIATE}; Flags: checkablealone; Check: IsAdminLoggedOn() or IsPowerUserLoggedOn()
Name: associate\files; Description: {code:LangRead|ASSOCIATE_FILES}; Check: IsAdminLoggedOn() or IsPowerUserLoggedOn()
Name: associate\here; Description: {code:LangRead|ASSOCIATE_HERE}; Check: IsAdminLoggedOn() or IsPowerUserLoggedOn()
Name: associate\subdir; Description: {code:LangRead|ASSOCIATE_SUBDIR}; Check: IsAdminLoggedOn() or IsPowerUserLoggedOn()
Name: associate\force; Description: {code:LangRead|ASSOCIATE_FORCE}; Flags: dontinheritcheck unchecked; Check: IsAdminLoggedOn() or IsPowerUserLoggedOn()
Name: modifypath; Description: {code:LangRead|MODIFY_PATH}; Check: IsAdminLoggedOn() or IsPowerUserLoggedOn()
Name: sendtoicon; Description: {code:LangRead|SENDTO_ICON}; Flags: unchecked
Name: desktopicon; Description: {code:LangRead|DESKTOP_ICON}; Flags: unchecked
Name: quicklaunchicon; Description: {code:LangRead|QUICK_LAUNCH_ICON}; Flags: unchecked

[Files]
;Source: UniExtract.au3; DestDir: {app}; Flags: ignoreversion
Source: lang\*; DestDir: {app}\lang; Flags: ignoreversion; Components: lang
Source: English.ini; DestDir: {app}; Flags: ignoreversion
Source: docs\*; Excludes: xace*, kgb*, pea*, expander*; DestDir: {app}\docs; Flags: ignoreversion; Components: docs
Source: bin\*; Excludes: xace*, kgb*, pea*, expander*, stuffit*; DestDir: {app}\bin; Flags: ignoreversion recursesubdirs
Source: bin\xace.exe; DestDir: {app}\bin; Flags: ignoreversion; Components: ace
Source: docs\xace*; DestDir: {app}\docs; Flags: ignoreversion; Components: ace and docs
Source: bin\kgb_arch_decompress.exe; DestDir: {app}\bin; Flags: ignoreversion; Components: kgb
Source: docs\kgb*; DestDir: {app}\docs; Flags: ignoreversion; Components: kgb and docs
Source: bin\pea.exe; DestDir: {app}\bin; Flags: ignoreversion; Components: pea
Source: docs\pea*; DestDir: {app}\docs; Flags: ignoreversion; Components: pea and docs
Source: bin\Expander.exe; DestDir: {app}\bin; Flags: ignoreversion; Components: sit
Source: bin\stuffit5.engine-5.1.dll; DestDir: {app}\bin; Flags: ignoreversion; Components: sit
Source: docs\Expander*; DestDir: {app}\docs; Flags: ignoreversion; Components: sit and docs
Source: ..\uniextract_changelog.txt; DestDir: {app}; DestName: changelog.txt; Flags: ignoreversion
Source: ..\uniextract_license.txt; DestDir: {app}; DestName: license.txt; Flags: ignoreversion
Source: ..\support\Icons\UniExtract_files.ico; DestDir: {app}; DestName: UniExtract.ico; Flags: ignoreversion
Source: UniExtract.exe; DestDir: {app}; Flags: ignoreversion
Source: UniExtract.ini; DestDir: {app}; Flags: ignoreversion

[Icons]
Name: {group}\Universal Extractor; Filename: {app}\UniExtract.exe; WorkingDir: {app}
Name: {group}\Universal Extractor Preferences; Filename: {app}\UniExtract.exe; Parameters: /prefs; WorkingDir: {app}
Name: {group}\{cm:UninstallProgram,Universal Extractor}; Filename: {uninstallexe}
Name: {sendto}\Universal Extractor; Filename: {app}\UniExtract.exe; WorkingDir: {app}; Tasks: sendtoicon
Name: {userdesktop}\Universal Extractor; Filename: {app}\UniExtract.exe; WorkingDir: {app}; Tasks: desktopicon
Name: {userappdata}\Microsoft\Internet Explorer\Quick Launch\Universal Extractor; Filename: {app}\UniExtract.exe; WorkingDir: {app}; Tasks: quicklaunchicon

[INI]
Filename: {app}\UniExtract.ini; Section: UniExtract Preferences; Key: globalprefs; String: {code:GetPrefs|GlobalPrefsOpt}
Filename: {app}\UniExtract.ini; Section: UniExtract Preferences; Key: appendext; String: {code:GetPrefs|AppendExtOpt}
Filename: {app}\UniExtract.ini; Section: UniExtract Preferences; Key: history; String: {code:GetPrefs|HistoryOpt}
Filename: {app}\UniExtract.ini; Section: UniExtract Preferences; Key: removedupe; String: {code:GetPrefs|RemoveDupeOpt}
Filename: {app}\UniExtract.ini; Section: UniExtract Preferences; Key: removetemp; String: {code:GetPrefs|RemoveTempOpt}
Filename: {app}\UniExtract.ini; Section: UniExtract Preferences; Key: warnexecute; String: {code:GetPrefs|WarnExecuteOpt}
Filename: {app}\UniExtract.ini; Section: UniExtract Preferences; Key: debugdir; String: {code:GetPrefs|DebugDir}
Filename: {app}\UniExtract.ini; Section: UniExtract Preferences; Key: language; String: {code:GetPrefs|Language}; Components: lang

[Registry]
; Paths
Root: HKLM; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\UniExtract.exe; ValueType: string; ValueData: {app}\UniExtract.exe; Flags: uninsdeletekey; Tasks: modifypath
Root: HKLM; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\UniExtract.exe; ValueType: string; ValueName: Path; ValueData: {app}; Tasks: modifypath
Root: HKCR; SubKey: UniExtract; ValueType: string; ValueData: Universal Extractor Archive; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; SubKey: UniExtract\DefaultIcon; ValueType: string; ValueData: {app}\UniExtract.ico; Tasks: associate
Root: HKCR; SubKey: UniExtract\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Tasks: associate and associate\files
Root: HKCR; SubKey: UniExtract\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: UniExtract\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Tasks: associate and associate\here
Root: HKCR; SubKey: UniExtract\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: UniExtract\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Tasks: associate and associate\subdir
Root: HKCR; SubKey: UniExtract\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

; Native Associations
Root: HKCR; SubKey: .dl_\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: .dl_\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: .dl_\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: .dl_\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: .dl_\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: .dl_\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: .ex_\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: .ex_\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: .ex_\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: .ex_\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: .ex_\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: .ex_\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

;Root: HKCR; SubKey: .in_\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and associate\files
;Root: HKCR; SubKey: .in_\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
;Root: HKCR; SubKey: .in_\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and associate\here
;Root: HKCR; SubKey: .in_\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
;Root: HKCR; SubKey: .in_\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and associate\subdir
;Root: HKCR; SubKey: .in_\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

;Root: HKCR; SubKey: .oc_\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and associate\files
;Root: HKCR; SubKey: .oc_\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
;Root: HKCR; SubKey: .oc_\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and associate\here
;Root: HKCR; SubKey: .oc_\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
;Root: HKCR; SubKey: .oc_\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and associate\subdir
;Root: HKCR; SubKey: .oc_\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

;Root: HKCR; SubKey: .sr_\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and associate\files
;Root: HKCR; SubKey: .sr_\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
;Root: HKCR; SubKey: .sr_\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and associate\here
;Root: HKCR; SubKey: .sr_\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
;Root: HKCR; SubKey: .sr_\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and associate\subdir
;Root: HKCR; SubKey: .sr_\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: .sy_\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: .sy_\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: .sy_\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: .sy_\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: .sy_\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: .sy_\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: exefile\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: exefile\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: exefile\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: exefile\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: exefile\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: exefile\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: dllfile\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: dllfile\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: dllfile\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: dllfile\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: dllfile\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: dllfile\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: expandfile\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: expandfile\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: expandfile\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: expandfile\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: expandfile\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: expandfile\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: chm.file\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; OnlyBelowVersion: 0,6; Tasks: associate and associate\files
Root: HKCR; SubKey: chm.file\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; OnlyBelowVersion: 0,6; Tasks: associate and associate\files
Root: HKCR; SubKey: chm.file\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; OnlyBelowVersion: 0,6; Tasks: associate and associate\here
Root: HKCR; SubKey: chm.file\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; OnlyBelowVersion: 0,6; Tasks: associate and associate\here
Root: HKCR; SubKey: chm.file\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; OnlyBelowVersion: 0,6; Tasks: associate and associate\subdir
Root: HKCR; SubKey: chm.file\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; OnlyBelowVersion: 0,6; Tasks: associate and associate\subdir

Root: HKCR; SubKey: hlpfile\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: hlpfile\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: hlpfile\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: hlpfile\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: hlpfile\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: hlpfile\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: Msi.Package\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: Msi.Package\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: Msi.Package\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: Msi.Package\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: Msi.Package\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: Msi.Package\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

Root: HKCR; SubKey: Msi.Patch\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and associate\files
Root: HKCR; SubKey: Msi.Patch\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and associate\files
Root: HKCR; SubKey: Msi.Patch\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and associate\here
Root: HKCR; SubKey: Msi.Patch\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and associate\here
Root: HKCR; SubKey: Msi.Patch\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and associate\subdir
Root: HKCR; SubKey: Msi.Patch\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and associate\subdir

; Additional Associations

; Additional Associations
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.001')
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.001')
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.001')
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.001')
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.001')
Root: HKCR; SubKey: {reg:HKCR\.001,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.001')
Root: HKCR; Subkey: .001; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.001')
Root: HKCR; Subkey: .001; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

;Root: HKCR; SubKey: {reg:HKCR\.1,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.1')
;Root: HKCR; SubKey: {reg:HKCR\.1,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.1')
;Root: HKCR; SubKey: {reg:HKCR\.1,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.1')
;Root: HKCR; SubKey: {reg:HKCR\.1,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.1')
;Root: HKCR; SubKey: {reg:HKCR\.1,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.1')
;Root: HKCR; SubKey: {reg:HKCR\.1,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.1')
;Root: HKCR; Subkey: .1; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.1')
;Root: HKCR; Subkey: .1; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.7z')
Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.7z')
Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.7z')
Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.7z')
Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.7z')
Root: HKCR; SubKey: {reg:HKCR\.7z,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.7z')
Root: HKCR; Subkey: .7z; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.7z')
Root: HKCR; Subkey: .7z; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.ace')
Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.ace')
Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.ace')
Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.ace')
Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.ace')
Root: HKCR; SubKey: {reg:HKCR\.ace,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.ace')
Root: HKCR; Subkey: .ace; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.ace')
Root: HKCR; Subkey: .ace; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.arc')
Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.arc')
Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.arc')
Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.arc')
Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.arc')
Root: HKCR; SubKey: {reg:HKCR\.arc,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.arc')
Root: HKCR; Subkey: .arc; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.arc')
Root: HKCR; Subkey: .arc; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.arj')
Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.arj')
Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.arj')
Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.arj')
Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.arj')
Root: HKCR; SubKey: {reg:HKCR\.arj,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.arj')
Root: HKCR; Subkey: .arj; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.arj')
Root: HKCR; Subkey: .arj; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

;Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.bin')
;Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.bin')
;Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.bin')
;Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.bin')
;Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.bin')
;Root: HKCR; SubKey: {reg:HKCR\.bin,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.bin')
;Root: HKCR; Subkey: .bin; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.bin')
;Root: HKCR; Subkey: .bin; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.bz2')
Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.bz2')
Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.bz2')
Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.bz2')
Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.bz2')
Root: HKCR; SubKey: {reg:HKCR\.bz2,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.bz2')
Root: HKCR; Subkey: .bz2; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.bz2')
Root: HKCR; Subkey: .bz2; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.cab')
Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.cab')
Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.cab')
Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.cab')
Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.cab')
Root: HKCR; SubKey: {reg:HKCR\.cab,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.cab')
Root: HKCR; Subkey: .cab; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.cab')
Root: HKCR; Subkey: .cab; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.cpio')
Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.cpio')
Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.cpio')
Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.cpio')
Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.cpio')
Root: HKCR; SubKey: {reg:HKCR\.cpio,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.cpio')
Root: HKCR; Subkey: .cpio; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.cpio')
Root: HKCR; Subkey: .cpio; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.cue')
Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.cue')
Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.cue')
Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.cue')
Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.cue')
Root: HKCR; SubKey: {reg:HKCR\.cue,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.cue')
Root: HKCR; Subkey: .cue; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.cue')
Root: HKCR; Subkey: .cue; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.deb')
Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.deb')
Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.deb')
Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.deb')
Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.deb')
Root: HKCR; SubKey: {reg:HKCR\.deb,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.deb')
Root: HKCR; Subkey: .deb; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.deb')
Root: HKCR; Subkey: .deb; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.dbx,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.dbx')
Root: HKCR; SubKey: {reg:HKCR\.dbx,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.dbx')
Root: HKCR; SubKey: {reg:HKCR\.dbx,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.dbx')
Root: HKCR; SubKey: {reg:HKCR\.dbx,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.dbx')
Root: HKCR; SubKey: {reg:HKCR\.dbx,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.dbx')
Root: HKCR; SubKey: {reg:HKCR\.dbx,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.dbx')
Root: HKCR; Subkey: .dbx; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.dbx')
Root: HKCR; Subkey: .dbx; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.gz')
Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.gz')
Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.gz')
Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.gz')
Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.gz')
Root: HKCR; SubKey: {reg:HKCR\.gz,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.gz')
Root: HKCR; Subkey: .gz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.gz')
Root: HKCR; Subkey: .gz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

;Root: HKCR; SubKey: {reg:HKCR\.imf,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.imf')
;Root: HKCR; SubKey: {reg:HKCR\.imf,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.imf')
;Root: HKCR; SubKey: {reg:HKCR\.imf,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.imf')
;Root: HKCR; SubKey: {reg:HKCR\.imf,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.imf')
;Root: HKCR; SubKey: {reg:HKCR\.imf,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.imf')
;Root: HKCR; SubKey: {reg:HKCR\.imf,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.imf')
;Root: HKCR; Subkey: .imf; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.imf')
;Root: HKCR; Subkey: .imf; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.img')
Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.img')
Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.img')
Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.img')
Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.img')
Root: HKCR; SubKey: {reg:HKCR\.img,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.img')
Root: HKCR; Subkey: .img; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.img')
Root: HKCR; Subkey: .img; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.iso')
Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.iso')
Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.iso')
Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.iso')
Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.iso')
Root: HKCR; SubKey: {reg:HKCR\.iso,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.iso')
Root: HKCR; Subkey: .iso; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.iso')
Root: HKCR; Subkey: .iso; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.jar')
Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.jar')
Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.jar')
Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.jar')
Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.jar')
Root: HKCR; SubKey: {reg:HKCR\.jar,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.jar')
Root: HKCR; Subkey: .jar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.jar')
Root: HKCR; Subkey: .jar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.kgb,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.kgb')
Root: HKCR; SubKey: {reg:HKCR\.kgb,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.kgb')
Root: HKCR; SubKey: {reg:HKCR\.kgb,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.kgb')
Root: HKCR; SubKey: {reg:HKCR\.kgb,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.kgb')
Root: HKCR; SubKey: {reg:HKCR\.kgb,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.kgb')
Root: HKCR; SubKey: {reg:HKCR\.kgb,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.kgb')
Root: HKCR; Subkey: .kgb; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.kgb')
Root: HKCR; Subkey: .kgb; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.kge,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.kge')
Root: HKCR; SubKey: {reg:HKCR\.kge,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.kge')
Root: HKCR; SubKey: {reg:HKCR\.kge,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.kge')
Root: HKCR; SubKey: {reg:HKCR\.kge,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.kge')
Root: HKCR; SubKey: {reg:HKCR\.kge,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.kge')
Root: HKCR; SubKey: {reg:HKCR\.kge,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.kge')
Root: HKCR; Subkey: .kge; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.kge')
Root: HKCR; Subkey: .kge; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.lha')
Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.lha')
Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.lha')
Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.lha')
Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lha')
Root: HKCR; SubKey: {reg:HKCR\.lha,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lha')
Root: HKCR; Subkey: .lha; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.lha')
Root: HKCR; Subkey: .lha; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

;Root: HKCR; SubKey: {reg:HKCR\.lib,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.lib')
;Root: HKCR; SubKey: {reg:HKCR\.lib,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.lib')
;Root: HKCR; SubKey: {reg:HKCR\.lib,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.lib')
;Root: HKCR; SubKey: {reg:HKCR\.lib,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.lib')
;Root: HKCR; SubKey: {reg:HKCR\.lib,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lib')
;Root: HKCR; SubKey: {reg:HKCR\.lib,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lib')
;Root: HKCR; Subkey: .lib; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.lib')
;Root: HKCR; Subkey: .lib; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.lit,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.lit')
Root: HKCR; SubKey: {reg:HKCR\.lit,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.lit')
Root: HKCR; SubKey: {reg:HKCR\.lit,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.lit')
Root: HKCR; SubKey: {reg:HKCR\.lit,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.lit')
Root: HKCR; SubKey: {reg:HKCR\.lit,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lit')
Root: HKCR; SubKey: {reg:HKCR\.lit,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lit')
Root: HKCR; Subkey: .lit; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.lit')
Root: HKCR; Subkey: .lit; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.lzh')
Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.lzh')
Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.lzh')
Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.lzh')
Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lzh')
Root: HKCR; SubKey: {reg:HKCR\.lzh,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lzh')
Root: HKCR; Subkey: .lzh; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.lzh')
Root: HKCR; Subkey: .lzh; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.lzo')
Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.lzo')
Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.lzo')
Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.lzo')
Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lzo')
Root: HKCR; SubKey: {reg:HKCR\.lzo,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.lzo')
Root: HKCR; Subkey: .lzo; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.lzo')
Root: HKCR; Subkey: .lzo; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.mht,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.mht')
Root: HKCR; SubKey: {reg:HKCR\.mht,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.mht')
Root: HKCR; SubKey: {reg:HKCR\.mht,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.mht')
Root: HKCR; SubKey: {reg:HKCR\.mht,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.mht')
Root: HKCR; SubKey: {reg:HKCR\.mht,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.mht')
Root: HKCR; SubKey: {reg:HKCR\.mht,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.mht')
Root: HKCR; Subkey: .mht; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.mht')
Root: HKCR; Subkey: .mht; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.msu,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.msu')
Root: HKCR; SubKey: {reg:HKCR\.msu,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.msu')
Root: HKCR; SubKey: {reg:HKCR\.msu,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.msu')
Root: HKCR; SubKey: {reg:HKCR\.msu,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.msu')
Root: HKCR; SubKey: {reg:HKCR\.msu,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.msu')
Root: HKCR; SubKey: {reg:HKCR\.msu,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.msu')
Root: HKCR; Subkey: .msu; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.msu')
Root: HKCR; Subkey: .msu; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.pea,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.pea')
Root: HKCR; SubKey: {reg:HKCR\.pea,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.pea')
Root: HKCR; SubKey: {reg:HKCR\.pea,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.pea')
Root: HKCR; SubKey: {reg:HKCR\.pea,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.pea')
Root: HKCR; SubKey: {reg:HKCR\.pea,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.pea')
Root: HKCR; SubKey: {reg:HKCR\.pea,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.pea')
Root: HKCR; Subkey: .pea; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.pea')
Root: HKCR; Subkey: .pea; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.rar')
Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.rar')
Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.rar')
Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.rar')
Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.rar')
Root: HKCR; SubKey: {reg:HKCR\.rar,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.rar')
Root: HKCR; Subkey: .rar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.rar')
Root: HKCR; Subkey: .rar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.rpm,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.rpm')
Root: HKCR; SubKey: {reg:HKCR\.rpm,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.rpm')
Root: HKCR; SubKey: {reg:HKCR\.rpm,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.rpm')
Root: HKCR; SubKey: {reg:HKCR\.rpm,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.rpm')
Root: HKCR; SubKey: {reg:HKCR\.rpm,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.rpm')
Root: HKCR; SubKey: {reg:HKCR\.rpm,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.rpm')
Root: HKCR; Subkey: .rpm; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.rpm')
Root: HKCR; Subkey: .rpm; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.sit,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.sit')
Root: HKCR; SubKey: {reg:HKCR\.sit,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.sit')
Root: HKCR; SubKey: {reg:HKCR\.sit,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.sit')
Root: HKCR; SubKey: {reg:HKCR\.sit,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.sit')
Root: HKCR; SubKey: {reg:HKCR\.sit,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.sit')
Root: HKCR; SubKey: {reg:HKCR\.sit,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.sit')
Root: HKCR; Subkey: .sit; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.sit')
Root: HKCR; Subkey: .sit; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.tar')
Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.tar')
Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.tar')
Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.tar')
Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.tar')
Root: HKCR; SubKey: {reg:HKCR\.tar,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.tar')
Root: HKCR; Subkey: .tar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.tar')
Root: HKCR; Subkey: .tar; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.tbz2')
Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.tbz2')
Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.tbz2')
Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.tbz2')
Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.tbz2')
Root: HKCR; SubKey: {reg:HKCR\.tbz2,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.tbz2')
Root: HKCR; Subkey: .tbz2; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.tbz2')
Root: HKCR; Subkey: .tbz2; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.tgz')
Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.tgz')
Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.tgz')
Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.tgz')
Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.tgz')
Root: HKCR; SubKey: {reg:HKCR\.tgz,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.tgz')
Root: HKCR; Subkey: .tgz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.tgz')
Root: HKCR; Subkey: .tgz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.tz')
Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.tz')
Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.tz')
Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.tz')
Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.tz')
Root: HKCR; SubKey: {reg:HKCR\.tz,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.tz')
Root: HKCR; Subkey: .tz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.tz')
Root: HKCR; Subkey: .tz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.uha,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.uha')
Root: HKCR; SubKey: {reg:HKCR\.uha,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.uha')
Root: HKCR; SubKey: {reg:HKCR\.uha,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.uha')
Root: HKCR; SubKey: {reg:HKCR\.uha,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.uha')
Root: HKCR; SubKey: {reg:HKCR\.uha,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.uha')
Root: HKCR; SubKey: {reg:HKCR\.uha,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.uha')
Root: HKCR; Subkey: .uha; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.uha')
Root: HKCR; Subkey: .uha; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

;Root: HKCR; SubKey: {reg:HKCR\.wz,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.wz')
;Root: HKCR; SubKey: {reg:HKCR\.wz,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.wz')
;Root: HKCR; SubKey: {reg:HKCR\.wz,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.wz')
;Root: HKCR; SubKey: {reg:HKCR\.wz,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.wz')
;Root: HKCR; SubKey: {reg:HKCR\.wz,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.wz')
;Root: HKCR; SubKey: {reg:HKCR\.wz,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.wz')
;Root: HKCR; Subkey: .wz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.wz')
;Root: HKCR; Subkey: .wz; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.xpi')
Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.xpi')
Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.xpi')
Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.xpi')
Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.xpi')
Root: HKCR; SubKey: {reg:HKCR\.xpi,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.xpi')
Root: HKCR; Subkey: .xpi; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.xpi')
Root: HKCR; Subkey: .xpi; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.z')
Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.z')
Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.z')
Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.z')
Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.z')
Root: HKCR; SubKey: {reg:HKCR\.z,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.z')
Root: HKCR; Subkey: .z; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.z')
Root: HKCR; Subkey: .z; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract; ValueType: string; ValueData: {code:LangRead|EXTRACT_FILES}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\files; Check: RVE('.zip')
Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"""; Tasks: associate and not associate\force and associate\files; Check: RVE('.zip')
Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract_here; ValueType: string; ValueData: {code:LangRead|EXTRACT_HERE}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\here; Check: RVE('.zip')
Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract_here\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" ."; Tasks: associate and not associate\force and associate\here; Check: RVE('.zip')
Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract_sub; ValueType: string; ValueData: {code:LangRead|EXTRACT_SUB}; Flags: uninsdeletekey; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.zip')
Root: HKCR; SubKey: {reg:HKCR\.zip,}\shell\uniextract_sub\command; ValueType: string; ValueData: """{app}\uniextract.exe"" ""%1"" /sub"; Tasks: associate and not associate\force and associate\subdir; Check: RVE('.zip')
Root: HKCR; Subkey: .zip; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate and not associate\force; Check: not RVE('.zip')
Root: HKCR; Subkey: .zip; ValueType: string; ValueName: ; ValueData: UniExtract; Flags: uninsdeletekeyifempty; Tasks: associate\force

[Code]
const
	MaxLang = 23;

type
	LangArr = array[0..MaxLang] of array[0..1] of String;

var
	PrefsPage: TWizardPage;
	Header1: TNewStaticText;
	Header2: TNewStaticText;
	ComboLabel: TNewStaticText;
	ComboBox: TComboBox;
	GlobalPrefsCheckBox: TCheckBox;
	AppendExtCheckBox: TCheckBox;
	HistoryCheckBox: TCheckBox;
	RemoveDupeCheckBox: TCheckBox;
	RemoveTempCheckBox: TCheckBox;
	WarnExecuteCheckBox: TCheckBox;
	DebugEditLabel: TNewStaticText;
	DebugEditBox: TEdit;
	DebugEditButton: TButton;
	DebugDir: String;
	ComboBoxSet: Boolean;
	PrefsPageCreated: Boolean;

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


function SetupLanguages(): LangArr;
var
	languages: LangArr;

begin
	// English must always be element 0
	languages[0][0] := 'English';
	languages[0][1] := 'en';
	languages[1][0] := 'Arabic';
	languages[1][1] := 'ar';
	languages[2][0] := 'Bulgarian';
	languages[2][1] := 'bg';
	languages[3][0] := 'Chinese (Simplified)';
	languages[3][1] := 'zh_CN';
	languages[4][0] := 'Chinese (Traditional)';
	languages[4][1] := 'zh_TW';
	languages[5][0] := 'Croatian';
	languages[5][1] := 'hr';
	languages[6][0] := 'Dutch';
	languages[6][1] := 'nl';
	languages[7][0] := 'French';
	languages[7][1] := 'fr';
	languages[8][0] := 'German';
	languages[8][1] := 'de';
	languages[9][0] := 'Hungarian';
	languages[9][1] := 'hu';
	languages[10][0] := 'Italian';
	languages[10][1] := 'it';
	languages[11][0] := 'Japanese';
	languages[11][1] := 'ja';
	languages[12][0] := 'Korean';
	languages[12][1] := 'ko';
	languages[13][0] := 'Polish';
	languages[13][1] := 'pl';
	languages[14][0] := 'Portuguese';
	languages[14][1] := 'pt';
	languages[15][0] := 'Portuguese (Brazilian)';
	languages[15][1] := 'pt_BR';
	languages[16][0] := 'Romanian';
	languages[16][1] := 'ro';
	languages[17][0] := 'Russian';
	languages[17][1] := 'ru';
	languages[18][0] := 'Slovak';
	languages[18][1] := 'sk';
	languages[19][0] := 'Spanish';
	languages[19][1] := 'es';
	languages[20][0] := 'Taiwanese';
	languages[20][1] := 'zh';
	languages[21][0] := 'Thai';
	languages[21][1] := 'th';
	languages[22][0] := 'Turkish';
	languages[22][1] := 'tr';
	languages[23][0] := 'Valencian (Catalan)';
	languages[23][1] := 'ca';
	Result := languages;
end;

function GetPrefs(Item: String): String;
var
	languages: LangArr;
	i: Integer;

begin
	if Item = 'Language' then begin
		languages := SetupLanguages();
		if ComboBoxSet then begin
			for i := 0 to MaxLang do
				if ComboBox.Text = languages[i][0] then
					Result := languages[i][0];
		end else begin
			for i := 0 to MaxLang do
				if languages[i][1] = ExpandConstant('{language}') then
					Result := languages[i][0];
		end;
	end else if Item = 'DebugDir' then begin
		Result := DebugEditBox.Text;
	end else if Item = 'GlobalPrefsOpt' then begin
		if GlobalPrefsCheckBox.Checked then begin
			Result := '1';
		end else if NOT GlobalPrefsCheckBox.Checked then begin
			Result := '0';
		end;
	end else if Item = 'AppendExtOpt' then begin
		if AppendExtCheckBox.Checked then begin
			Result := '1';
		end else if NOT AppendExtCheckBox.Checked then begin
			Result := '0';
		end;
	end else if Item = 'HistoryOpt' then begin
		if HistoryCheckBox.Checked then begin
			Result := '1';
		end else if NOT HistoryCheckBox.Checked then begin
			Result := '0';
		end;
	end else if Item = 'RemoveDupeOpt' then begin
		if RemoveDupeCheckBox.Checked then begin
			Result := '1';
		end else if NOT RemoveDupeCheckBox.Checked then begin
			Result := '0';
		end;
	end else if Item = 'RemoveTempOpt' then begin
		if RemoveTempCheckBox.Checked then begin
			Result := '1';
		end else if NOT RemoveTempCheckBox.Checked then begin
			Result := '0';
		end;
	end else if Item = 'WarnExecuteOpt' then begin
		if WarnExecuteCheckBox.Checked then begin
			Result := '1';
		end else if NOT WarnExecuteCheckBox.Checked then begin
			Result := '0';
		end;
	end;
end;

function LangRead(key: String): String;
var
	inifile, inidef, value: String;

begin
	inifile := ExpandConstant('{tmp}\') + GetPrefs('Language') + '.ini';
	inidef := ExpandConstant('{tmp}\English.ini');
	value := GetIniString('Installer', key, '', inifile);
	if value = '' then begin
		Result := GetIniString('Installer', key, '', inidef);
	end else begin
		Result := value;
	end;
end;

procedure DebugEditButtonClick(Sender: TObject);
begin
	DebugDir := DebugEditBox.Text;
	BrowseforFolder('Debug File Location', DebugDir, True);
	DebugEditBox.Text := DebugDir;
end;

function InitializeSetup: Boolean;
var
	languages: LangArr;
	i: Integer;

begin
	// Extract temporary language files
	languages := SetupLanguages();
	for i := 0 to MaxLang do
		ExtractTemporaryFile(languages[i][0] + '.ini');
	Result := True;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
var
	languages: LangArr;
	i, LangMatch: Integer;
	regkey, inifile: String;

begin
	// Build the preferences page
	if CurPageId = wpSelectProgramGroup then begin
		if NOT PrefsPageCreated then begin;
			PrefsPage := CreateCustomPage(wpSelectProgramGroup,
				LangRead('PREFS_CAPTION'),
				LangRead('PREFS_DESCRIPTION'));
			languages := SetupLanguages();

			Header1 := TNewStaticText.Create(PrefsPage);
			Header1.Caption := LangRead('PREFS_LABEL1');
			Header1.AutoSize := True;
			Header1.Parent := PrefsPage.Surface;

			Header2 := TNewStaticText.Create(PrefsPage);
			Header2.Top := Header1.Top + Header1.Height + ScaleY(1);
			Header2.Caption := LangRead('PREFS_LABEL2');
			Header2.AutoSize := True;
			Header2.Parent := PrefsPage.Surface;

			if isComponentSelected('lang') then begin
				ComboLabel := TNewStaticText.Create(PrefsPage);
				ComboLabel.Top := Header2.Top + Header2.Height + ScaleY(12);
				ComboLabel.Caption := LangRead('LANGUAGE_LABEL');
				ComboLabel.AutoSize := True;
				ComboLabel.Parent := PrefsPage.Surface;

				ComboBox := TComboBox.Create(PrefsPage);
				ComboBox.Top := ComboLabel.Top + ComboLabel.Height;
				ComboBox.Width := ScaleX(130);
				ComboBox.Parent := PrefsPage.Surface;
				ComboBox.Style := csDropDownList;

				// Add all UniExtract languages to combo box
				for i := 0 to MaxLang do
					ComboBox.Items.Add(languages[i][0]);

				// Check for matching installer language
				for i := 0 to MaxLang do begin
					if languages[i][1] = ExpandConstant('{language}') then begin
						ComboBox.ItemIndex := i;
						LangMatch := 1;
					end;
				end;
				ComboBoxSet := True;

				// If installer language isn't available, set to English as default
				if LangMatch <> 1 then
					ComboBox.ItemIndex := 0;
			end;

			DebugEditLabel := TNewStaticText.Create(PrefsPage);
			if IsComponentSelected('lang') then begin
				DebugEditLabel.Top := ComboBox.Top + ComboBox.Height + ScaleY(12);
			end else begin
				DebugEditLabel.Top := Header2.Top + Header2.Height + ScaleY(12);
			end;
			DebugEditLabel.Caption := LangRead('DEBUG_LABEL');
			DebugEditLabel.AutoSize := True;
			DebugEditLabel.Parent := PrefsPage.Surface;

			DebugEditBox := TEdit.Create(PrefsPage);
			DebugEditBox.Top := DebugEditLabel.Top + DebugEditLabel.Height;
			DebugEditBox.Width := PrefsPage.SurfaceWidth - ScaleX(85);
			DebugEditBox.Text := '';
			DebugEditBox.Parent := PrefsPage.Surface;

			DebugEditButton := TButton.Create(PrefsPage);
			DebugEditButton.Top := DebugEditLabel.Top + DebugEditLabel.Height;
			DebugEditButton.Left := PrefsPage.SurfaceWidth - ScaleX(75);
			DebugEditButton.Width := ScaleX(75);
			DebugEditButton.Caption := 'B&rowse...';
			DebugEditButton.OnClick := @DebugEditButtonClick;
			DebugEditButton.Parent := PrefsPage.Surface;

			GlobalPrefsCheckBox := TCheckBox.Create(PrefsPage);
			GlobalPrefsCheckBox.Caption := '';
			GlobalPrefsCheckBox.Checked := False;
			GlobalPrefsCheckBox.Parent := PrefsPage.Surface;
			GlobalPrefsCheckBox.Visible := False;

			AppendExtCheckBox := TCheckBox.Create(PrefsPage);
			AppendExtCheckBox.Top := DebugEditBox.Top + DebugEditBox.Height + ScaleY(12);
			AppendExtCheckBox.Width := PrefsPage.SurfaceWidth;
			AppendExtCheckBox.Caption := LangRead('APPEND_EXT_LABEL');
			AppendExtCheckBox.Checked := False;
			AppendExtCheckBox.Parent := PrefsPage.Surface;

			HistoryCheckBox := TCheckBox.Create(PrefsPage);
			HistoryCheckBox.Top := AppendExtCheckBox.Top + AppendExtCheckBox.Height + ScaleY(5);
			HistoryCheckBox.Width := PrefsPage.SurfaceWidth;
			HistoryCheckBox.Caption := LangRead('HISTORY_LABEL');
			HistoryCheckBox.Checked := True;
			HistoryCheckBox.Parent := PrefsPage.Surface;

			RemoveDupeCheckBox := TCheckBox.Create(PrefsPage);
			RemoveDupeCheckBox.Top := HistoryCheckBox.Top + HistoryCheckBox.Height + ScaleY(5);
			RemoveDupeCheckBox.Width := PrefsPage.SurfaceWidth;
			RemoveDupeCheckBox.Caption := LangRead('REMOVE_DUPE_LABEL');
			RemoveDupeCheckBox.Checked := True;
			RemoveDupeCheckBox.Parent := PrefsPage.Surface;

			RemoveTempCheckBox := TCheckBox.Create(PrefsPage);
			RemoveTempCheckBox.Top := RemoveDupeCheckBox.Top + RemoveDupeCheckBox.Height + ScaleY(5);
			RemoveTempCheckBox.Width := PrefsPage.SurfaceWidth;
			RemoveTempCheckBox.Caption := LangRead('REMOVE_TEMP_LABEL');
			RemoveTempCheckBox.Checked := True;
			RemoveTempCheckBox.Parent := PrefsPage.Surface;

			WarnExecuteCheckBox := TCheckBox.Create(PrefsPage);
			WarnExecuteCheckBox.Top := RemoveTempCheckBox.Top + RemoveTempCheckBox.Height + ScaleY(5);
			WarnExecuteCheckBox.Width := PrefsPage.SurfaceWidth;
			WarnExecuteCheckBox.Caption := LangRead('WARN_EXECUTE_LABEL');
			WarnExecuteCheckBox.Checked := True;
			WarnExecuteCheckBox.Parent := PrefsPage.Surface;

			PrefsPageCreated := True;
		end;

		// Preset options if already set in INI file
		inifile := ExpandConstant('{app}\UniExtract.ini');
		if DebugEditBox.Text = '' then begin
			if IniKeyExists('UniExtract Preferences', 'debugdir', inifile) then begin
				DebugEditBox.Text := GetIniString('UniExtract Preferences', 'debugdir', ExpandConstant('{%temp}'), inifile);
			end else begin
				DebugEditBox.Text := ExpandConstant('{%temp}\');
			end;
		end;
		if not GlobalPrefsCheckBox.Checked then
			if IniKeyExists('UniExtract Preferences', 'globalprefs', inifile) then
				if GetIniString('UniExtract Preferences', 'globalprefs', '1', inifile) = '1' then
					GlobalPrefsCheckBox.Checked := True;
		if HistoryCheckBox.Checked then
			if IniKeyExists('UniExtract Preferences', 'history', inifile) then
		if not AppendExtCheckBox.Checked then
			if IniKeyExists('UniExtract Preferences', 'appendext', inifile) then
				if GetIniString('UniExtract Preferences', 'appendext', '1', inifile) = '1' then
					AppendExtCheckBox.Checked := True;
		if HistoryCheckBox.Checked then
			if IniKeyExists('UniExtract Preferences', 'history', inifile) then
				if GetIniString('UniExtract Preferences', 'history', '1', inifile) = '0' then
					HistoryCheckBox.Checked := False;
		if RemoveDupeCheckBox.Checked then
			if IniKeyExists('UniExtract Preferences', 'removedupe', inifile) then
				if GetIniString('UniExtract Preferences', 'removedupe', '1', inifile) = '0' then
					RemoveDupeCheckBox.Checked := False;
		if RemoveTempCheckBox.Checked then
			if IniKeyExists('UniExtract Preferences', 'removetemp', inifile) then
				if GetIniString('UniExtract Preferences', 'removetemp', '1', inifile) = '0' then
					RemoveTempCheckBox.Checked := False;
		if WarnExecuteCheckBox.Checked then
			if IniKeyExists('UniExtract Preferences', 'warnexecute', inifile) then
				if GetIniString('UniExtract Preferences', 'warnexecute', '1', inifile) = '0' then
					WarnExecuteCheckBox.Checked := False;

		// Preset options if passed on command line - overrides INI settings
		if paramcount() > 0 then begin
			for i:=1 to paramcount() do begin
				if Lowercase(Copy(ParamStr(i), 1, 9)) = '/debugdir' then
					DebugEditBox.Text := RemoveQuotes(Copy(ParamStr(i), 11, Length(ParamStr(i))));
				if Lowercase(Copy(ParamStr(i), 1, 12)) = '/appendext' then
					AppendExtCheckBox.Checked := True;
				if Lowercase(Copy(ParamStr(i), 1, 10)) = '/nohistory' then
					HistoryCheckBox.Checked := False;
				if Lowercase(Copy(ParamStr(i), 1, 13)) = '/noremovedupe' then
					RemoveDupeCheckBox.Checked := False;
				if Lowercase(Copy(ParamStr(i), 1, 13)) = '/noremovetemp' then
					RemoveTempCheckBox.Checked := False;
				if Lowercase(Copy(ParamStr(i), 1, 14)) = '/nowarnexecute' then
					WarnExecuteCheckBox.Checked := False;
			end;
		end;
	end;

	// Validate debugdir, set to default options if necessary
	if CurPageID = wpSelectTasks then
		if DebugEditBox.Text = '' then
			DebugEditBox.Text := ExpandConstant('{%temp}');

	Result := True;
end;

const
	ComponentList = 'docs - Documentation and licensing information | lang - Language files for internationalization support | ace - Support for ACE files | kgb - Support for KGB files | pea - Support for Pea files | sit - Support for StuffIt files';
	TaskList = 'associate - Enable Explorer context menu integration | associate\files - Add UniExtract Files... to context menu | associate\here - Add UniExtract Here to context menu | associate\subdir - Add UniExtract to Subdir to context menu | associate\force - Force association with all supported archive formats | modifypath - Add Universal Extractor to your system path | sendtoicon - Create a SendTo icon | desktopicon - Create a Desktop icon | quicklaunchicon - Create a Quick Launch icon';
	ParameterList = '/DEBUGDIR="x:\dirname" - Sets the directory used for debug file output.  This defaults to the root of your system drive (usually "C:\") | /APPENDEXT - Enables using TrID to identify and append file extensions to unknown files | /NOHISTORY - Disables archive and directory history functionality | /NOREMOVEDUPE - Duplicate files extracted by InstallExplorer will not be removed | /NOREMOVETEMP - Temporary files extracted by WUN will not be removed | /NOWARNEXECUTE - Do not display warning prompt before executing files for extraction';
#include "..\..\clihelp\clihelp.iss"

function ModPathDir(): TArrayOfString;
var
	Dir:	TArrayOfString;
begin
	setArrayLength(Dir, 2)
	Dir[0] := ExpandConstant('{app}');
	Dir[1] := ExpandConstant('{app}') + '\bin';
	Result := Dir;
end;
#include "..\..\modpath\modpath.iss"

