; ----------------------------------------------------------------------------
;
; Universal Extractor v1.4.2
; Author:	Jared Breland <jbreland@legroom.net>
; Homepage:	http://www.legroom.net/mysoft
; Language:	AutoIt v3.2.0.1
; License:	GNU General Public License v2 (http://www.gnu.org/copyleft/gpl.html)
;
; Script Function:
;	Extract known archive types
;	If executable, use PEiD.exe to identify type and extract files if possible
;
; ----------------------------------------------------------------------------

; Setup environment
#notrayicon
#include <Array.au3>
#include <GUIConstants.au3>
#include <File.au3>
$name = "Universal Extractor"
$version = "1.4.2"
$title = $name & " v" & $version
$prefs = @scriptdir & "\UniExtract.ini"
$peidtitle = "PEiD v0.94"
$msxml4 = "http://www.microsoft.com/downloads/details.aspx?familyid=3144b72b-b4f2-46da-b4b6-c5d7485f2b42&displaylang=en"
$sysdrive = stringleft(@windowsdir, 3)
opt("GUIOnEventMode", 1)

; Preferences
$language = "English"
$langdir = @scriptdir & "\lang"
$height = @desktopheight/4
$debugdir = $sysdrive
$history = 1
dim $file, $filetype, $outdir, $prompt, $packed, $return, $output, $langlist
dim $exsig, $loadplugins, $stayontop
dim $testinno, $testarj, $testace, $test7z, $testzip
dim $innofailed, $arjfailed, $acefailed, $7zfailed, $zipfailed
dim $oldpath

; Extractors
$7z = "7z.exe"
$ace = "xace.exe"
$arc = "arc.exe"
$arj = "arj.exe"
$aspack = "AspackDie.exe"
$bin = "bin2iso.exe"
$bz2 = "7z.exe"
$cab = "7z.exe"
$chm = "7z.exe"
$cpio = "7z.exe"
$deb = "7z.exe"
$expand = "expand.exe"
$gz = "7z.exe"
$hlp = "helpdeco.exe"
$imf = "7z.exe"
$img = "EXTRACT.EXE"
$inno = "innounp.exe"
$is3arc = "i3comp.exe"
$iscab = "i6comp.exe"
$isexe = "IsXunpack.exe"
$iso = "7z.exe"
$kgb = "kgb_arch_decompress.exe"
$lit = "clit.exe"
$lzh = "7z.exe"
$lzo = "lzop.exe"
$mht = "extractMHT.exe"
$msi_msi2xml = "msi2xml.exe"
$nsis = "7z.exe"
$peid = "peid.exe"
$rar = "unrar.exe"
$rpm = "7z.exe"
$tar = "7z.exe"
$uharc = "UNUHARC06.EXE"
$uharc04 = "UHARC04.EXE"
$uharc02 = "UHARC02.EXE"
$upx = "upx.exe"
$wise_ewise = "e_wise_w.exe"
$wise_wun = "wun.exe"
$Z = "7z.exe"
$zip = "unzip.exe"

; Set working path, include support for .au3 path to ease development
;if stringright(@scriptname, 3) = "au3" then
	;envset("path", @scriptdir & "\bin" & ';' & envget("path"))
;else
;	envset("path", @scriptdir & ';' & envget("path"))
;endif

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
$filedir = stringleft($file, stringinstr($file, '\', 0, -1)-1)
$fileext = stringtrimleft($file, stringinstr($file, '.', 0, -1))
$filename = stringtrimright(stringtrimleft($file, stringlen($filedir)+1), stringlen($fileext)+1)

; Set full output directory
if $outdir = '/sub' then
	$outdir = $filedir & '\' & $filename
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

; Extract contents from known file extensions
if $fileext = "1" OR $fileext = "lib" then
	extract("is3arc", t('IS3ARC'))

elseif $fileext = "7z" then
	extract("7z", t('7Z'))

elseif $fileext = "ace" then
	extract("ace", t('ACE'))

elseif $fileext = "arc" then
	extract("arc", t('ARC'))

elseif $fileext = "arj" then
	extract("arj", t('ARJ'))

elseif $fileext = "bin" OR $fileext = "cue" then
	extract("bin", t('BIN'))

elseif $fileext = "bz2" then
	extract("bz2", t('BZ2'))

elseif $fileext = "cab" then
	runwait($cmd & $7z & ' l "' & $file & '"' & $output, $filedir, @SW_HIDE)
	if stringinstr(filereadline($debugfile, 4), "Listing archive:", 0) then
		extract("cab", t('CAB'))
	else
		extract("iscab", t('ISCAB'))
	endif
	filedelete($debugfile)

elseif $fileext = "chm" then
	extract("chm", t('CHM'))

elseif $fileext = "cpio" then
	extract("cpio", t('CPIO'))

elseif $fileext = "deb" then
	extract("deb", t('DEB'))

elseif $fileext = "dll" then
	exescan('deep')
	if $packed then
		unpack()
	else
		terminate("unknownexe", $file, $filetype)
	endif

elseif stringright($fileext, 1) = "_" AND stringlen($fileext) = 3 then
	extract("expand", t('EXPAND'))

elseif $fileext = "gz" then
	extract("gz", t('GZ'))

elseif $fileext = "hlp" then
	extract("hlp", t('HLP'))

elseif $fileext = "imf" then
	extract("cab", t('IMF'))

elseif $fileext = "img" then
	extract("img", t('IMG'))

elseif $fileext = "iso" then
	extract("iso", t('ISO'))

elseif $fileext = "kgb" OR $fileext = "kge" then
	extract("kgb", t('KGB'))

elseif $fileext = "lit" then
	extract("lit", t('LIT'))

elseif $fileext = "lzh" OR $fileext = "lha" then
	extract("lzh", t('LZH'))

elseif $fileext = "lzo" then
	extract("lzo", t('LZO'))

elseif $fileext = "mht" then
	extract("mht", t('MHT'))
	
elseif $fileext = "msi" then
	extract("msi", t('MSI'))
	
elseif $fileext = "rar" OR $fileext = "001" then
	extract("rar", t('RAR'))

elseif $fileext = "rpm" then
	extract("rpm", t('RPM'))

elseif $fileext = "tar" then
	extract("tar", t('TAR'))

elseif $fileext = "tbz2" OR $fileext = "tgz" OR $fileext = "tz" then
	extract("tar", t('CTAR'))

elseif $fileext = "uha" then
	extract("uha", t('UHA'))

elseif $fileext = "z" then
	if NOT check7z() then extract("is3arc", t('IS3ARC'))

elseif $fileext = "zip" OR $fileext = "jar" OR $fileext = "xpi" OR $fileext = "wz" then
	extract("zip", t('ZIP'))

; Determine type of .exe and extract if possible
elseif $fileext = "exe" then

	; Check for known exe filetypes
	$scantypes = _ArrayCreate('deep', 'hard', 'ext')
	for $i = 0 to ubound($scantypes)-1
		; Run PEiD scan
		if $scantypes[$i] == 'hard' then
			$tempftype = exescan($scantypes[$i])
		else
			exescan($scantypes[$i])
		endif
		
		; Perform additional tests if necessary
		splashtexton($title, t('UNKNOWN_EXE'), 275, 25, -1, $height, 16)
		if $testinno AND NOT $innofailed then checkInno()
		if $testarj AND NOT $arjfailed then checkArj()
		if $testace AND NOT $acefailed then checkAce()
		if $test7z AND NOT $7zfailed then check7z()
		if $testzip AND NOT $zipfailed then checkZip()
		splashoff()
	next
	$filetype = $tempftype

	; Unpack (vs. extract) packed file
	if $packed then unpack()

	; Exit with unknown file type
	terminate("unknownexe", $file, $filetype)

; Unknown extension
else
	terminate("unknownext", $file, "")
endif

; -------------------------- Begin Custom Functions ---------------------------

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
endfunc

; Read history
func ReadHist($field)
	if $field = 'file' then
		$section = "File History"
		;$reg = "HKCU\Software\UniExtract\History\File"
	elseif $field = 'directory' then
		$section = "Directory History"
		;$reg = "HKCU\Software\UniExtract\History\Directory"
	else
		return
	endif
	local $items
	for $i = 0 to 9
		;$value = regread($reg, $i)
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
		;$reg = "HKCU\Software\UniExtract\History\File"
	elseif $field = 'directory' then
		$section = "Directory History"
		;$reg = "HKCU\Software\UniExtract\History\Directory"
	else
		return
	endif
	$histarr = stringsplit(ReadHist($field), '|')
	;regwrite($reg, "0", "REG_SZ", $new)
	iniwrite($prefs, $section, "0", $new)
	if $histarr[1] == "" then return
	for $i = 1 to $histarr[0]
		if $i > 9 then exitloop
		if $histarr[$i] = $new then
			;regdelete($reg, string($i))
			inidelete($prefs, $section, string($i))
			continueloop
		endif
		;regwrite($reg, string($i), "REG_SZ", $histarr[$i])
		iniwrite($prefs, $section, string($i), $histarr[$i])
	next
endfunc

; Scan .exe file using PEiD
func exescan($scantype)
	splashtexton($title, "Scanning file with " & $scantype & " scan.", 275, 25, -1, $height, 16)
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
	run($peid & ' -' & $scantype & ' "' & $file & '"', @scriptdir, @SW_HIDE)
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

	; Match known patterns
	select
		case stringinstr($filetype, "Borland Delphi", 0) AND NOT stringinstr($filetype, "RAR SFX", 0)
			$testinno = true
			$testzip = true

		case stringinstr($filetype, "Inno Setup", 0)
			extract("inno", t('INNO'))

		case stringinstr($filetype, "InstallShield", 0)
			extract("isexe", t('ISEXE'))

		case stringinstr($filetype, "KGB SFX", 0) 
			extract("kgb", t('KGBSFX'))

		case stringinstr($filetype, "Microsoft Visual C++", 0) AND NOT stringinstr($filetype, "SPx Method", 0) AND NOT stringinstr($filetype, "Custom", 0)
			$test7z = true

		case stringinstr($filetype, "Microsoft Visual C++ 7.0", 0) AND stringinstr($filetype, "Custom", 0)
			extract("vssfx", t('VSSFX'))

		case stringinstr($filetype, "Microsoft Visual C++ 6.0", 0) AND stringinstr($filetype, "Custom", 0)
			extract("vssfxpath", t('VSSFX'))

		case stringinstr($filetype, "Nullsoft PiMP SFX", 0)
			extract("nsis", t('NSIS'))

		case stringinstr($filetype, "PEtite", 0)
			$testarj = true
			$testace = true

		case stringinstr($filetype, "RAR SFX", 0) 
			extract("rar", t('RARSFX'))

		case stringinstr($filetype, "SPx Method", 0) OR stringinstr($filetype, "CAB SFX", 0)
			extract("cab", t('CABSFX'))

		case stringinstr($filetype, "SuperDAT", 0)
			extract("superdat", t('SUPERDAT'))

		case stringinstr($filetype, "Wise", 0) OR stringinstr($filetype, "PEncrypt 4.0", 0)
			extract("wise", t('WISE'))

		case stringinstr($filetype, "ZIP SFX", 0)
			extract("zip", t('ZIPSFX'))

		case stringinstr($filetype, "upx", 0) OR stringinstr($filetype, "aspack", 0)
			$packed = true

		; Default case for non-PE executables - try 7zip and unzip
		case else
			$test7z = true
			$testzip = true
	endselect
	return $filetype
endfunc

; Determine if 7-zip can extract the file
func check7z()
	splashtexton($title, t('TEST_7Z'), 275, 25, -1, $height, 16)
	runwait($cmd & $7z & ' l "' & $file & '"' & $output, $filedir, @SW_HIDE)
	if stringinstr(filereadline($debugfile, 4), "Listing archive:", 0) then
		$infile = fileopen($debugfile, 0)
		$line = filereadline($infile)
		do
			if stringinstr($line, "_sfx_manifest_") then
				fileclose($infile)
				filedelete($debugfile)
				splashoff()
				extract("hotfix", t('HOTFIX'))
			endif
			$line = filereadline($infile)
		until @error
		fileclose($infile)
		splashoff()
		if $fileext = "exe" then
			extract("7z", t('7ZINST'))
		elseif $fileext = "z" then
			extract("Z", t('LZW'))
		endif
	endif
	filedelete($debugfile)
	splashoff()
	$7zfailed = true
	return false
endfunc

; Determine if file is Inno Setup installer
func checkInno()
	splashtexton($title, t('TEST_INNO'), 275, 25, -1, $height, 16)
	runwait($cmd & $inno & ' "' & $file & '"' & $output, $filedir, @SW_HIDE)
	if stringinstr(filereadline($debugfile, 1), "Version detected:", 0) _
	 OR stringinstr(filereadline($debugfile, 1), "Signature detected:", 0) then
		splashoff()
		extract("inno", t('INNO'))
	endif
	filedelete($debugfile)
	splashoff()
	$innofailed = true
	return false
endfunc

; Determine if file is self-extracting Zip archive
func checkZip()
	splashtexton($title, t('TEST_ZIP'), 275, 25, -1, $height, 16)
	runwait($cmd & $zip & ' -l "' & $file & '"' & $output, $filedir, @SW_HIDE)
	if NOT stringinstr(filereadline($debugfile, 2), "signature not found", 0) then
		splashoff()
		extract("zip", t('ZIPSFX'))
	endif
	filedelete($debugfile)
	splashoff()
	$zipfailed = true
	return false
endfunc

; Determine if file is self-extracting ARJ archive
func checkArj()
	splashtexton($title, t('TEST_ARJ'), 275, 25, -1, $height, 16)
	runwait($cmd & $arj & ' l "' & $file & '"' & $output, $filedir, @SW_HIDE)
	if stringinstr(filereadline($debugfile, 5), "Archive created:", 0) then
		splashoff()
		extract("arj", t('ARJSFX'))
	endif
	filedelete($debugfile)
	splashoff()
	$arjfailed = true
	return false
endfunc

; Determine if file is self-extracting ACE archive
func checkAce()
	; No way to test, just try extracting
	extract("ace", t('ACESFX'))
endfunc

; Extract from known archive format
func extract($arctype, $arcdisp)
	; Display banner and create subdirectory
	dim $createdir
	splashtexton($title, t('EXTRACTING') & @CRLF & $arcdisp, 275, 45, -1, $height, 16)
	if not fileexists($outdir) then
		$validdir = dircreate($outdir)
		if not $validdir then terminate("invaliddir", $outdir, "")
		$createdir = 1
	endif

	; Extract archive based on filetype
	select
		case $arctype == "7z"
			;runwait($cmd & $7z & ' x -aos "' & $file & '"' & $output, $outdir)
			runwait($cmd & $7z & ' x -aos "' & $file & '"' & $output, $outdir)

		case $arctype == "ace"
			runwait($cmd & $ace & ' -x "' & $file & '" "' & $outdir & '"' & $output, $filedir)

		case $arctype == "arc"
			runwait($cmd & $arc & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "arj"
			runwait($cmd & $arj & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "bin"
			$convert =  msgbox(65, $title, t('CONVERT_BIN_CUE'))
			if $convert <> 1 then
				dirremove($outdir, 0)
				terminate("silent", '', '')
			endif
			if NOT fileexists($filedir & '\' & $filename & ".bin") then
				msgbox(48, $title, t('CONVERT_BIN_MISSING_BIN', _ArrayCreate($filedir, $filename, $filename, $filename)))
				dirremove($outdir, 0)
				terminate("silent", '', '')
			endif
			if NOT fileexists($filedir & '\' & $filename & ".cue") then
				msgbox(48, $title, t('CONVERT_BIN_MISSING_CUE', _ArrayCreate($filedir, $filename, $filename, $filename)))
				dirremove($outdir, 0)
				terminate("silent", '', '')
			endif
			controlsettext($title, '', 'Static1', t('CONVERT_BIN_STAGE1'))
			runwait($cmd & $bin & ' "' & $filedir & '\' & $filename & '.cue"' & $output, $filedir)
			$isofile = filefindfirstfile($filedir & '\' & $filename & '-*.iso')
			if $isofile == -1 then
				msgbox(64, $title, t('CONVERT_BIN_STAGE1_FAILED'))
				dirremove($outdir, 0)
				terminate("failed", $file, $arcdisp)
			else
				$isofilename = filefindnextfile($isofile)
				controlsettext($title, '', 'Static1', t('CONVERT_BIN_STAGE2'))
				runwait($cmd & $iso & ' x "' & $filedir & '\' & $isofilename & '"' & $output, $outdir)
				if dirgetsize($outdir) == 0 then
					$image = msgbox(51, $title, t('CONVERT_BIN_STAGE2_FAILED'))
					if $image == 7 then filedelete($filedir & '\' & $isofilename)
					dirremove($outdir, 0)
					terminate("silent", '', '')
				else
					filedelete($filedir & '\' & $isofilename)
				endif
			endif

		case $arctype == "bz2"
			runwait($cmd & $bz2 & ' x "' & $file & '"' & $output, $outdir)
			if stringtrimleft($filename, stringinstr($filename, '.', 0, -1)) = "tar" then
				runwait($cmd & $tar & ' x "' & $outdir & '\' & $filename  & '"' & $output, $outdir)
				filedelete($outdir & '\' & $filename)
			endif

		case $arctype == "cab"
			runwait($cmd & $cab & ' x -aos "' & $file & '"' & $output, $outdir)

		case $arctype == "chm"
			runwait($cmd & $chm & ' x "' & $file & '"' & $output, $outdir)
			filedelete($outdir & '\#*')
			filedelete($outdir & '\$*')
			$dirs = filefindfirstfile($outdir & '\*')
			if $dirs <> -1 then
				$dir = filefindnextfile($dirs)
				do
					if stringleft($dir, 1) == '#' OR stringleft($dir, 1) == '$' then
						dirremove($outdir & '\' & $dir,  1)
					endif
					$dir = filefindnextfile($dirs)
				until @error
			endif
			fileclose($dirs)

		case $arctype == "cpio"
			runwait($cmd & $cpio & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "deb"
			runwait($cmd & $deb & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "expand"
			runwait($cmd & $expand & ' -r "' & $file & '" "' & $outdir & '"' & $output, $outdir)

		case $arctype == "gz"
			runwait($cmd & $gz & ' x "' & $file & '"' & $output, $outdir)
			if stringtrimleft($filename, stringinstr($filename, '.', 0, -1)) = "tar" then
				runwait($cmd & $tar & ' x "' & $outdir & '\' & $filename  & '"' & $output, $outdir)
				filedelete($outdir & '\' & $filename)
			endif
			
		case $arctype == "hlp"
			runwait($cmd & $hlp & ' "' & $file & '"' & $output, $outdir)
			if dirgetsize($outdir) <> 0 then
				dircreate($outdir & '\Reconstructed')
				runwait($cmd & $hlp & ' /r /n "' & $file & '"' & $output, $outdir & '\Reconstructed')
				filemove($outdir & '\Reconstructed\' & $filename & '.rtf', $outdir & '\' & $filename & '_Reconstructed.rtf')
				dirremove($outdir & '\Reconstructed', 1)
			endif

		case $arctype == "hotfix"
			runwait('"' & $file & '" /q /x:"' & $outdir & '"', $outdir)

		case $arctype == "img"
			runwait($cmd & $img & ' -x "' & $file & '"' & $output, $outdir)

		case $arctype == "inno"
			runwait($cmd & $inno & ' -x -m "' & $file & '"' & $output, $outdir)

		case $arctype == "is3arc"
			runwait($cmd & $is3arc & ' "' & $file & '" *.* -d -i' & $output, $outdir)

		case $arctype == "iscab"
			$choice = ISSelect()

			; Extract with i6comp by referencing individual files
			if $choice == "i6comp_files" then
				runwait($cmd & $iscab & ' l -o -r -d "' & $file & '"' & $output, $outdir)
				$infile = fileopen($debugfile, 0)
				$line = filereadline($infile)
				do
					$isfile = stringtrimleft($line, stringinstr($line, ' ', 0, -1))
					runwait($cmd & $iscab & ' x -r -d "' & $file & '" "' & $isfile & '"', $outdir, @SW_HIDE)
					$line = filereadline($infile)
				until @error
				fileclose($infile)

			; Extract with i6comp in default group mode
			elseif $choice == "i6comp_groups" then
				runwait($cmd & $iscab & ' x -r -d "' & $file & '"', $outdir, @SW_HIDE)
			endif

		case $arctype == "isexe"
			; Attempt to extract with isxcomp
			$dirsize = dirgetsize($outdir)
			filemove($file, $outdir)
			run($cmd & $isexe & ' "' & $outdir & '\' & $filename & '.' & $fileext & '"' & $output, $outdir)
			winwait(@comspec)
			winactivate(@comspec)
			send("{ENTER}")
			processwaitclose($isexe)
			filemove($outdir & '\' & $filename & '.' & $fileext, $filedir)

			; If failed, try to extract MSI using cache switch
			if NOT (dirgetsize($outdir) > $dirsize) then
				$cache = msgbox(65, $title, t('IS_CACHE_PROMPT'))
				if $cache <> 1 then
					dirremove($outdir, 0)
					terminate("silent", '', '')
				endif

				; Run installer and wait for temp files to be copied
				opt("WinTitleMatchMode", 4)
				splashtexton($title, t('IS_CACHE_INIT'), 250, 40, -1, $height, 16)
				run('"' & $file & '" /b"' & $outdir & '"', $filedir)
				winwait("classname=MsiDialogCloseClass")

				; Search temp directory for MSI support and copy to outdir
				$msiname = filefindnextfile(filefindfirstfile($outdir & "\*.msi"))
				if NOT @error then
					$tsearch = FileSearch(envget("temp") & "\" & $msiname)
					if NOT @error then
						$isdir = stringleft($tsearch[1], stringinstr($tsearch[1], '\', 0, -1)-1)
						$handle = filefindfirstfile($isdir & "\*")
						$fname = filefindnextfile($handle)
						do
							if $fname <> $msiname then _
								filecopy($isdir & "\" & $fname, $outdir)
							$fname = filefindnextfile($handle)
						until @error
						fileclose($handle)
					endif
				endif

				; Abort installer
				splashoff()
				msgbox(48, $title, t('IS_CACHE_COMPLETE'))
				filewriteline($debugfile, t('CANNOT_LOG', _ArrayCreate($arcdisp)))
			endif

		case $arctype == "iso"
			runwait($cmd & $iso & ' x "' & $file & '"' & $output, $outdir)

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

		case $arctype == "lzh"
			runwait($cmd & $lzh & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "lzo"
			runwait($cmd & $lzo & ' -d -p"' & $outdir & '" "' & $file & '"' & $output, $filedir)

		case $arctype == "mht"
			runwait($mht & ' "' & $file & '" "' & $outdir & '"')

		case $arctype == "msi"
			$choice = MSISelect()

			; Extract using administrative install
			if $choice = "msi_admin" then
				runwait('msiexec.exe /a "' & $file & '" /qb /l ' & $debugfile & ' TARGETDIR="' & $outdir & '"', $filedir)
			
			; Extract with msi2xml
			elseif $choice = $msi_msi2xml then
				runwait($cmd & $msi_msi2xml & ' -b streams -c files "' & $file & '"' & $output, $outdir)
			endif

		case $arctype == "nsis"
			runwait($cmd & $nsis & ' x -y "' & $file & '"' & $output, $outdir)
			
		case $arctype == "rar"
			runwait($cmd & $rar & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "rpm"
			runwait($cmd & $rpm & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "superdat"
			runwait($file & ' /e "' & $outdir & '"', $outdir)
			filedelete($filedir & '\SuperDAT.log')

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
			$choice = WiseSelect()

			; Extract with E_WISE
			if $choice = $wise_ewise then
				runwait($cmd & $wise_ewise & ' "' & $file & '" "' & $outdir & '"' & $output, $filedir)
				if dirgetsize($outdir) <> 0 then
					runwait($cmd & '00000000.BAT', $outdir, @SW_HIDE)
					filedelete($outdir & '\00000000.BAT')
				endif

			; Extract with WUN
			elseif $choice = $wise_wun then
				runwait($cmd & $wise_wun & ' "' & $filename & '" "' & $outdir & '\' & $filename & '"', $filedir)
				filedelete($outdir & '\' & $filename & "\INST0*")
				filedelete($outdir & '\' & $filename & "\WISE0*")
				filemove($outdir & '\' & $filename & '\*', $outdir)
				$dirs = filefindfirstfile($outdir & '\' & $filename & '\*')
				if $dirs <> -1 then
					$dir = filefindnextfile($dirs)
					do
						dirmove($outdir & '\' & $filename & '\' & $dir, $outdir, 1)
						$dir = filefindnextfile($dirs)
					until @error
				endif
				fileclose($dirs)
				dirremove($outdir & '\' & $filename)
				filewriteline($debugfile, $arcdisp & " extractions cannot be logged.")

			; Extract using the /x switch
			elseif $choice = "wise_inst" then
				runwait($file & ' /x ' & $outdir, $filedir)
				filewriteline($debugfile, $arcdisp & " extractions cannot be logged.")

			; Attempt to extract MSI
			elseif $choice = "wise_msi" then

				; Prompt to continue
				$continue = msgbox(65, $title, t('WISE_MSI_PROMPT', _ArrayCreate($name)))
				if $continue <> 1 then
					dirremove($outdir, 0)
					terminate("silent", '', '')
				endif

				; First, check for any files that are already in extraction dir
				$oldfiles = ""
				if fileexists(@commonfilesdir & "\Wise Installation Wizard") then
					$handle = filefindfirstfile(@commonfilesdir & "\Wise Installation Wizard\*")
					if NOT @error then
						while 1
							$fname = filefindnextfile($handle)
							if @error then exitloop
							$oldfiles &= $fname & '|'
						wend
					endif
					fileclose($handle)
				endif

				; Run installer
				opt("WinTitleMatchMode", 3)
				$pid = run($file & ' /?', $filedir)
				while 1
					sleep(1000)
					if winexists("Windows Installer") then
						winsetstate("Windows Installer", '', @SW_HIDE)
						exitloop
					else
						if NOT processexists($pid) then exitloop
					endif
				wend

				; Check for new files
				$newfiles = ""
				if fileexists(@commonfilesdir & "\Wise Installation Wizard") then
					$handle = filefindfirstfile(@commonfilesdir & "\Wise Installation Wizard\*")
					if NOT @error then
						while 1
							$fname = filefindnextfile($handle)
							if @error then exitloop
							if NOT stringinstr($oldfiles, $fname) then $newfiles &= $fname & "|"
						wend
					endif
					fileclose($handle)
				endif

				; Move files to output directory
				if $newfiles <> "" then
					$newfiles = stringsplit($newfiles, '|')
					for $i = 1 to $newfiles[0]-1
						filemove(@commonfilesdir & "\Wise Installation Wizard\" & $newfiles[$i], $outdir)
					next
					dirremove(@commonfilesdir & "\Wise Installation Wizard", 0)
				endif
				winclose("Windows Installer")
				filewriteline($debugfile, t('CANNOT_LOG', _ArrayCreate($arcdisp)))
			endif
			
		case $arctype == "Z"
			runwait($cmd & $Z & ' x "' & $file & '"' & $output, $outdir)
			if stringtrimleft($filename, stringinstr($filename, '.', 0, -1)) = "tar" then
				runwait($cmd & $tar & ' x "' & $outdir & '\' & $filename & '"' & $output, $outdir)
				filedelete($outdir & '\' & $filename)
			endif

		case $arctype == "uha"
			runwait($cmd & $uharc & ' x -t"' & $outdir & '" "' & $file & '"' & $output, $outdir)
			if dirgetsize($outdir) == 0 then
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

		case $arctype == "zip"
			$return = runwait($cmd & $zip & ' -x "' & $file & '"', $outdir)
			if $return <> 0 then
				runwait($cmd & $7z & ' x -aos "' & $file & '"' & $output, $outdir)
			endif
	endselect
	
	; Check for successful output
	splashoff()
	if dirgetsize($outdir) == 0 then
		if $createdir then dirremove($outdir, 0)
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

		; Display file not found error and exit
		case $status == "notfound"
			msgbox(48, $title, t('CANNOT_FIND', _ArrayCreate($fname)))

		; Display error information and exit
		case $status == "unknownexe"
			$prompt = msgbox(49, $title, t('CANNOT_EXTRACT', _ArrayCreate($file, $id)))
			if $prompt == 1 then
				if @OSTYPE = "WIN32_NT" then
					run($cmd & 'start "UniExtract" ' & $peid & ' "' & $file & '"', $filedir, @SW_HIDE)
				elseif @OSTYPE = "WIN32_WINDOWS" then
					run($cmd & 'start ' & $peid & ' "' & $file & '"', $filedir, @SW_HIDE)
				endif
			endif
		case $status == "unknownext"
			msgbox(48, $title, t('UNKNOWN_EXT', _ArrayCreate($file)))
		case $status == "invaliddir"
			msgbox(48, $title, t('INVALID_DIR', _ArrayCreate($fname)))

		; Display failed attempt information and exit
		case $status == "failed"
			; Convert log to DOS format
			$infile = fileopen($debugfile, 0)
			$outfile = fileopen(filegetshortname($debugdir) & 'uniextract_temp.txt', 2)
			$line = filereadline($infile)
			do
				filewriteline($outfile, $line)
				$line = filereadline($infile)
			until @error
			fileclose($outfile)
			fileclose($infile)
			filemove(filegetshortname($debugdir) & 'uniextract_temp.txt', $debugfile, 1)
			$prompt = msgbox(49, $title, t('EXTRACT_FAILED', _ArrayCreate($file, $id, filegetlongname($debugfile))))
			if $prompt == 1 then
				if @OSTYPE = "WIN32_NT" then
					run($cmd & 'start "UniExtract" ' & $debugfile, $debugdir, @SW_HIDE)
				elseif @OSTYPE = "WIN32_WINDOWS" then
					run($cmd & 'start ' & $debugfile, $debugdir, @SW_HIDE)
				endif
			endif

		; Exit successfully
		case $status == "success"
			filedelete($debugfile)

		; Exit silently
		case $status == "silent"

	endselect

	; Cleanup Win9x path due to AutoIt EnvSet() bug
	if @OSType == "WIN32_WINDOWS" AND $oldpath <> '' then
		runwait($cmd & filegetshortname(@scriptdir & '\bin\winset.exe') & ' path=' & $oldpath, @windowsdir, @SW_HIDE)
	endif
	exit
endfunc

; Function to prompt user for choice of InstallShield cab extraction method
func ISSelect()
	; Create GUI
	opt("GUIOnEventMode", 0)
	GUICreate($title, 330, 160)
	$header = GUICtrlCreateLabel(t('IS_HEADER'), 5, 5, 345, 20)
	GUICtrlCreateLabel(t('IS_TEXT_LABEL1', _ArrayCreate($name)), 5, 25, -1, 20)
	GUICtrlCreateLabel(t('IS_TEXT_LABEL2'), 5, 40, -1, 20)
	GUICtrlCreateLabel(t('IS_TEXT_LABEL3'), 5, 55, -1, 20)
	GUICtrlCreateLabel(t('IS_TEXT_LABEL4', _ArrayCreate($name)), 5, 70, -1, 20)
	GUICtrlCreateGroup(t('IS_METHOD_LABEL'), 5, 90, 150, 65)
	$is1 = GUICtrlCreateRadio(t('IS_FILES_RADIO'), 10, 110, 140, 20)
	$is2 = GUICtrlCreateRadio(t('IS_GROUPS_RADIO'), 10, 130, 140, 20)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$ok = GUICtrlCreateButton(t('OK_BUT'), 200, 100, 80, 20)
	$cancel = GUICtrlCreateButton(t('CANCEL_BUT'), 200, 130, 80, 20)

	; Set properties
	GUICtrlSetFont($header, -1, 1200)
	GUICtrlSetState($is1, $GUI_CHECKED)
	GUICtrlSetState($ok, $GUI_DEFBUTTON)

	; Display GUI and wait for action
	GUISetState(@SW_SHOW)
	while 1
		$action = GUIGetMsg()
		select
			; Set extract command
			case $action = $ok
				if GUICtrlRead($is1) = $GUI_CHECKED then
					GUIDelete()
					return "i6comp_files"
				elseif GUICtrlRead($is2) = $GUI_CHECKED then
					GUIDelete()
					return "i6comp_groups"
				;elseif GUICtrlRead($wise3) = $GUI_CHECKED then
				;	GUIDelete()
				;	return "wise_inst"
				endif

			; Exit if Cancel clicked or window closed
			case $action = $GUI_EVENT_CLOSE OR $action = $cancel
				dirremove($outdir, 0)
				terminate("silent", '', '')
		endselect
	wend
endfunc

; Function to prompt user for choice of MSI extraction method
func MSISelect()
	; Create GUI
	opt("GUIOnEventMode", 0)
	GUICreate($title, 330, 180)
	$header = GUICtrlCreateLabel(t('MSI_HEADER'), 5, 5, 345, 20)
	GUICtrlCreateLabel(t('MSI_TEXT_LABEL1', _ArrayCreate($name)), 5, 25, -1, 20)
	GUICtrlCreateLabel(t('MSI_TEXT_LABEL2'), 5, 40, -1, 20)
	GUICtrlCreateLabel(t('MSI_TEXT_LABEL3'), 5, 55, -1, 20)
	GUICtrlCreateLabel(t('MSI_TEXT_LABEL4', _ArrayCreate($name)), 5, 70, -1, 20)
	$note = GUICtrlCreateLabel(t('MSI_NOTE_LABEL'), 5, 85, 32, 20)
	GUICtrlCreateLabel(t('MSI_REQUIRES_LABEL'), 38, 85, 95, 20)
	$url = GUICtrlCreateLabel(t('MSI_URL_LABEL'), 136, 85, 90, 20)
	GUICtrlCreateGroup(t('MSI_METHOD_LABEL'), 5, 110, 150, 65)
	$msi1 = GUICtrlCreateRadio(t('MSI_ADMIN_RADIO'), 10, 130, 140, 20)
	$msi2 = GUICtrlCreateRadio(t('MSI_MSI2XML_RADIO'), 10, 150, 140, 20)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$ok = GUICtrlCreateButton(t('OK_BUT'), 200, 120, 80, 20)
	$cancel = GUICtrlCreateButton(t('CANCEL_BUT'), 200, 150, 80, 20)

	; Set properties
	GUICtrlSetFont($note, 8.7, 800)
	GUICtrlSetFont($url, 8.7, -1, 4)
	GUICtrlSetColor($url, 0x0000ff)
	GUICtrlSetCursor($url, 0)
	GUICtrlSetFont($header, -1, 1200)
	GUICtrlSetState($msi1, $GUI_CHECKED)
	GUICtrlSetState($ok, $GUI_DEFBUTTON)

	; Display GUI and wait for action
	GUISetState(@SW_SHOW)
	while 1
		$action = GUIGetMsg()
		select
			; Set extract command
			case $action = $ok
				if GUICtrlRead($msi1) = $GUI_CHECKED then
					GUIDelete()
					return "msi_admin"
				elseif GUICtrlRead($msi2) = $GUI_CHECKED then
					GUIDelete()
					return $msi_msi2xml
				endif

			case $action = $url
				if @OSTYPE = "WIN32_NT" then
					run($cmd & 'start "UniExtract" ' & $msxml4, '', @SW_HIDE)
				elseif @OSTYPE = "WIN32_WINDOWS" then
					run($cmd & 'start ' & $msxml4, '', @SW_HIDE)
				endif

			; Exit if Cancel clicked or window closed
			case $action = $GUI_EVENT_CLOSE OR $action = $cancel
				dirremove($outdir, 0)
				terminate("silent", '', '')
		endselect
	wend
endfunc

; Function to prompt user for choice of Wise extraction method
func WiseSelect()
	; Create GUI
	opt("GUIOnEventMode", 0)
	GUICreate($title, 330, 200)
	$header = GUICtrlCreateLabel(t('WISE_HEADER'), 5, 5, 345, 20)
	GUICtrlCreateLabel(t('WISE_TEXT_LABEL1', _ArrayCreate($name)), 5, 25, -1, 20)
	GUICtrlCreateLabel(t('WISE_TEXT_LABEL2'), 5, 40, -1, 20)
	GUICtrlCreateLabel(t('WISE_TEXT_LABEL3'), 5, 55, -1, 20)
	GUICtrlCreateLabel(t('WISE_TEXT_LABEL4', _ArrayCreate($name)), 5, 70, -1, 20)
	GUICtrlCreateGroup(t('WISE_METHOD_LABEL'), 5, 90, 150, 105)
	$wise1 = GUICtrlCreateRadio(t('WISE_E_WISE_RADIO'), 10, 110, 140, 20)
	$wise2 = GUICtrlCreateRadio(t('WISE_WUN_RADIO'), 10, 130, 140, 20)
	$wise3 = GUICtrlCreateRadio(t('WISE_SWITCH_RADIO'), 10, 150, 140, 20)
	$wise4 = GUICtrlCreateRadio(t('WISE_MSI_RADIO'), 10, 170, 140, 20)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$ok = GUICtrlCreateButton(t('OK_BUT'), 200, 120, 80, 20)
	$cancel = GUICtrlCreateButton(t('CANCEL_BUT'), 200, 150, 80, 20)

	; Set properties
	GUICtrlSetFont($header, -1, 1200)
	GUICtrlSetState($wise1, $GUI_CHECKED)
	GUICtrlSetState($ok, $GUI_DEFBUTTON)

	; Display GUI and wait for action
	GUISetState(@SW_SHOW)
	while 1
		$action = GUIGetMsg()
		select
			; Set wise extract command
			case $action = $ok
				if GUICtrlRead($wise1) = $GUI_CHECKED then
					GUIDelete()
					return $wise_ewise
				elseif GUICtrlRead($wise2) = $GUI_CHECKED then
					GUIDelete()
					return $wise_wun
				elseif GUICtrlRead($wise3) = $GUI_CHECKED then
					GUIDelete()
					return "wise_inst"
				elseif GUICtrlRead($wise4) = $GUI_CHECKED then
					GUIDelete()
					return "wise_msi"
				endif

			; Exit if Cancel clicked or window closed
			case $action = $GUI_EVENT_CLOSE OR $action = $cancel
				dirremove($outdir, 0)
				terminate("silent", '', '')
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
		$filedir = stringleft($file, stringinstr($file, '\', 0, -1)-1)
		$fileext = stringtrimleft($file, stringinstr($file, '.', 0, -1))
		$filename = stringtrimright(stringtrimleft($file, stringlen($filedir)+1), stringlen($fileext)+1)
		if $history then
			$filelist = '|' & $file & '|' & ReadHist('file')
			GUICtrlSetData($filecont, $filelist, $file)
			$dirlist = '|' & $filedir & '\' & $filename & '|' & ReadHist('directory')
			GUICtrlSetData($dircont, $dirlist, $filedir & '\' & $filename)
		else
			GUICtrlSetData($filecont, $file)
			GUICtrlSetData($dircont, $filedir & '\' & $filename)
		endif
		GUICtrlSetState($dircont, $GUI_FOCUS)
	elseif $history then
		GUICtrlSetData($filecont, ReadHist('file'))
		GUICtrlSetData($dircont, ReadHist('directory'))
	endif
	if $history then
		GUICtrlSetState($historyopt, $GUI_CHECKED)
	endif
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
			$filedir = stringleft($file, stringinstr($file, '\', 0, -1)-1)
			$fileext = stringtrimleft($file, stringinstr($file, '.', 0, -1))
			$filename = stringtrimright(stringtrimleft($file, stringlen($filedir)+1), stringlen($fileext)+1)
			if $history then
				$dirlist = '|' & $filedir & '\' & $filename & '|' & ReadHist('directory')
				GUICtrlSetData($dircont, $dirlist, $filedir & '\' & $filename)
			else
				GUICtrlSetData($dircont, $filedir & '\' & $filename)
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
	if not @error then
		GUICtrlSetData($debugcont, $tempdir)
	endif
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
			$filedir = stringleft($file, stringinstr($file, '\', 0, -1)-1)
			$fileext = stringtrimleft($file, stringinstr($file, '.', 0, -1))
			$filename = stringtrimright(stringtrimleft($file, stringlen($filedir)+1), stringlen($fileext)+1)
			if $history then
				$dirlist = '|' & $filedir & '\' & $filename & '|' & ReadHist('directory')
				GUICtrlSetData($dircont, $dirlist, $filedir & '\' & $filename)
			else
				GUICtrlSetData($dircont, $filedir & '\' & $filename)
			endif
		endif
	endif
endfunc

; Exit if Cancel clicked or window closed
func GUI_Exit()
	terminate("silent", '', '')
endfunc

