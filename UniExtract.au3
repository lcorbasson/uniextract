; ----------------------------------------------------------------------------
;
; Universal Extractor v1.5
; Author:	Jared Breland <jbreland@legroom.net>
; Homepage:	http://www.legroom.net/mysoft
; Language:	AutoIt v3.2.2.0
; License:	GNU General Public License v2 (http://www.gnu.org/copyleft/gpl.html)
;
; Script Function:
;	Extract known archive types
;	Use TrID to determine filetype
;	Use PEiD to identify executable filetypes
;
; ----------------------------------------------------------------------------

; Setup environment
;#notrayicon
#include <Array.au3>
#include <GUIConstants.au3>
#include <File.au3>
$name = "Universal Extractor"
$version = "1.5"
$title = $name & " v" & $version
$prefs = @scriptdir & "\UniExtract.ini"
$peidtitle = "PEiD v0.94"
$msxml4 = "http://www.microsoft.com/downloads/details.aspx?familyid=3144b72b-b4f2-46da-b4b6-c5d7485f2b42&displaylang=en"
$sysdrive = stringleft(@windowsdir, 3)
opt("GUIOnEventMode", 1)

; Preferences
global $language = "English"
global $langdir = @scriptdir & "\lang"
global $height = @desktopheight/4
global $debugdir = $sysdrive
global $history = 1
global $appendext = 1
global $removetemp = 1
global $removedupe = 1

; Global variables
dim $file, $filename, $filedir, $fileext, $initoutdir, $outdir, $filetype
dim $prompt, $packed, $return, $output, $langlist
dim $exsig, $loadplugins, $stayontop
dim $testinno, $testarj, $testace, $test7z, $testzip, $testie
dim $innofailed, $arjfailed, $acefailed, $7zfailed, $zipfailed, $iefailed
dim $oldpath
dim $exitcode = 0

; Extractors
$7z = "7z.exe"
$ace = "xace.exe"
$arc = "arc.exe"
$arj = "arj.exe"
$aspack = "AspackDie.exe"
$bin = "bin2iso.exe"
$bz2 = "7z.exe"
;$cab = "7z.exe"
$chm = "7z.exe"
;$cpio = "7z.exe"
;$deb = "7z.exe"
$dbx = "cmdTotal.exe dbxplug.wcx"
;$expand = "expand.exe"
$gz = "7z.exe"
$hlp = "helpdeco.exe"
$ie = "cmdTotal.exe InstExpl.wcx"
$imf = "7z.exe"
$img = "EXTRACT.EXE"
$inno = "innounp.exe"
$is3arc = "i3comp.exe"
$is3exe = "stix_d.exe"
$is6cab = "i6comp.exe"
$is5cab = "i5comp.exe"
$isexe = "IsXunpack.exe"
;$iswcx = "cmdTotal.exe IShield.wcx"
;$iso = "7z.exe"
$kgb = "kgb_arch_decompress.exe"
$lit = "clit.exe"
;$lzh = "7z.exe"
$lzo = "lzop.exe"
$mht = "extractMHT.exe"
$mht_ct = "cmdTotal.exe MHTUnp.wcx"
$msi_msi2xml = "msi2xml.exe"
$msi_ct = "cmdTotal.exe msi.wcx"
;$nsis = "7z.exe"
$pea = "pea.exe"
$peid = "peid.exe"
$rar = "unrar.exe"
;$rpm = "7z.exe"
$sis = "cmdTotal.exe PDunSIS.wcx"
$sit = "Expander.exe"
$tar = "7z.exe"
$trid = "trid.exe"
$uharc = "UNUHARC06.EXE"
$uharc04 = "UHARC04.EXE"
$uharc02 = "UHARC02.EXE"
$upx = "upx.exe"
$uu = "uudeview.exe"
$wise_ewise = "e_wise_w.exe"
$wise_wun = "wun.exe"
$Z = "7z.exe"
$zip = "unzip.exe"
$zoo = "booz.exe"

; Check parameters
ReadPrefs()
if $cmdline[0] = 0 then
	$prompt = 1
else
	if $cmdline[1] == "/help" OR $cmdline[1] == "/h" OR $cmdline[1] == "/?" _
						OR $cmdline[1] == "-h" OR $cmdline[1] == "-?" then
		terminate("syntax", "", "")
	else
		if fileexists($cmdline[1]) then
			$file = $cmdline[1]
		else
			terminate("syntax", "", "")
		endif
		if $cmdline[0] > 1 then
			$outdir = $cmdline[2]
		else
			$prompt = 1
		endif
	endif
endif

; If no file passed, display GUI to select file and set options
if $prompt then
	CreateGUI()
	$finishgui = 0
	while 1
		if $finishgui then exitloop
		sleep(10)
	wend
endif

; Parse filename
;$filedir = stringleft($file, stringinstr($file, '\', 0, -1)-1)
;$fileext = stringtrimleft($file, stringinstr($file, '.', 0, -1))
;$filename = stringtrimright(stringtrimleft($file, stringlen($filedir)+1), stringlen($fileext)+1)
FilenameParse($file)

; Set full output directory
if $outdir = '/sub' then
	$outdir = $initoutdir
elseif stringmid($outdir, 2, 1) <> ":" then
	if stringleft($outdir, 1) == '\' then
		$outdir = stringleft($filedir, 2) & $outdir
	else
		$outdir = _PathFull($filedir & '\' & $outdir)
	endif
endif

; Update preferences and history
WritePrefs()
if $history then
	WriteHist('file', $file)
	WriteHist('directory', $outdir)
endif

; Set environment options for appropriate version of Windows
if stringright($debugdir, 1) <> '\' then $debugdir &= '\'
$debugfile = filegetshortname($debugdir) & 'uniextract.txt'
if @OSType == "WIN32_NT" then
	$cmd = @comspec & ' /d /c '
	$output = ' 2>&1 | tee.exe ' & $debugfile
	envset("path", @scriptdir & "\bin" & ';' & envget("path"))
else
	$cmd = @comspec & ' /c '
	$output = ' | tee.exe ' & $debugfile
	$oldpath = envget("path")
	envset("path", filegetshortname(@scriptdir & "\bin") & ';' & $oldpath)
	runwait($cmd & filegetshortname(@scriptdir & '\bin\winset.exe') & ' path=' & filegetshortname(@scriptdir & '\bin'), @windowsdir, @SW_HIDE)
endif

; Extract contents from known file types
;
; UniExtract uses four methods of detection (in order):
; 1. File extensions for special cases
; 2. Binary file analysis of files using TrID
; 3. Binary file analysis of PE (executable) files using PEiD
; 4. File extensions
;
; If detection fails, extraction is always attempted 7-Zip and InfoZip

; First, check for file extensions that require special actiona
if $fileext = "ipk" OR $fileext = "tbz2" OR $fileext = "tgz" _
	OR $fileext = "tz" then
	extract("ctar", 'Compressed Tar ' & t('TERM_ARCHIVE'))

; Second, analyze file using TrID
else
	splashtexton($title, t('SCANNING_FILE'), 300, 25, -1, $height, 16)
	filescan($file)
endif

; Run PEiD scan if appropriate
; Determine type of .exe and extract if possible
if $fileext = "exe" OR stringinstr($filetype, 'Executable', 0) then

	; Check for known exe filetypes
	$scantypes = _ArrayCreate('deep', 'hard', 'ext')
	for $i = 0 to ubound($scantypes)-1
		; Run PEiD scan
		if $scantypes[$i] == 'hard' then
			$tempftype = exescan($file, $scantypes[$i])
		else
			exescan($file, $scantypes[$i])
		endif
		
		; Perform additional tests if necessary
		splashtexton($title, t('TERM_TESTING') & ' ' & t('TERM_UNKNOWN') & ' ' & t('TERM_EXECUTABLE'), 300, 25, -1, $height, 16)
		if $testinno AND NOT $innofailed then checkInno()
		if $testarj AND NOT $arjfailed then checkArj()
		if $testace AND NOT $acefailed then checkAce()
		if $test7z AND NOT $7zfailed then check7z()
		if $testzip AND NOT $zipfailed then checkZip()
		if $testie AND NOT $iefailed then checkIE()
		splashoff()
	next
	$filetype = $tempftype

	; Try 7-Zip and Unzip if all else fails
	if NOT $7zfailed then check7z()
	if NOT $zipfailed then checkZip()
	if NOT $iefailed then checkIE()

	; Unpack (vs. extract) packed file
	if $packed then unpack()

	; Exit with unknown file type
	terminate("unknownexe", $file, $filetype)

; Fourth, use file extension as if signature not recognized
elseif $fileext = "1" OR $fileext = "lib" then
	extract("is3arc", 'InstallShield 3.x ' & t('TERM_ARCHIVE'))

elseif $fileext = "7z" then
	extract("7z", '7-Zip ' & t('TERM_ARCHIVE'))

elseif $fileext = "ace" then
	extract("ace", 'ACE ' & t('TERM_ARCHIVE'))

elseif $fileext = "arc" then
	extract("arc", 'ARC ' & t('TERM_ARCHIVE'))

elseif $fileext = "arj" then
	extract("arj", 'ARJ ' & t('TERM_ARCHIVE'))

elseif $fileext = "b64" then
	extract("uu", 'Base64 ' & t('TERM_ENCODED'))

elseif $fileext = "bin" OR $fileext = "cue" then
	extract("bin", 'BIN/CUE CD-ROM ' & t('TERM_IMAGE'))

elseif $fileext = "bz2" then
	extract("bz2", 'bzip2 ' & t('TERM_COMPRESSED'))

elseif $fileext = "cab" then
	runwait($cmd & $7z & ' l "' & $file & '"' & $output, $filedir, @SW_HIDE)
	if stringinstr(filereadline($debugfile, 4), "Listing archive:", 0) then
		extract("cab", 'Microsoft CAB ' & t('TERM_ARCHIVE'))
	else
		extract("iscab", 'InstallShield CAB ' & t('TERM_ARCHIVE'))
	endif
	filedelete($debugfile)

elseif $fileext = "chm" then
	extract("chm", 'Compiled HTML ' & t('TERM_HELP'))

elseif $fileext = "cpio" then
	extract("7z", 'CPIO ' & t('TERM_ARCHIVE'))

elseif $fileext = "dbx" then
	extract("dbx", 'Outlook Express ' & t('TERM_ARCHIVE'))

elseif $fileext = "deb" then
	extract("7z", 'Debian ' & t('TERM_PACKAGE'))

elseif $fileext = "dll" then
	exescan($file, 'deep')
	if $packed then
		unpack()
	else
		terminate("unknownexe", $file, $filetype)
	endif

;elseif stringright($fileext, 1) = "_" AND stringlen($fileext) = 3 then
;	extract("expand", 'Microsoft ' & t('TERM_COMPRESSED'))

elseif $fileext = "gz" then
	extract("gz", 'gzip ' & t('TERM_COMPRESSED'))

elseif $fileext = "hlp" then
	extract("hlp", 'Windows ' & t('TERM_HELP'))

elseif $fileext = "imf" then
	extract("cab", 'IncrediMail ' & t('TERM_ECARD'))

elseif $fileext = "img" then
	extract("img", 'Floppy ' & t('TERM_DISK') & ' ' & t('TERM_IMAGE'))

elseif $fileext = "iso" then
	extract("7z", 'ISO CD-ROM ' & t('TERM_IMAGE'))

elseif $fileext = "kgb" OR $fileext = "kge" then
	extract("kgb", 'KGB ' & t('TERM_ARCHIVE'))

elseif $fileext = "lit" then
	extract("lit", 'Microsoft LIT ' & t('TERM_EBOOK'))

elseif $fileext = "lzh" OR $fileext = "lha" then
	extract("7z", 'LZH ' & t('TERM_COMPRESSED'))

elseif $fileext = "lzo" then
	extract("lzo", 'LZO ' & t('TERM_COMPRESSED'))

elseif $fileext = "mht" then
	extract("mht", 'MHTML ' & t('TERM_ARCHIVE'))
	
elseif $fileext = "msi" then
	extract("msi", 'Windows Installer (MSI) ' & t('TERM_PACKAGE'))
	
elseif $fileext = "msp" then
	extract("msp", 'Windows Installer (MSP) ' & t('TERM_PATCH'))
	
elseif $fileext = "pea" then
	extract("pea", 'Pea ' & t('TERM_ARCHIVE'))

elseif $fileext = "rar" OR $fileext = "001" OR $fileext = "cbr" then
	extract("rar", 'RAR ' & t('TERM_ARCHIVE'))

elseif $fileext = "rpm" then
	extract("7z", 'RPM ' & t('TERM_PACKAGE'))

elseif $fileext = "sis" then
	extract("sis", 'SymbianOS ' & t('TERM_INSTALLER'))

elseif $fileext = "sit" then
	extract("sit", 'StuffIt ' & t('TERM_ARCHIVE'))

elseif $fileext = "tar" then
	extract("tar", 'Tar ' & t('TERM_ARCHIVE'))

;elseif $fileext = "tbz2" OR $fileext = "tgz" OR $fileext = "tz" then
;	extract("tar", 'Compressed Tar ' & t('TERM_ARCHIVE'))

elseif $fileext = "uha" then
	extract("uha", 'UHARC ' & t('TERM_ARCHIVE'))

elseif $fileext = "uu" OR $fileext = "uue" _
	OR $fileext = "xx" OR $fileext = "xxe" then
	extract("uu", 'UUencode ' & t('TERM_ENCODED'))

elseif $fileext = "yenc" OR $fileext = "ntx" then
	extract("uu", 'yEnc ' & t('TERM_ENCODED'))

elseif $fileext = "z" then
	if NOT check7z() then extract("is3arc", 'InstallShield 3.x ' & t('TERM_ARCHIVE'))

elseif $fileext = "zip" OR $fileext = "cbz" OR $fileext = "jar" OR $fileext = "xpi" OR $fileext = "wz" then
	extract("zip", 'ZIP ' & t('TERM_ARCHIVE'))

elseif $fileext = "zoo" then
	extract("zoo", 'ZOO ' & t('TERM_ARCHIVE'))

; Unknown extension
else
	; Cannot determine filetype - abort
	splashoff()
	terminate("unknownext", $file, "")
endif

; -------------------------- Begin Custom Functions ---------------------------

; Parse filename
func FilenameParse($f)
	$filedir = stringleft($f, stringinstr($f, '\', 0, -1)-1)
	$filename = stringtrimleft($f, stringinstr($f, '\', 0, -1))
	if stringinstr($filename, '.') then
		$fileext = stringtrimleft($filename, stringinstr($filename, '.', 0, -1))
		$filename = stringtrimright($filename, stringlen($fileext)+1)
		$initoutdir = $filedir & '\' & $filename
	else
		$fileext = ''
		$initoutdir = $filedir
	endif
endfunc

; Translate text
func t($t, $vars = '')
	$return = iniread($langdir & '\' & $language & '.ini', 'UniExtract', $t, '')
	if $return == '' then $return = iniread($langdir & '\English.ini', 'UniExtract', $t, '???')
	;if stringinstr($return, ' //') then
	;	$return = stringleft($return, stringinstr($return, ' //')-1)
	;	if stringleft($return, 1) == '"' AND stringright($return, 1) == '"' then
	;		$return = stringtrimleft($return, 1)
	;		$return = stringtrimright($return, 1)
	;	endif
	;endif
	$return = stringreplace($return, '%n', @CRLF)
	$return = stringreplace($return, '%t', @TAB)
	for $i = 0 to ubound($vars)-1
		$return = stringreplace($return, '%s', $vars[$i], 1)
	next
	return $return
endfunc

; Read preferences
func ReadPrefs()
	$section = "UniExtract Preferences"
	$value = iniread($prefs, $section, "history", "")
	if $value <> '' then $history = int($value)
	$value = iniread($prefs, $section, "debugdir", "")
	if $value <> '' then $debugdir = $value
	$value = iniread($prefs, $section, "language", "")
	if $value <> '' then $language = $value
	$value = iniread($prefs, $section, "appendext", "")
	if $value <> '' then $appendext = int($value)
	$value = iniread($prefs, $section, "removetemp", "")
	if $value <> '' then $removetemp = int($value)
	$value = iniread($prefs, $section, "removedupe", "")
	if $value <> '' then $removedupe = int($value)

	; Read language files
	$langlist = ''
	local $langarr = _FileListToArray($langdir, '*.ini', 1)
	_ArrayDelete($langarr, 0)
	_ArraySort($langarr)
	for $i = 0 to ubound($langarr)-1
		$langlist &= stringtrimright($langarr[$i], 4) & '|'
	next
	$langlist = stringtrimright($langlist, 1)
endfunc

; Write preferences
func WritePrefs()
	$section = "UniExtract Preferences"
	iniwrite($prefs, $section, 'history', $history)
	iniwrite($prefs, $section, 'debugdir', $debugdir)
	iniwrite($prefs, $section, 'language', $language)
	iniwrite($prefs, $section, 'appendext', $appendext)
	iniwrite($prefs, $section, 'removetemp', $removetemp)
	iniwrite($prefs, $section, 'removedupe', $removedupe)
endfunc

; Read history
func ReadHist($field)
	if $field = 'file' then
		$section = "File History"
	elseif $field = 'directory' then
		$section = "Directory History"
	else
		return
	endif
	local $items
	for $i = 0 to 9
		$value = iniread($prefs, $section, $i, "")
		if $value <> "" then $items &= '|' & $value
	next
	$items = stringtrimleft($items, 1)
	return $items
endfunc

; Write history
func WriteHist($field, $new)
	if $field = 'file' then
		$section = "File History"
	elseif $field = 'directory' then
		$section = "Directory History"
	else
		return
	endif
	$histarr = stringsplit(ReadHist($field), '|')
	iniwrite($prefs, $section, "0", $new)
	if $histarr[1] == "" then return
	for $i = 1 to $histarr[0]
		if $i > 9 then exitloop
		if $histarr[$i] = $new then
			inidelete($prefs, $section, string($i))
			continueloop
		endif
		iniwrite($prefs, $section, string($i), $histarr[$i])
	next
endfunc

; Scan file using TrID
func filescan($f, $analyze = 1)
	; Run TrID and dump output
	runwait($cmd & $trid & ' "' & $f & '" >' & $debugfile, $filedir, @SW_HIDE)

	; Parse through results and append to string
	$filetype = ''
	$infile = fileopen($debugfile, 0)
	$line = filereadline($infile)
	do
		if stringinstr($line, '%') then $filetype &= $line
		$line = filereadline($infile)
	until @error
	fileclose($infile)

	; Return filetype without matching if specified
	if NOT $analyze then return $filetype

	; Match known patterns
	select
		case stringinstr($filetype, "7-Zip compressed archive", 0)
			extract("7z", '7-Zip ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "ACE compressed archive", 0) _
			OR stringinstr($filetype, "ACE Self-Extracting Archive", 0)
			extract("ace", t('TERM_SFX') & ' ACE ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "ARC Compressed archive", 0) _
			AND NOT stringinstr($filetype, "UHARC", 0)
			extract("arc", 'ARC ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "ARJ compressed archive", 0)
			extract("arj", 'ARJ ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "bzip2 compressed archive", 0)
			extract("bz2", 'bzip2 ' & t('TERM_COMPRESSED'))

		case stringinstr($filetype, "Microsoft Cabinet Archive", 0) _
			OR stringinstr($filetype, "IncrediMail letter/ecard", 0)
			extract("cab", 'Microsoft CAB ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "Compiled HTML Help File", 0)
			extract("chm", 'Compiled HTML ' & t('TERM_HELP'))

		case stringinstr($filetype, "CPIO Archive", 0)
			extract("7z", 'CPIO ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "Debian Linux Package", 0)
			extract("7z", 'Debian ' & t('TERM_PACKAGE'))

		case stringinstr($filetype, "Gentee Installer executable", 0)
			extract("ie", 'Gentee ' & t('TERM_INSTALLER'))

		case stringinstr($filetype, "GZipped File", 0)
			extract("gz", 'gzip ' & t('TERM_COMPRESSED'))

		case stringinstr($filetype, "Windows Help File", 0)
			extract("hlp", 'Windows ' & t('TERM_HELP'))

		case stringinstr($filetype, "Generic PC disk image", 0)
			extract("img", 'Floppy ' & t('TERM_DISK') & ' ' & t('TERM_IMAGE'))

		case stringinstr($filetype, "Inno Setup installer", 0)
			;extract("inno", 'Inno Setup ' & t('TERM_INSTALLER'))
			checkInno()

		case stringinstr($filetype, "Installer VISE executable", 0)
			extract("ie", 'Installer VISE ' & t('TERM_INSTALLER'))

		case stringinstr($filetype, "InstallShield archive", 0)
			extract("is3arc", 'InstallShield 3.x ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "InstallShield compressed archive", 0)
			extract("iscab", 'InstallShield CAB ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "ISO CD-ROM image", 0)
			extract("7z", 'ISO CD-ROM ' & t('TERM_IMAGE'))

		case stringinstr($filetype, "KGB archive", 0)
			extract("kgb", 'KGB ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "Microsoft Reader eBook", 0)
			extract("lit", 'Microsoft LIT ' & t('TERM_EBOOK'))

		case stringinstr($filetype, "LHARC/LZARK compressed archive", 0)
			extract("7z", 'LZH ' & t('TERM_COMPRESSED'))

		case stringinstr($filetype, "lzop compressed", 0)
			extract("lzo", 'LZO ' & t('TERM_COMPRESSED'))

		case stringinstr($filetype, "Microsoft Internet Explorer Web Archive", 0)
			extract("mht", 'MHTML ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "Microsoft Windows Installer package", 0)
			extract("msi", 'Windows Installer (MSI) ' & t('TERM_PACKAGE'))

		case stringinstr($filetype, "Microsoft Windows Installer patch", 0)
			extract("msp", 'Windows Installer (MSP) ' & t('TERM_PATCH'))

		case stringinstr($filetype, "Outlook Express E-mail folder", 0)
			extract("dbx", 'Outlook Express ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "PEA archive", 0)
			extract("pea", 'Pea ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "RAR Archive", 0) _
			OR stringinstr($filetype, "RAR Self Extracting archive", 0)
			extract("rar", 'RAR ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "RPM Linux Package", 0)
			extract("7z", 'RPM ' & t('TERM_PACKAGE'))

		case stringinstr($filetype, "Setup Factory 6.x Installer", 0)
			extract("ie", 'Setup Factory ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "StuffIT SIT compressed archive", 0)
			extract("sit", 'StuffIt ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "SymbianOS Installer", 0)
			extract("sis", 'SymbianOS ' & t('TERM_INSTALLER'))

		case stringinstr($filetype, "TAR archive", 0)
			extract("tar", 'Tar ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "UHARC compressed archive", 0)
			extract("uha", 'UHARC ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "Base64 Encoded file", 0)
			extract("uu", 'Base64 ' & t('TERM_ENCODED'))

		case stringinstr($filetype, "Quoted-Printable Encoded file", 0)
			extract("uu", 'Quoted-Printable ' & t('TERM_ENCODED'))

		case stringinstr($filetype, "UUencoded file", 0) _
			OR stringinstr($filetype, "XXencoded file", 0)
			extract("uu", 'UUencoded ' & t('TERM_ENCODED'))

		case stringinstr($filetype, "yEnc Encoded file", 0)
			extract("uu", 'yEnc ' & t('TERM_ENCODED'))

		case stringinstr($filetype, "Wise Installer Executable", 0)
			extract("wise", 'Wise Installer ' & t('TERM_PACKAGE'))

		case stringinstr($filetype, "UNIX Compressed file", 0)
			extract("Z", 'LZW ' & t('TERM_COMPRESSED'))

		case stringinstr($filetype, "ZIP compressed archive", 0)
			extract("zip", 'ZIP ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "ZOO compressed archive", 0)
			extract("zoo", 'ZOO ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "InstallShield setup", 0)
			extract("isexe", 'InstallShield ' & t('TERM_INSTALLER'))

	endselect
endfunc

; Scan .exe file using PEiD
func exescan($f, $scantype, $analyze = 1)
	splashtexton($title, t('SCANNING_EXE', _ArrayCreate($scantype)), 300, 25, -1, $height, 16)
	; Backup existing PEiD options
	$exsig = regread("HKCU\Software\PEiD", "ExSig")
	$loadplugins = regread("HKCU\Software\PEiD", "LoadPlugins")
	$stayontop = regread("HKCU\Software\PEiD", "StayOnTop")

	; Set PEiD options
	regwrite("HKCU\Software\PEiD", "ExSig", "REG_DWORD", 1)
	regwrite("HKCU\Software\PEiD", "LoadPlugins", "REG_DWORD", 0)
	regwrite("HKCU\Software\PEiD", "StayOnTop", "REG_DWORD", 0)

	; Analyze file in deep scan mode
	$filetype = ""
	run($peid & ' -' & $scantype & ' "' & $f & '"', @scriptdir, @SW_HIDE)
	;winwait("classname=#32770")
	winwait($peidtitle)
	while ($filetype = "") OR ($filetype = "Scanning...")
		sleep (100)
		$filetype = controlgettext($peidtitle, "", "Edit2")
	wend
	;winwait("classname=#32770")
	winclose($peidtitle)
	
	; Restore previous PEiD options
	if $exsig then regwrite("HKCU\Software\PEiD", "ExSig", "REG_DWORD", $exsig)
	if $loadplugins then regwrite("HKCU\Software\PEiD", "LoadPlugins", "REG_DWORD", $loadplugins)
	if $stayontop then regwrite("HKCU\Software\PEiD", "StayOnTop", "REG_DWORD", $stayontop)
	splashoff()

	; Return filetype without matching if specified
	if NOT $analyze then return $filetype

	; Match known patterns
	select
		case stringinstr($filetype, "ARJ SFX", 0)
			extract("arj", t('TERM_SFX') & ' ARJ ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "Borland Delphi", 0) AND NOT stringinstr($filetype, "RAR SFX", 0)
			$testinno = true
			$testzip = true

		case stringinstr($filetype, "Gentee Installer", 0)
			extract("ie", 'Gentee ' & t('TERM_INSTALLER'))

		case stringinstr($filetype, "Inno Setup", 0)
			;extract("inno", 'Inno Setup ' & t('TERM_INSTALLER'))
			checkInno()

		case stringinstr($filetype, "Installer VISE", 0)
			extract("ie", 'Installer VISE ' & t('TERM_INSTALLER'))

		case stringinstr($filetype, "InstallShield", 0)
			extract("isexe", 'InstallShield ' & t('TERM_INSTALLER'))

		case stringinstr($filetype, "KGB SFX", 0) 
			extract("kgb", t('TERM_SFX') & ' KGB ' & t('TERM_PACKAGE'))

		case stringinstr($filetype, "Microsoft Visual C++", 0) AND NOT stringinstr($filetype, "SPx Method", 0) AND NOT stringinstr($filetype, "Custom", 0)
			$test7z = true
			$testie = true

		case stringinstr($filetype, "Microsoft Visual C++ 7.0", 0) AND stringinstr($filetype, "Custom", 0)
			extract("vssfx", 'Visual C++ ' & t('TERM_SFX') & ' ' & t('TERM_INSTALLER'))

		case stringinstr($filetype, "Microsoft Visual C++ 6.0", 0) AND stringinstr($filetype, "Custom", 0)
			extract("vssfxpath", 'Visual C++ ' & t('TERM_SFX') & '' & t('TERM_INSTALLER'))

		case stringinstr($filetype, "Netopsystems FEAD Optimizer", 0)
			extract("fead", 'Netopsystems FEAD ' & t('TERM_PACKAGE'))

		case stringinstr($filetype, "Nullsoft PiMP SFX", 0)
			;extract("7z", 'NSIS ' & t('TERM_INSTALLER'))
			checkNSIS()

		case stringinstr($filetype, "PEtite", 0)
			$testarj = true
			$testace = true

		case stringinstr($filetype, "RAR SFX", 0) 
			extract("rar", t('TERM_SFX') & ' RAR ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "Setup Factory 6.x", 0)
			extract("ie", 'Setup Factory ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "SPx Method", 0) OR stringinstr($filetype, "CAB SFX", 0)
			extract("cab", t('TERM_SFX') & ' Microsoft CAB ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "SuperDAT", 0)
			extract("superdat", 'McAfee SuperDAT ' & t('TERM_UPDATER'))

		case stringinstr($filetype, "Wise", 0) OR stringinstr($filetype, "PEncrypt 4.0", 0)
			extract("wise", 'Wise Installer ' & t('TERM_PACKAGE'))

		case stringinstr($filetype, "ZIP SFX", 0)
			extract("zip", t('TERM_SFX') & ' ZIP ' & t('TERM_ARCHIVE'))

		case stringinstr($filetype, "upx", 0) OR stringinstr($filetype, "aspack", 0)
			$packed = true

		; Default case for non-PE executables - try 7zip and unzip
		case else
			$test7z = true
			$testzip = true
			$testie = true
	endselect
	return $filetype
endfunc

; Determine if 7-zip can extract the file
func check7z()
	splashtexton($title, t('TERM_TESTING') & ' 7-Zip ' & t('TERM_INSTALLER'), 300, 25, -1, $height, 16)
	runwait($cmd & $7z & ' l "' & $file & '"' & $output, $filedir, @SW_HIDE)
	if stringinstr(filereadline($debugfile, 4), "Listing archive:", 0) then
		;$infile = fileopen($debugfile, 0)
		;$line = filereadline($infile)
		;do
		;	if stringinstr($line, "_sfx_manifest_") then
		;		fileclose($infile)
		;		filedelete($debugfile)
		;		splashoff()
		;		extract("hotfix", 'Microsoft ' & t('TERM_HOTFIX'))
		;	endif
		;	$line = filereadline($infile)
		;until @error
		;fileclose($infile)
		;splashoff()
		if $fileext = "exe" then
			extract("7z", '7-Zip ' & t('TERM_INSTALLER') & ' ' & t('TERM_PACKAGE'))
		elseif $fileext = "z" then
			extract("Z", 'LZW ' & t('TERM_COMPRESSED'))
		endif
	endif
	filedelete($debugfile)
	splashoff()
	$7zfailed = true
	return false
endfunc

; Determine if InstallExplorer can extract the file
func checkIE()
	splashtexton($title, t('TERM_TESTING') & ' InstallExplorer ' & t('TERM_INSTALLER'), 300, 25, -1, $height, 16)
	runwait($cmd & $ie & ' l "' & $file & '"' & $output, $filedir, @SW_HIDE)
	if stringinstr(filereadline($debugfile, 11), '##', 0) then
		$type = stringstripws(stringreplace(stringtrimleft(filereadline($debugfile, 11), stringinstr(filereadline($debugfile, 11), '-> ', 0) + 2), '##', ''), 3)
		extract("ie", $type & ' ' & t('TERM_INSTALLER'))
	endif
	filedelete($debugfile)
	splashoff()
	$iefailed = true
	return false
endfunc

; Determine if file is Inno Setup installer
func checkInno()
	splashtexton($title, t('TERM_TESTING') & ' Inno Setup ' & t('TERM_INSTALLER'), 300, 25, -1, $height, 16)
	runwait($cmd & $inno & ' "' & $file & '" >' & $debugfile, $filedir, @SW_HIDE)
	if (stringinstr(filereadline($debugfile, 1), "Version detected:", 0) _
		AND NOT (stringinstr(filereadline($debugfile, 2), "error", 0) _
			OR stringinstr(filereadline($debugfile, 3), "error", 0))) _
		OR (stringinstr(filereadline($debugfile, 1), "Signature detected:", 0) _
			AND NOT stringinstr(filereadline($debugfile, 1), "not a supported version", 0)) then
		splashoff()
		msgbox(0, 'Test', '')
		extract("inno", 'Inno Setup ' & t('TERM_INSTALLER'))
	endif
	filedelete($debugfile)
	splashoff()
	$innofailed = true
	checkIE()
	return false
endfunc

; Determine if file is NSIS installer
func checkNSIS()
	splashtexton($title, t('TERM_TESTING') & ' NSIS ' & t('TERM_INSTALLER'), 300, 25, -1, $height, 16)
	runwait($cmd & $7z & ' l "' & $file & '"' & $output, $filedir, @SW_HIDE)
	if stringinstr(filereadline($debugfile, 4), "Listing archive:", 0) then
		splashoff()
		extract("7z", 'NSIS ' & t('TERM_INSTALLER'))
	endif
	filedelete($debugfile)
	splashoff()
	checkIE()
	return false
endfunc

; Determine if file is self-extracting Zip archive
func checkZip()
	splashtexton($title, t('TERM_TESTING') & ' SFX ZIP ' & t('TERM_ARCHIVE'), 300, 25, -1, $height, 16)
	runwait($cmd & $zip & ' -l "' & $file & '"' & $output, $filedir, @SW_HIDE)
	if NOT stringinstr(filereadline($debugfile, 2), "signature not found", 0) then
		splashoff()
		extract("zip", t('TERM_SFX') & ' ZIP ' & t('TERM_ARCHIVE'))
	endif
	filedelete($debugfile)
	splashoff()
	$zipfailed = true
	return false
endfunc

; Determine if file is self-extracting ARJ archive
func checkArj()
	splashtexton($title, t('TERM_TESTING') & ' SFX ARJ ' & t('TERM_ARCHIVE'), 300, 25, -1, $height, 16)
	runwait($cmd & $arj & ' l "' & $file & '"' & $output, $filedir, @SW_HIDE)
	if stringinstr(filereadline($debugfile, 5), "Archive created:", 0) then
		splashoff()
		extract("arj", t('TERM_SFX') & ' ARJ ' & t('TERM_ARCHIVE'))
	endif
	filedelete($debugfile)
	splashoff()
	$arjfailed = true
	return false
endfunc

; Determine if file is self-extracting ACE archive
func checkAce()
	; Ace testing handled by extract function
	extract("ace", t('TERM_SFX') & ' ACE ' & t('TERM_ARCHIVE'))
	$acefailed = true
	return false
endfunc

; Extract from known archive format
func extract($arctype, $arcdisp)
	; Display banner and create subdirectory
	global $createdir
	splashtexton($title, t('EXTRACTING') & @CRLF & $arcdisp, 300, 45, -1, $height, 16)
	if stringright($outdir, 1) = '\' then $outdir = stringtrimright($outdir, 1)
	if not fileexists($outdir) then
		$validdir = dircreate($outdir)
		if not $validdir then terminate("invaliddir", $outdir, "")
		$createdir = true
	endif
	$initdirsize = dirgetsize($outdir)
	$tempoutdir = _TempFile($outdir, 'uni_', '')

	; Extract archive based on filetype
	select
		case $arctype == "7z"
			runwait($cmd & $7z & ' x -aos "' & $file & '"' & $output, $outdir)

		case $arctype == "ace"
			opt("WinTitleMatchMode", 3)
			$pid = run($ace & ' -x "' & $file & '" "' & $outdir & '"', $filedir)
			while 1
				if NOT processexists($pid) then exitloop
				if winexists("Error") then
					processclose($pid)
					exitloop
				endif
				sleep(100)
			wend
			filewriteline($debugfile, t('CANNOT_LOG', _ArrayCreate($arcdisp)))

		case $arctype == "arc"
			runwait($cmd & $arc & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "arj"
			runwait($cmd & $arj & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "bin"
			; Prompt user to continue
			splashoff()
			$convert =  msgbox(65, $title, t('CONVERT_BIN_CUE'))
			if $convert <> 1 then
				if $createdir then dirremove($outdir, 0)
				terminate("silent", '', '')
			endif
			splashtexton($title, t('EXTRACTING') & @CRLF & $arcdisp, 300, 45, -1, $height, 16)

			; Ensure that both .bin and .cue files exist
			$binfile = $filedir & '\' & $filename & '.bin'
			$cuefile = $filedir & '\' & $filename & '.cue'
			local $missing
			if NOT fileexists($binfile) then
				$missing = 'bin'
			elseif NOT fileexists($cuefile) then
				$missing = 'cue'
			endif
			if $missing then
				splashoff()
				msgbox(48, $title, t('CONVERT_BIN_MISSING', _ArrayCreate($filedir, $filename, $missing, $filename, $filename)))
				if $createdir then dirremove($outdir, 0)
				terminate("silent", '', '')
			endif

			; Write new CUE file, stripping out comments from the original
			$newcue = $filedir & '\' & $filename & '_uniextract.cue'
			$infile = fileopen($cuefile, 0)
			$outfile = fileopen($newcue, 2)
			$line = filereadline($infile)
			do
				if stringleft($line, 4) <> 'REM ' then filewriteline($outfile, $line)
				$line = filereadline($infile)
			until @error
			fileclose($outfile)
			fileclose($infile)

			; Begin conversion to .iso format
			controlsettext($title, '', 'Static1', t('EXTRACTING') & @CRLF & 'BIN/CUE CD-ROM ' & t('TERM_IMAGE') & ' (' & t('TERM_STAGE') & ' 1)')
			runwait($cmd & $bin & ' "' & $newcue & '"' & $output, $filedir)
			$isofile = filefindfirstfile($filedir & '\' & $filename & '-*.iso')

			; Exit if conversion failed
			filedelete($newcue)
			if $isofile == -1 OR NOT fileexists($binfile) then
				splashoff()
				if NOT fileexists($binfile) then
					$isofilename = filefindnextfile($isofile)
					filemove($filedir & '\' & $isofilename, $binfile)
				endif
				fileclose($isofile)
				msgbox(64, $title, t('CONVERT_BIN_STAGE1_FAILED'))
				if $createdir then dirremove($outdir, 0)
				terminate("failed", $file, $arcdisp)

			; Otherwise, begin extraction from .iso
			else
				$isofilename = filefindnextfile($isofile)
				fileclose($isofile)
				controlsettext($title, '', 'Static1', t('EXTRACTING') & @CRLF & 'BIN/CUE CD-ROM ' & t('TERM_IMAGE') & ' (' & t('TERM_STAGE') & ' 2)')
				runwait($cmd & $7z & ' x "' & $filedir & '\' & $isofilename & '"' & $output, $outdir)

				; Prompt to keep .iso if extraction failed
				if dirgetsize($outdir) <= $initdirsize then
					$image = msgbox(52, $title, t('CONVERT_BIN_STAGE2_FAILED'))
					if $image == 7 then filedelete($filedir & '\' & $isofilename)
					if $createdir then dirremove($outdir, 0)
					terminate("silent", '', '')

				; Otherwise, delete .iso
				else
					filedelete($filedir & '\' & $isofilename)
				endif
			endif

		case $arctype == "bz2"
			runwait($cmd & $bz2 & ' x "' & $file & '"' & $output, $outdir)
			;if stringtrimleft($filename, stringinstr($filename, '.', 0, -1)) = "tar" then
			;	runwait($cmd & $tar & ' x "' & $outdir & '\' & $filename  & '"' & $output, $outdir)
			;	filedelete($outdir & '\' & $filename)
			;endif
			if fileexists($outdir & '\' & $filename) then
				runwait($cmd & $tar & ' x "' & $outdir & '\' & $filename & '"' & $output, $outdir)
				filedelete($outdir & '\' & $filename)
			endif

		case $arctype == "cab"
			if stringinstr($filetype, 'Type 1', 0) then
				runwait('"' & $file & '" /q /x:"' & $outdir & '"', $outdir)
			else
				runwait($cmd & $7z & ' x -aos "' & $file & '"' & $output, $outdir)
			endif

		case $arctype == "chm"
			runwait($cmd & $chm & ' x "' & $file & '"' & $output, $outdir)
			filedelete($outdir & '\#*')
			filedelete($outdir & '\$*')
			$dirs = filefindfirstfile($outdir & '\*')
			if $dirs <> -1 then
				$dir = filefindnextfile($dirs)
				do
					if stringleft($dir, 1) == '#' OR stringleft($dir, 1) == '$' then dirremove($outdir & '\' & $dir,  1)
					$dir = filefindnextfile($dirs)
				until @error
			endif
			fileclose($dirs)

		case $arctype == "dbx"
			runwait($cmd & $dbx & ' x "' & $file & '" "' & $outdir & '\"' & $output, $filedir)

		;case $arctype == "expand"
		;	runwait($cmd & $expand & ' -r "' & $file & '" "' & $outdir & '"' & $output, $outdir)

		case $arctype == "fead"
			$prompt = msgbox(65, $title, t('ACROREAD_PROMPT'))
			if $prompt <> 1 then
				if $createdir then dirremove($outdir, 0)
				terminate("silent", '', '')
			endif

			; Check for existing 7.x files before extraction begins
			splashtexton($title, t('INIT_WAIT'), 300, 40, -1, $height, 16)
			opt("WinTitleMatchMode", 2)
			$ar7dir = @programfilesdir & '\Adobe\Acrobat 7.0\Setup Files'
			$olddirs = ReturnFiles($ar7dir)
					
			; Wait for unpacking to complete, pull version info
			$pid = run($file, $filedir)
			if winwait("Adobe Reader", "", 15) then
				controlsettext($title, '', 'Static1', t('EXTRACTING') & @CRLF & 'Adobe Reader ' & t('TERM_INSTALLER'))
				$adobetitle = wingettitle("Adobe Reader")
				$adobever = stringleft(stringtrimleft($adobetitle, stringinstr($adobetitle, "Adobe Reader")+12), 1)
				winwaitclose($adobetitle)
				;winwait("Adobe Reader")

				; Find 7.x source directory and copy files
				dim $sourcedir
				if $adobever == '7' then
					; Check for new files
					$newdir = ""
					if fileexists($ar7dir) then
						$handle = filefindfirstfile($ar7dir & '\*')
						if NOT @error then
							while 1
								$dname = filefindnextfile($handle)
								if @error then exitloop
								if NOT stringinstr($olddirs, $dname) then
									$newdir = $dname
									exitloop
								endif
							wend
						endif
						fileclose($handle)
					endif

					; If this fails, sourcedir will be ar7dir, which is still ok
					$sourcedir = $ar7dir & '\' & $newdir
					dircopy($sourcedir, $outdir, 1)

				; Find 8.x source directory and copy files
				elseif $adobever == '8' then
					$sourcedir = @tempdir & '\' & filefindnextfile(filefindfirstfile(@tempdir & '\Adobe Reader 8*'))
					filecopy($sourcedir & '\*', $outdir, 0)
				endif

				; Exit installer
				splashoff()
				msgbox(32, $title, t('INIT_COMPLETE', _ArrayCreate(t('TERM_SUCCEEDED'))))

				; Remove old files
				if $adobever == '7' then
					filerecycle($ar7dir)
				elseif $adobever == '8' then
					filerecycle($sourcedir)
				endif

			; Not an Adobe Reader installer
			else
				splashoff()
				msgbox(48, $title, t('INIT_COMPLETE', _ArrayCreate(t('TERM_FAILED'))))
			endif
			filewriteline($debugfile, t('CANNOT_LOG', _ArrayCreate($arcdisp)))
			
		case $arctype == "gz"
			runwait($cmd & $gz & ' x "' & $file & '"' & $output, $outdir)
			;if stringtrimleft($filename, stringinstr($filename, '.', 0, -1)) = "tar" then
			;	runwait($cmd & $tar & ' x "' & $outdir & '\' & $filename  & '"' & $output, $outdir)
			;	filedelete($outdir & '\' & $filename)
			;endif
			if fileexists($outdir & '\' & $filename) then
				runwait($cmd & $tar & ' x "' & $outdir & '\' & $filename & '"' & $output, $outdir)
				filedelete($outdir & '\' & $filename)
			endif
			
		case $arctype == "hlp"
			runwait($cmd & $hlp & ' "' & $file & '"' & $output, $outdir)
			if dirgetsize($outdir) > $initdirsize then
				dircreate($tempoutdir)
				runwait($cmd & $hlp & ' /r /n "' & $file & '"' & $output, $tempoutdir)
				filemove($tempoutdir & '\' & $filename & '.rtf', $outdir & '\' & $filename & '_Reconstructed.rtf')
				dirremove($tempoutdir, 1)
			endif

		;case $arctype == "hotfix"
		;	runwait('"' & $file & '" /q /x:"' & $outdir & '"', $outdir)

		case $arctype == "ie"
			dircreate($tempoutdir)
			runwait($cmd & $ie & ' x "' & $file & '" "' & $tempoutdir & '"' & $output, $filedir)

			; Remove duplicate files
			if $removedupe then
				; Read list of extracted files from InstallExplorer
				local $iefiles[1]
				$infile = fileopen($debugfile, 0)
				$line = filereadline($infile, 12)
				do
					_ArrayAdd($iefiles, stringtrimleft($line, stringinstr($line, '-> ', 0) + 2))
					$line = filereadline($infile)
				until @error

				; Read actual extracted files
				$exfiles = FileSearch($tempoutdir)

				; Remove extracted files not listed by InstallExplorer
				for $i = 1 to $exfiles[0]
					for $j = 1 to ubound($iefiles) - 1
						if $exfiles[$i] = $tempoutdir & '\' & $iefiles[$j] then _
							continueloop 2
					next
					filedelete($exfiles[$i])
				next

				; Remove duplicate directories
				for $i = 1 to $exfiles[0]
					if stringinstr(filegetattrib($exfiles[$i]), 'D') then
						if dirgetsize($exfiles[$i]) == 0 then _
							dirremove($exfiles[$i], 1)
					endif
				next
			endif

			; Append missing file extensions
			if $appendext then
				AppendExtensions($tempoutdir)
			endif

			; Move files to output directory and remove tempdir
			MoveFiles($tempoutdir & '\ò', $tempoutdir)
			dirremove($tempoutdir & '\ò')
			MoveFiles($tempoutdir, $outdir)
			dirremove($tempoutdir)

		case $arctype == "img"
			runwait($cmd & $img & ' -x "' & $file & '"' & $output, $outdir)

		case $arctype == "inno"
			runwait($cmd & $inno & ' -x -m "' & $file & '"' & $output, $outdir)

		case $arctype == "ctar"
			; Get existing files in $outdir
			$oldfiles = ReturnFiles($outdir)

			; Decompress archive with 7-zip
			runwait($cmd & $7z & ' x "' & $file & '"' & $output, $outdir)

			; Check for new files
			$handle = filefindfirstfile($outdir & "\*")
			if NOT @error then
				while 1
					$fname = filefindnextfile($handle)
					if @error then exitloop
					if NOT stringinstr($oldfiles, $fname) then

						; Check for supported archive format
						runwait($cmd & $tar & ' l "' & $outdir & '\' & $fname & '"' & $output, $outdir, @SW_HIDE)
						if stringinstr(filereadline($debugfile, 4), "Listing archive:", 0) then
							runwait($cmd & $tar & ' x "' & $outdir & '\' & $fname & '"' & $output, $outdir, @SW_HIDE)
							filedelete($outdir & '\' & $fname)
						endif
					endif
				wend
			endif
			fileclose($handle)

		case $arctype == "is3arc"
			$choice = MethodSelect($arctype, $arcdisp)

			; Extract using ExtractMHT
			if $choice == 'i3comp' then
				runwait($cmd & $is3arc & ' "' & $file & '" *.* -d -i' & $output, $outdir)

			elseif $choice == 'STIX' then
				runwait($cmd & $is3exe & ' ' & filegetshortname($file) & ' ' & filegetshortname($outdir) & $output, $filedir)
			endif

		case $arctype == "iscab"
			; Generate list of files to extract (workaround bug in group mode)
			local $isfiles[1]
			runwait($cmd & $is6cab & ' l -o -r -d "' & $file & '"' & $output, $outdir)
			$infile = fileopen($debugfile, 0)
			$line = filereadline($infile)
			do
				_ArrayAdd($isfiles, stringtrimleft($line, stringinstr($line, ' ', 0, -1)))
				$line = filereadline($infile)
			until @error
			fileclose($infile)

			; If successful, display status window and extract files
			if $isfiles[1] <> '' then
				splashoff()
				ISCabExtract($is6cab, $isfiles, $arcdisp)
			endif

			; Otherwise, attempt to extract with i5comp
			if $isfiles[1] == '' OR dirgetsize($outdir) <= $initdirsize then
				local $isfiles[1]
				runwait($cmd & $is5cab & ' l -o -r -d "' & $file & '"' & $output, $outdir)
				$infile = fileopen($debugfile, 0)
				$line = filereadline($infile)
				do
					_ArrayAdd($isfiles, stringtrimleft($line, stringinstr($line, ' ', 0, -1)))
					$line = filereadline($infile)
				until @error
				fileclose($infile)

				; If successful, display status window and extract files
				if $isfiles[1] <> '' then
					splashoff()
					ISCabExtract($is5cab, $isfiles, $arcdisp)
				endif
			endif

		case $arctype == "isexe"
			exescan($file, 'ext', 0)
			if stringinstr($filetype, "3.x", 0) then
				; Extract 3.x SFX installer using stix
				runwait($cmd & $is3exe & ' ' & filegetshortname($file) & ' ' & filegetshortname($outdir) & $output, $filedir)

			else
				$choice = MethodSelect($arctype, $arcdisp)

				; Extract using isxunpack
				if $choice == 'isxunpack' then
					filemove($file, $outdir)
					run($cmd & $isexe & ' "' & $outdir & '\' & $filename & '.' & $fileext & '"' & $output, $outdir)
					winwait(@comspec)
					winactivate(@comspec)
					send("{ENTER}")
					processwaitclose($isexe)
					filemove($outdir & '\' & $filename & '.' & $fileext, $filedir)

				; Try to extract using cmdtotal
				;elseif $choice == 'IShield TC Packer' then
				;	runwait($cmd & $iswcx & ' x "' & $file & '" "' & $outdir & '\"' & $output, $filedir)

				; Try to extract MSI using cache switch
				elseif $choice == 'InstallShield /b' then
					; Run installer and wait for temp files to be copied
					splashtexton($title, t('INIT_WAIT'), 300, 40, -1, $height, 16)
					run('"' & $file & '" /b"' & $tempoutdir & '" /v"/l "' & $debugfile & '"', $filedir)

					; Wait for matching windows for up to 20 seconds (40 * .5)
					opt("WinTitleMatchMode", 4)
					local $success
					for $i = 1 to 40
						if NOT winexists("classname=MsiDialogCloseClass") then
							sleep(500)

						else
							; Search temp directory for MSI support and copy to tempoutdir
							$msihandle = filefindfirstfile($tempoutdir & "\*.msi")
							if NOT @error then
								while 1
									$msiname = filefindnextfile($msihandle)
									if @error then exitloop
									$tsearch = FileSearch(envget("temp") & "\" & $msiname)
									if NOT @error then
										$isdir = stringleft($tsearch[1], stringinstr($tsearch[1], '\', 0, -1)-1)
										$ishandle = filefindfirstfile($isdir & "\*")
										$fname = filefindnextfile($ishandle)
										do
											if $fname <> $msiname then _
												filecopy($isdir & "\" & $fname, $tempoutdir)
											$fname = filefindnextfile($ishandle)
										until @error
										fileclose($ishandle)
									endif
								wend
								fileclose($msihandle)
							endif

							; Move files to outdir
							splashoff()
							msgbox(32, $title, t('INIT_COMPLETE', _ArrayCreate(t('TERM_SUCCEEDED'))))
							MoveFiles($tempoutdir, $outdir)
							dirremove($tempoutdir, 1)
							$success = true
							exitloop
						endif
					next

					; Not a supported installer
					if NOT $success then
						splashoff()
						msgbox(48, $title, t('INIT_COMPLETE', _ArrayCreate(t('TERM_FAILED'))))
					endif
				endif
			endif

		case $arctype == "kgb"
			$show_stats = regread("HKCU\Software\KGB Archiver", "show_stats")
			regwrite("HKCU\Software\KGB Archiver", "show_stats", "REG_DWORD", 0)
			runwait($kgb & ' /s "' & $file & '" "' & $outdir & '"', $outdir)
			if $show_stats == "" then
				regdelete("HKCU\Software\KGB Archiver")
			else
				regwrite("HKCU\Software\KGB Archiver", "show_stats", "REG_DWORD", $show_stats)
			endif

		case $arctype == "lit"
			runwait($cmd & $lit & ' "' & $file & '" "' & $outdir & '"' & $output, $outdir)

		case $arctype == "lzo"
			runwait($cmd & $lzo & ' -d -p"' & $outdir & '" "' & $file & '"' & $output, $filedir)

		case $arctype == "mht"
			$choice = MethodSelect($arctype, $arcdisp)

			; Extract using ExtractMHT
			if $choice == 'ExtractMHT' then
				runwait($mht & ' "' & $file & '" "' & $outdir & '"')

			elseif $choice == 'MHT TC Packer' then
				dircreate($tempoutdir)
				runwait($cmd & $mht_ct & ' x "' & $file & '" "' & $tempoutdir & '\"' & $output, $tempoutdir)

				; Move files to output directory and remove tempdir
				MoveFiles($tempoutdir, $outdir)
				dirremove($tempoutdir)
			endif

		case $arctype == "msi"
			$choice = MethodSelect($arctype, $arcdisp)

			; Extract using administrative install
			if $choice == 'MSI' then
				runwait('msiexec.exe /a "' & $file & '" /qb /l ' & $debugfile & ' TARGETDIR="' & $outdir & '"', $filedir)
			
			; Extract with msi2xml
			elseif $choice == 'msi2xml' then
				runwait($cmd & $msi_msi2xml & ' -b streams -c files "' & $file & '"' & $output, $outdir)

				; Append missing file extensions
				if $appendext then
					AppendExtensions($outdir)
				endif

			; Extract with MSI Total Commander plugin
			elseif $choice == 'MSI TC Packer' then
				dircreate($tempoutdir)
				runwait($cmd & $msi_ct & ' x "' & $file & '" "' & $tempoutdir & '\"' & $output, $filedir)

				; Extract files from extracted CABs
				$cabfiles = FileSearch($tempoutdir)
				for $i = 1 to $cabfiles[0]
					filescan($cabfiles[$i], 0)
					if stringinstr($filetype, "Microsoft Cabinet Archive", 0) then
						runwait($cmd & $7z & ' x -aos "' & $cabfiles[$i] & '"' & $output, $tempoutdir)
						filedelete($cabfiles[$i])
					endif
				next

				; Append missing file extensions
				if $appendext then
					AppendExtensions($tempoutdir)
				endif

				; Move files to output directory and remove tempdir
				MoveFiles($tempoutdir, $outdir)
				dirremove($tempoutdir)
			endif

		case $arctype == "msp"
			dircreate($tempoutdir)
			runwait($cmd & $msi_ct & ' x "' & $file & '" "' & $tempoutdir & '\"' & $output, $filedir)

			; Extract files from extracted CABs
			$cabfiles = FileSearch($tempoutdir)
			for $i = 1 to $cabfiles[0]
				filescan($cabfiles[$i], 0)
				if stringinstr($filetype, "Microsoft Cabinet Archive", 0) then
					runwait($cmd & $7z & ' x -aos "' & $cabfiles[$i] & '"' & $output, $tempoutdir)
					filedelete($cabfiles[$i])
				endif
			next

			; Append missing file extensions
			if $appendext then
				AppendExtensions($tempoutdir)
			endif

			; Move files to output directory and remove tempdir
			MoveFiles($tempoutdir, $outdir)
			dirremove($tempoutdir)
			
		case $arctype == "pea"
			local $pid, $windows, $title, $status
			$pid = run($pea & ' UNPEA "' & $file & '" "' & $tempoutdir & '" RESETDATE SETATTR EXTRACT2DIR INTERACTIVE', $filedir)
			$windows = winlist("PEA")
			for $i = 0 to $windows[0][0]
				if wingetprocess($windows[$i][0]) == $pid then _
					$title = $windows[$i][0]
			next
			while processexists($pid)
				$status = controlgettext($title, '', 'Button1')
				if stringleft($status, 4) = 'Done' then processclose($pid)
				sleep(10)
			wend
			MoveFiles($tempoutdir, $outdir)
			dirremove($tempoutdir)
			filewriteline($debugfile, t('CANNOT_LOG', _ArrayCreate($arcdisp)))

		case $arctype == "rar"
			runwait($cmd & $rar & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "sis"
			runwait($cmd & $sis & ' x "' & $file & '" "' & $outdir & '\"' & $output, $filedir)

		case $arctype == "sit"
			dircreate($tempoutdir)
			filemove($file, $tempoutdir)
			runwait($sit & ' "' & $tempoutdir & '\' & $filename & '.' & $fileext & '"', $tempoutdir)
			filemove($tempoutdir & '\' & $filename & '.' & $fileext, $file)
			MoveFiles($tempoutdir & '\' & $filename, $outdir)
			dirremove($tempoutdir, 1)
			filewriteline($debugfile, t('CANNOT_LOG', _ArrayCreate($arcdisp)))

		case $arctype == "superdat"
			runwait($file & ' /e "' & $outdir & '"', $outdir)
			filemove($filedir & '\SuperDAT.log', $debugfile, 1)

		case $arctype == "tar"
			if $fileext = "tar" then
				runwait($cmd & $tar & ' x "' & $file & '"' & $output, $outdir)
			else
				runwait($cmd & $7z & ' x "' & $file & '"' & $output, $outdir)
				runwait($cmd & $tar & ' x "' & $outdir & '\' & $filename  & '.tar"' & $output, $outdir)
				filedelete($outdir & '\' & $filename & '.tar')
			endif

		case $arctype == "vssfx"
			filemove($file, $outdir)
			runwait($outdir & '\' & $filename & ' /extract', $outdir)
			filemove($outdir & '\' & $filename & '.' & $fileext, $filedir)

		case $arctype == "vssfxpath"
			runwait($file & ' /extract:"' & $outdir & '" /quiet', $outdir)

		case $arctype == "wise"
			$choice = MethodSelect($arctype, $arcdisp)

			; Extract with E_WISE
			if $choice == 'E_Wise' then
				runwait($cmd & $wise_ewise & ' "' & $file & '" "' & $outdir & '"' & $output, $filedir)
				if dirgetsize($outdir) > $initdirsize then
					runwait($cmd & '00000000.BAT', $outdir, @SW_HIDE)
					filedelete($outdir & '\00000000.BAT')
				endif

			; Extract with WUN
			elseif $choice == 'WUN' then
				runwait($cmd & $wise_wun & ' "' & $filename & '" "' & $tempoutdir & '"', $filedir)
				if $removetemp then
					filedelete($tempoutdir & "\INST0*")
					filedelete($tempoutdir & "\WISE0*")
				else
					filemove($tempoutdir & "\INST0*", $outdir)
					filemove($tempoutdir & "\WISE0*", $outdir)
				endif
				MoveFiles($tempoutdir, $outdir)
				dirremove($tempoutdir)
				filewriteline($debugfile, t('CANNOT_LOG', _ArrayCreate($arcdisp)))

			; Extract using the /x switch
			elseif $choice == 'Wise Installer /x' then
				runwait($file & ' /x ' & $outdir, $filedir)
				filewriteline($debugfile, t('CANNOT_LOG', _ArrayCreate($arcdisp)))

			; Attempt to extract MSI
			elseif $choice == 'Wise MSI' then

				; Prompt to continue
				splashoff()
				$continue = msgbox(65, $title, t('WISE_MSI_PROMPT', _ArrayCreate($name)))
				if $continue <> 1 then
					if $createdir then dirremove($outdir, 0)
					terminate("silent", '', '')
				endif

				; First, check for any files that are already in extraction dir
				splashtexton($title, t('EXTRACTING') & @CRLF & $arcdisp, 300, 45, -1, $height, 16)
				$oldfiles = ReturnFiles(@commonfilesdir & "\Wise Installation Wizard")

				; Run installer
				opt("WinTitleMatchMode", 3)
				$pid = run($file & ' /?', $filedir)
				while 1
					sleep(10)
					if winexists("Windows Installer") then
						winsetstate("Windows Installer", '', @SW_HIDE)
						exitloop
					else
						if NOT processexists($pid) then exitloop
					endif
				wend

				; Move new files
				MoveFiles(@commonfilesdir & "\Wise Installation Wizard", $outdir, 0, $oldfiles)
				dirremove(@commonfilesdir & "\Wise Installation Wizard", 0)
				winclose("Windows Installer")
				filewriteline($debugfile, t('CANNOT_LOG', _ArrayCreate($arcdisp)))

			; Extract using the /x switch
			elseif $choice == 'Unzip' then
				$return = runwait($cmd & $zip & ' -x "' & $file & '"', $outdir)
				if $return <> 0 then _
					runwait($cmd & $7z & ' x -aos "' & $file & '"' & $output, $outdir)
			endif

			; Append missing file extensions
			if $appendext then
				AppendExtensions($outdir)
			endif

		case $arctype == "uha"
			runwait($cmd & $uharc & ' x -t"' & $outdir & '" "' & $file & '"' & $output, $outdir)
			if dirgetsize($outdir) <= $initdirsize then
				$error = filereadline($debugfile, 6)
				if stringinstr($error, "use UHARC version", 0) then
					$version = stringtrimleft($error, stringinstr($error, ' ', 0, -1))
					if $version == '0.4' then
						runwait($cmd & $uharc04 & ' x -t"' & $outdir & '" "' & $file & '"' & $output, $outdir)
					elseif $version == '0.2' then
						runwait($cmd & $uharc02 & ' x -t' & filegetshortname($outdir) & ' ' & filegetshortname($file) & $output, $outdir)
					endif
				endif
			endif

		case $arctype == "uu"
			runwait($cmd & $uu & ' -p "' & $outdir & '" -i "' & $file & '"', $filedir)

		case $arctype == "Z"
			runwait($cmd & $Z & ' x "' & $file & '"' & $output, $outdir)
			if stringtrimleft($filename, stringinstr($filename, '.', 0, -1)) = "tar" then
				runwait($cmd & $tar & ' x "' & $outdir & '\' & $filename & '"' & $output, $outdir)
				filedelete($outdir & '\' & $filename)
			endif

		case $arctype == "zip"
			$return = runwait($cmd & $zip & ' -x "' & $file & '"', $outdir)
			if $return <> 0 then _
				runwait($cmd & $7z & ' x -aos "' & $file & '"' & $output, $outdir)

		case $arctype == "zoo"
			dircreate($tempoutdir)
			filemove($file, $tempoutdir)
			runwait($cmd & $zoo & ' x ' & filegetshortname($filename & '.' & $fileext) & $output, $tempoutdir)
			filemove($tempoutdir & '\' & $filename & '.' & $fileext, $file)
			MoveFiles($tempoutdir, $outdir)
			dirremove($tempoutdir)

	endselect
	
	; Check for successful output
	splashoff()
	if dirgetsize($outdir) <= $initdirsize then
		if $createdir then dirremove($outdir, 0)
		if $arctype == "ace" AND $fileext = "exe" then return false
		terminate("failed", $file, $arcdisp)
	endif
	terminate("success", "", "")
endfunc

; Unpack packed executable
func unpack()
	local $packer
	if stringinstr($filetype, "UPX", 0) OR $fileext = "dll" then
		$packer = "UPX"
	elseif stringinstr($filetype, "ASPack", 0) then
		$packer = "ASPack"
	endif

	; prompt to continue
	$unpack =  msgbox(65, $title, t('UNPACK_PROMPT', _ArrayCreate($packer, $filedir, $filename, $fileext)))
	if $unpack <> 1 then return

	; unpack file
	if $packer == "UPX" then
		runwait($cmd & $upx & ' -d -k "' & $file & '"', $filedir)
		$tempext = stringtrimright($fileext, 1) & '~'
		if fileexists($filedir & "\" & $filename & "." & $tempext) then
			filemove($file, $filedir & "\" & $filename & "_unpacked." & $fileext)
			filemove($filedir & "\" & $filename & "." & $tempext, $file)
			terminate("success", "", "")
		else
			msgbox(48, $title, t('UNPACK_FAILED', _ArrayCreate($file)))
			terminate("silent", '', '')
		endif
	elseif $packer == "ASPack" then
		runwait($cmd & $aspack & ' "' & $file & '" "' & $filedir & '\' & $filename & '_unpacked.exe" /NO_PROMPT', $filedir)
		if fileexists($filedir & "\" & $filename & "_unpacked.exe") then
			terminate("success", "", "")
			msgbox(48, $title, t('UNPACK_FAILED', _ArrayCreate($file)))
			terminate("silent", '', '')
		endif
	endif
	return
endfunc

; Return list of files and directories in directory as a pipe-delimited string
func ReturnFiles($dir)
	local $handle, $files, $fname
	$handle = filefindfirstfile($dir & "\*")
	if NOT @error then
		while 1
			$fname = filefindnextfile($handle)
			if @error then exitloop
			$files &= $fname & '|'
		wend
		stringtrimright($files, 1)
		fileclose($handle)
	else
		seterror(1)
		return
	endif
	return $files
endfunc

; Move all files and subdirectories from one directory to another
; $force is an integer that specifies whether or not to replace existing files
; $omit is a string that includes files to be excluded from move
func MoveFiles($source, $dest, $force = 0, $omit = '')
	local $handle, $fname
	dircreate($dest)
	$handle = filefindfirstfile($source & "\*")
	if NOT @error then
		while 1
			$fname = filefindnextfile($handle)
			if @error then
				exitloop
			elseif stringinstr($omit, $fname) then
				continueloop
			else
				if stringinstr(filegetattrib($source & '\' & $fname), 'D') then
					dirmove($source & '\' & $fname, $dest, 1)
				else
					filemove($source & '\' & $fname, $dest, $force)
				endif
			endif
		wend
		fileclose($handle)
	else
		seterror(1)
		return
	endif
endfunc

; Extract contents of InstallShield cabs file-by-file
func ISCabExtract($iscab, $files, $subtitle)
	progresson($title, $subtitle, '', -1, $height, 16)
	for $i = 1 to ubound($files)-1
		progressset(round($i/(ubound($files)-1), 2)*100, 'Extracting: ' & $files[$i])
		runwait($cmd & $iscab & ' x -r -d "' & $file & '" "' & $files[$i] & '"', $outdir, @SW_HIDE)
	next
	progressoff()
endfunc

; Append missing file extensions using TrID
func AppendExtensions($dir)
	if @OSType == 'WIN32_WINDOWS' then return
	local $files
	$files = FileSearch($dir)
	if $files[1] <> '' then
		for $i = 1 to $files[0]
			if NOT stringinstr(filegetattrib($files[$i]), 'D') then
				$filename = stringtrimleft($files[$i], stringinstr($files[$i], '\', 0, -1))
				if NOT stringinstr($filename, '.') _
					OR stringleft($filename, 7) = 'Binary.' _
					OR stringright($filename, 4) = '.bin' then
					runwait($cmd & $trid & ' "' & $files[$i] & '" -ae', $dir, @SW_HIDE)
				endif
			endif
		next
	endif
endfunc

; Recursively search for given pattern
; code by w0uter (http://www.autoitscript.com/forum/index.php?showtopic=16421)
func FileSearch($s_Mask = '', $i_Recurse = 1)
	local $s_Buf = ''
	if $i_Recurse then
		local $s_Command = ' /c dir /B /S "'
	else
		local $s_Command = ' /c dir /B "'
	endif
	$i_Pid = Run(@ComSpec & $s_Command & $s_Mask & '"', @WorkingDir, @SW_HIDE, 2+4)
	While Not @error
		$s_Buf &= StdoutRead($i_Pid)
	WEnd
	$s_Buf = StringSplit(StringTrimRight($s_Buf, 2), @CRLF, 1)
	ProcessClose($i_Pid)
	If UBound($s_Buf) = 2 AND $s_Buf[1] = '' Then SetError(1)
	Return $s_Buf
endfunc

; Handle program termination with appropriate error message
func terminate($status, $fname, $id)
	; Display error message if file could not be extracted
	select
		; Display usage information and exit
		case $status == "syntax"
			$syntax = t('HELP_SUMMARY')
			$syntax &= t('HELP_SYNTAX', _ArrayCreate(@scriptname))
			$syntax &= t('HELP_ARGUMENTS')
			$syntax &= t('HELP_HELP')
			$syntax &= t('HELP_FILENAME')
			$syntax &= t('HELP_DESTINATION')
			$syntax &= t('HELP_SUB', _ArrayCreate($name))
			$syntax &= t('HELP_EXAMPLE1')
			$syntax &= t('HELP_EXAMPLE2', _ArrayCreate(@scriptname))
			$syntax &= t('HELP_NOARGS', _ArrayCreate($name))
			msgbox(48, $title, $syntax)
			$exitcode = 0

		; Display file not found error and exit
		;case $status == "notfound"
		;	msgbox(48, $title, t('CANNOT_FIND', _ArrayCreate($fname)))
		;	$exitcode = 2

		; Display error information and exit
		case $status == "unknownexe"
			$prompt = msgbox(305, $title, t('CANNOT_EXTRACT', _ArrayCreate($file, $id)))
			if $prompt == 1 then
				run($peid & ' "' & $file & '"', $filedir)
				winwait($peidtitle)
				winactivate($peidtitle)
			endif
			$exitcode = 2
		case $status == "unknownext"
			msgbox(48, $title, t('UNKNOWN_EXT', _ArrayCreate($file)))
			$exitcode = 3
		case $status == "invaliddir"
			msgbox(48, $title, t('INVALID_DIR', _ArrayCreate($fname)))
			$exitcode = 4

		; Display failed attempt information and exit
		case $status == "failed"
			; Convert log to DOS format
			runwait($cmd & 'type ' & filegetshortname($debugfile) & ' >' & filegetshortname($debugdir) & 'uniextract_temp.txt', $debugdir, @SW_HIDE)
			filemove(filegetshortname($debugdir) & 'uniextract_temp.txt', $debugfile, 1)
			$prompt = msgbox(305, $title, t('EXTRACT_FAILED', _ArrayCreate($file, $id, filegetlongname($debugfile))))
			if $prompt == 1 then
				shellexecute($debugfile)
			endif
			$exitcode = 1

		; Exit successfully
		case $status == "success"
			filedelete($debugfile)
			$exitcode = 0

		; Exit silently
		case $status == "silent"
			$exitcode = 0

	endselect

	; Cleanup Win9x path due to AutoIt EnvSet() bug
	if @OSType == "WIN32_WINDOWS" AND $oldpath <> '' then _
		runwait($cmd & filegetshortname(@scriptdir & '\bin\winset.exe') & ' path=' & $oldpath, @windowsdir, @SW_HIDE)
	exit $exitcode
endfunc

; Function to prompt user for choice of extraction method
func MethodSelect($format, $splashdisp)
	; Set info base on format
	splashoff()
	$base_height = 120
	$base_radio = 90
	$url = 'dummy'
	if $format == 'wise' then
		$select_type = 'Wise Installer'
		dim $method[5][2], $select[5]
		$method[0][0] = 'E_Wise'
		$method[0][1] = 'METHOD_UNPACKER_RADIO'
		$method[1][0] = 'WUN'
		$method[1][1] = 'METHOD_UNPACKER_RADIO'
		$method[2][0] = 'Wise Installer /x'
		$method[2][1] = 'METHOD_SWITCH_RADIO'
		$method[3][0] = 'Wise MSI'
		$method[3][1] = 'METHOD_EXTRACTION_RADIO'
		$method[4][0] = 'Unzip'
		$method[4][1] = 'METHOD_EXTRACTION_RADIO'
		$base_height += 45
	elseif $format == 'msi' then
		$select_type = 'MSI Installer'
		dim $method[3][2], $select[3]
		$method[0][0] = 'MSI'
		$method[0][1] = 'METHOD_ADMIN_RADIO'
		$method[1][0] = 'msi2xml'
		$method[1][1] = 'METHOD_EXTRACTION_RADIO'
		$method[2][0] = 'MSI TC Packer'
		$method[2][1] = 'METHOD_EXTRACTION_RADIO'
		$base_height += 35
		$base_radio += 15
	elseif $format == 'mht' then
		$select_type = 'MHTML Archive'
		dim $method[2][2], $select[2]
		$method[0][0] = 'ExtractMHT'
		$method[0][1] = 'METHOD_EXTRACTION_RADIO'
		$method[1][0] = 'MHT TC Packer'
		$method[1][1] = 'METHOD_EXTRACTION_RADIO'
	elseif $format == 'is3arc' then
		$select_type = 'InstallShield 3.x Archive'
		dim $method[2][2], $select[2]
		$method[0][0] = 'i3comp'
		$method[0][1] = 'METHOD_EXTRACTION_RADIO'
		$method[1][0] = 'STIX'
		$method[1][1] = 'METHOD_EXTRACTION_RADIO'
	elseif $format == 'isexe' then
		$select_type = 'InstallShield Installer'
		dim $method[2][2], $select[2]
		$method[0][0] = 'isxunpack'
		$method[0][1] = 'METHOD_EXTRACTION_RADIO'
		$method[1][0] = 'InstallShield /b'
		$method[1][1] = 'METHOD_SWITCH_RADIO'
		;$method[2][0] = 'IShield TC Packer'
		;$method[2][1] = 'METHOD_SWITCH_RADIO'
	endif

	; Create GUI and set header information
	opt("GUIOnEventMode", 0)
	local $guimethod = GUICreate($title, 330, $base_height + (ubound($method) * 20))
	$header = GUICtrlCreateLabel(t('METHOD_HEADER', _ArrayCreate($select_type)), 5, 5, 320, 20)
	GUICtrlCreateLabel(t('METHOD_TEXT_LABEL', _ArrayCreate($name, $select_type, $name)), 5, 25, 320, 65, $SS_LEFT)
	if $format == 'msi' then
		local $note = GUICtrlCreateLabel(t('METHOD_MSI_NOTE_LABEL'), 5, 80, -1, 20)
		local $requirespos = GetPos($guimethod, $note, 0)
		local $requires = GUICtrlCreateLabel(t('METHOD_MSI_REQUIRES_LABEL'), $requirespos, 80, -1, 20)
		local $urlpos = GetPos($guimethod, $requires, -5)
		local $url = GUICtrlCreateLabel(t('METHOD_MSI_URL_LABEL'), $urlpos, 80, -1, 20)

	endif

	; Create radio selection options
	GUICtrlCreateGroup(t('METHOD_RADIO_LABEL'), 5, $base_radio, 180, 25 + (ubound($method) * 20))
	for $i = 0 to ubound($method)-1
		$select[$i] = GUICtrlCreateRadio(t($method[$i][1], _ArrayCreate($method[$i][0])), 10, $base_radio + 20 + ($i * 20), 170, 20)
	next
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	; Create checkbox for extension option
	if $format == 'msi' OR $format == 'wise' then
		$append = GUICtrlCreateCheckbox(t('METHOD_APPEND'), 5, $base_radio + 30 + ubound($method)*20, -1, 20)
	endif
	if $format == 'wise' then
		$remove = GUICtrlCreateCheckbox(t('METHOD_WISE_REMOVE'), 5, $base_radio + 50 + ubound($method)*20, -1, 20)
	endif

	; Create buttons
	$ok = GUICtrlCreateButton(t('OK_BUT'), 215, $base_radio - 10 + (ubound($method) * 10), 80, 20)
	$cancel = GUICtrlCreateButton(t('CANCEL_BUT'), 215, $base_radio - 10 + (ubound($method) * 10) + 30, 80, 20)

	; Set properties
	GUICtrlSetFont($header, -1, 1200)
	GUICtrlSetState($select[0], $GUI_CHECKED)
	GUICtrlSetState($ok, $GUI_DEFBUTTON)
	if $format == 'msi' then
		GUICtrlSetFont($note, 8.7, 800)
		GUICtrlSetFont($url, 8.7, -1, 4)
		GUICtrlSetColor($url, 0x0000ff)
		GUICtrlSetCursor($url, 0)
		if $appendext then GUICtrlSetState($append, $GUI_CHECKED)
	elseif $format == 'wise' then
		if $appendext then GUICtrlSetState($append, $GUI_CHECKED)
		if $removetemp then GUICtrlSetState($remove, $GUI_CHECKED)
	endif

	; Display GUI and wait for action
	GUISetState(@SW_SHOW)
	while 1
		$action = GUIGetMsg()
		select
			; Set extract command
			case $action == $ok
				for $i = 0 to ubound($method)-1
					if GUICtrlRead($select[$i]) == $GUI_CHECKED then
						if $format == 'msi' OR $format == 'wise' then
							if GUICtrlRead($append) == $GUI_CHECKED then
								$appendext = 1
							else
								$appendext = 0
							endif
						endif
						if $format == 'wise' then
							if GUICtrlRead($remove) == $GUI_CHECKED then
								$removetemp = 1
							else
								$removetemp = 0
							endif
						endif
						WritePrefs()
						GUIDelete()
						splashtexton($title, t('EXTRACTING') & @CRLF & $splashdisp, 300, 45, -1, $height, 16)
						return $method[$i][0]
					endif
				next

			; Exit if Cancel clicked or window closed
			case $action == $GUI_EVENT_CLOSE OR $action == $cancel
				if $createdir then dirremove($outdir, 0)
				terminate("silent", '', '')

			; Launch URL in browser (only valid for MSI)
			case $action == $url
				shellexecute($msxml4)

		endselect
	wend
endfunc


; ------------------------ Begin GUI Control Functions ------------------------

; Build and display GUI if necessary (moved to function to allow on-the-fly language changes)
func CreateGUI()
	; Create GUI
	local $guimain = GUICreate($title, 300, 195, -1, -1, -1, $WS_EX_ACCEPTFILES)
	local $dropzone = GUICtrlCreateLabel("", 0, 0, 300, 115)

	; File controls
	GUICtrlCreateLabel(t('MAIN_FILE_LABEL'), 5, 5, -1, 15)
	if $history then
		global $filecont = GUICtrlCreateCombo("", 5, 20, 260, 20 * CharCount($langlist, '|'))
	else
		global $filecont = GUICtrlCreateInput("", 5, 20, 260, 20)
	endif
	local $filebut = GUICtrlCreateButton("...", 270, 20, 25, 20)

	; Directory controls
	GUICtrlCreateLabel(t('MAIN_DEST_DIR_LABEL'), 5, 45, -1, 15)
	if $history then
		global $dircont = GUICtrlCreateCombo("", 5, 60, 260, 20 * CharCount($langlist, '|'))
	else
		global $dircont = GUICtrlCreateInput("", 5, 60, 260, 20)
	endif
	local $dirbut = GUICtrlCreateButton("...", 270, 60, 25, 20)

	; Preferences box
	GUICtrlCreateGroup(t('MAIN_PREFS_LABEL', _ArrayCreate($name)), 5, 90, 290, 70)

	; Debug controls
	local $debuglabel = GUICtrlCreateLabel(t('MAIN_DEBUG_LABEL'), 10, 113, -1, 20)
	local $debugcontpos = GetPos($guimain, $debuglabel, -5)
	global $debugcont = GUICtrlCreateInput($debugdir, $debugcontpos, 110, 300 - $debugcontpos - 40, 20)
	local $debugbut = GUICtrlCreateButton("...", 265, 110, 25, 20)

	; Language controls
	local $langlabel = GUICtrlCreateLabel(t('MAIN_LANG_LABEL'), 10, 138, -1, 15)
	local $langselectpos = GetPos($guimain, $langlabel, -5)
	global $langselect = GUICtrlCreateCombo("", $langselectpos, 135, 95, 20 * CharCount($langlist, '|'), $CBS_DROPDOWNLIST)

	; History option
	local $historyoptpos = GetPos($guimain, $langselect, 6)
	global $historyopt = GUICtrlCreateCheckBox(t('MAIN_ARCHIVE_LABEL'), $historyoptpos, 135, -1, 20)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	; Buttons
	global $ok = GUICtrlCreateButton(t('OK_BUT'), 55, 170, 80, 20)
	local $cancel = GUICtrlCreateButton(t('CANCEL_BUT'), 165, 170, 80, 20)

	; Set properties
	GUICtrlSetBkColor($dropzone, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlSetState($dropzone, $GUI_DISABLE)
	GUICtrlSetState($dropzone, $GUI_DROPACCEPTED)
	GUICtrlSetState($filecont, $GUI_FOCUS)
	GUICtrlSetState($ok, $GUI_DEFBUTTON)
	if $file <> "" then
		;$file = filegetlongname($file)
		;GUICtrlSetData($filecont, $file)
		;$filedir = stringleft($file, stringinstr($file, '\', 0, -1)-1)
		;$fileext = stringtrimleft($file, stringinstr($file, '.', 0, -1))
		;$filename = stringtrimright(stringtrimleft($file, stringlen($filedir)+1), stringlen($fileext)+1)
		FilenameParse($file)
		if $history then
			$filelist = '|' & $file & '|' & ReadHist('file')
			GUICtrlSetData($filecont, $filelist, $file)
			$dirlist = '|' & $initoutdir & '|' & ReadHist('directory')
			GUICtrlSetData($dircont, $dirlist, $initoutdir)
		else
			GUICtrlSetData($filecont, $file)
			GUICtrlSetData($dircont, $initoutdir)
		endif
		GUICtrlSetState($dircont, $GUI_FOCUS)
	elseif $history then
		GUICtrlSetData($filecont, ReadHist('file'))
		GUICtrlSetData($dircont, ReadHist('directory'))
	endif
	if $history then GUICtrlSetState($historyopt, $GUI_CHECKED)
	if stringinstr($langlist, $language, 0) then
		GUICtrlSetData($langselect, $langlist, $language)
	else
		GUICtrlSetData($langselect, $langlist, 'English')
	endif


	; Set events
	GUISetOnEvent($GUI_EVENT_DROPPED, "GUI_Drop")
	GUICtrlSetOnEvent($filebut, "GUI_File")
	GUICtrlSetOnEvent($dirbut, "GUI_Directory")
	GUICtrlSetOnEvent($debugbut, "GUI_Debug")
	GUICtrlSetOnEvent($langselect, "GUI_Lang")
	GUICtrlSetOnEvent($historyopt, "GUI_History")
	GUICtrlSetOnEvent($ok, "GUI_Ok")
	GUICtrlSetOnEvent($cancel, "GUI_Exit")
	GUISetOnEvent($GUI_EVENT_CLOSE, "GUI_Exit")

	; Display GUI and wait for action
	GUISetState(@SW_SHOW)
endfunc

; Return control width (for dynamic positioning)
func GetPos($gui, $control, $offset = 0)
    $location = controlgetpos($gui, '', $control)
	if @error then
		seterror(1, '', 0)
	else
	    return $location[0] + $location[2] + $offset
	endif
endfunc

; Return number of times a character appears in a string
func CharCount($string, $char)
	local $count = stringsplit($string, $char, 1)
	return $count[0]
endfunc

; Prompt user for file
func GUI_File()
	$file = fileopendialog(t('OPEN_FILE'), "", t('SELECT_FILE') & " (*.*)", 1)
	if not @error then
		if $history then
			$filelist = '|' & $file & '|' & ReadHist('file')
			GUICtrlSetData($filecont, $filelist, $file)
		else
			GUICtrlSetData($filecont, $file)
		endif
		if GUICtrlRead($dircont) = "" then
			;$filedir = stringleft($file, stringinstr($file, '\', 0, -1)-1)
			;$fileext = stringtrimleft($file, stringinstr($file, '.', 0, -1))
			;$filename = stringtrimright(stringtrimleft($file, stringlen($filedir)+1), stringlen($fileext)+1)
			FilenameParse($file)
			if $history then
				$dirlist = '|' & $initoutdir & '|' & ReadHist('directory')
				GUICtrlSetData($dircont, $dirlist, $initoutdir)
			else
				GUICtrlSetData($dircont, $initoutdir)
			endif
		endif
		GUICtrlSetState($ok, $GUI_FOCUS)
	endif
endfunc

; Prompt user for directory
func GUI_Directory()
	if fileexists(GUICtrlRead($dircont)) then
		$defdir = GUICtrlRead($dircont)
	elseif fileexists(GUICtrlRead($filecont)) then
		$defdir = stringleft(GUICtrlRead($filecont), stringinstr(GUICtrlRead($filecont), '\', 0, -1)-1)
	else
		$defdir = ''
	endif
	$outdir = fileselectfolder(t('EXTRACT_TO'), "", 3, $defdir)
	if not @error then
		if $history then
			$dirlist = '|' & $outdir & '|' & ReadHist('directory')
			GUICtrlSetData($dircont, $dirlist, $outdir)
		else
			GUICtrlSetData($dircont, $outdir)
		endif
	endif
endfunc

; Prompt user for debug file directory
func GUI_Debug()
	if fileexists(GUICtrlRead($debugcont)) then
		$defdir = GUICtrlRead($debugcont)
	elseif fileexists($debugdir) then
		$defdir = $debugdir
	else
		$defdir = 'C:\'
	endif
	if stringright($defdir, 1) == ':' then $defdir &= '\'
	$tempdir = fileselectfolder(t('WRITE_TO'), "", 3, $defdir)
	if not @error then GUICtrlSetData($debugcont, $tempdir)
endfunc

; Process language selection
func GUI_Lang()
	$language = GUICtrlRead($langselect)
	GUIDelete()
	CreateGUI()
endfunc

; Process history option selection
func GUI_History()
	return
endfunc

; Set file to extract and target directory, then exit
func GUI_Ok()
	; Update preferences
	if fileexists(GUICtrlRead($debugcont)) AND stringinstr(filegetattrib(GUICtrlRead($debugcont)), 'D') then
		$debugdir = GUICtrlRead($debugcont)
	else
		msgbox(48, $title, t('INVALID_DIR_SELECTED', _ArrayCreate(GUICtrlRead($debugcont))))
		return
	endif
	if GUICtrlRead($historyopt) == $GUI_CHECKED then
		$history = 1
	else
		$history = 0
		inidelete($prefs, "File History")
		inidelete($prefs, "Directory History")
	endif
	$language = GUICtrlRead($langselect)

	$file = GUICtrlRead($filecont)
	if fileexists($file) then
		if GUICtrlRead($dircont) == "" then
			$outdir = '/sub'
		else
			$outdir = GUICtrlRead($dircont)
		endif
		GUIDelete()
		$finishgui = 1
	else
		if $file == '' then
			$file = ''
		else
			$file &= ' ' & t('DOES_NOT_EXIST')
		endif
		msgbox(48, $title, t('INVALID_FILE_SELECTED', _ArrayCreate($file)))
		return
	endif
endfunc

; Process dropped files outside of file input box
func GUI_Drop()
	if fileexists(@GUI_DragFile) then
		$file = @GUI_DragFile
		if $history then
			$filelist = '|' & $file & '|' & ReadHist('file')
			GUICtrlSetData($filecont, $filelist, $file)
		else
			GUICtrlSetData($filecont, $file)
		endif
		if GUICtrlRead($dircont) = "" then
			;$filedir = stringleft($file, stringinstr($file, '\', 0, -1)-1)
			;$fileext = stringtrimleft($file, stringinstr($file, '.', 0, -1))
			;$filename = stringtrimright(stringtrimleft($file, stringlen($filedir)+1), stringlen($fileext)+1)
			FilenameParse($file)
			if $history then
				$dirlist = '|' & $initoutdir & '|' & ReadHist('directory')
				GUICtrlSetData($dircont, $dirlist, $initoutdir)
			else
				GUICtrlSetData($dircont, $initoutdir)
			endif
		endif
	endif
endfunc

; Exit if Cancel clicked or window closed
func GUI_Exit()
	terminate("silent", '', '')
endfunc

