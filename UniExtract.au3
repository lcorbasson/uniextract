; ----------------------------------------------------------------------------
;
; Universal Extractor v1.2.1
; Author:	Jared Breland <jbreland@legroom.net>
; Homepage:	http://www.legroom.net/mysoft
; Language:	AutoIt v3.1.1.119-beta
; License:	GNU General Public License (http://www.gnu.org/copyleft/gpl.html)
;
; Script Function:
;	Extract known archive types
;	If executable, use PEiD.exe to identify type and extract files if possible
;
; ----------------------------------------------------------------------------

; Setup environment
#notrayicon
#include <GUIConstants.au3>
#include <File.au3>
$title = "Universal Extractor 1.2.1"
$peidtitle = "PEiD v0.93"
opt("GUIOnEventMode", 1)
;opt("WinTitleMatchMode", 4)
$7z = "7z.exe"
$ace = "xace.exe"
$arc = "arc.exe"
$arj = "arj.exe"
$bin = "bin2iso.exe"
$bz2 = "7z.exe"
$cab = "7z.exe"
$chm = "7z.exe"
$cpio = "7z.exe"
$deb = "7z.exe"
$expand = "expand.exe"
$gz = "7z.exe"
$hlp = "helpdeco.exe"
$img = "EXTRACT.EXE"
$inno = "innounp.exe"
$iscab = "i6comp.exe"
$isexe = "IsXunpack.exe"
$iso = "7z.exe"
$lzh = "7z.exe"
$lzo = "lzop.exe"
$nsis = "7z.exe"
$peid = "peid.exe"
$rar = "unrar.exe"
$rpm = "7z.exe"
$tar = "7z.exe"
$wise_ewise = "e_wise_w.exe"
$wise_wun = "wun.exe"
$Z = "7z.exe"
$zip = "unzip.exe"
$output = " 2>&1 | tee.exe c:\uniextract.txt"
$height = @desktopheight/3
dim $file, $filetype, $outdir, $prompt
dim $exsig, $loadplugins, $stayontop

; Set working path, include support for .au3 path to ease development
if stringright(@scriptname, 3) = "au3" then
	envset("path", @scriptdir & "\bin" & ';' & envget("path"))
else
	envset("path", @scriptdir & ';' & envget("path"))
endif

; Check parameters
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
	; Create GUI
	GUICreate($title, 300, 115, -1, -1, -1, $WS_EX_ACCEPTFILES)
	$dropzone = GUICtrlCreateLabel("", 0, 0, 300, 115)
	GUICtrlCreateLabel("Archive/Installer to extract:", 5, 5, -1, 15)
	$filecont = GUICtrlCreateCombo("", 5, 20, 260, 20)
	;$filecont = GUICtrlCreateInput("", 5, 20, 260, 20)
	$filebut = GUICtrlCreateButton("...", 270, 20, 25, 20)
	GUICtrlCreateLabel("Target directory:", 5, 45, -1, 15)
	$dircont = GUICtrlCreateCombo("", 5, 60, 260, 20)
	;$dircont = GUICtrlCreateInput("", 5, 60, 260, 20)
	$dirbut = GUICtrlCreateButton("...", 270, 60, 25, 20)
	$ok = GUICtrlCreateButton("&OK", 55, 90, 80, 20)
	$cancel = GUICtrlCreateButton("&Cancel", 165, 90, 80, 20)

	; Set properties
	GUICtrlSetBkColor($dropzone, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlSetState($dropzone, $GUI_DISABLE)
	GUICtrlSetState($dropzone, $GUI_DROPACCEPTED)
	GUICtrlSetState($filecont, $GUI_FOCUS)
	GUICtrlSetState($ok, $GUI_DEFBUTTON)
	if $file <> "" then
		;$file = filegetlongname($file)
		$filelist = '|' & $file & '|' & ReadHist('file')
		GUICtrlSetData($filecont, $filelist, $file)
		;GUICtrlSetData($filecont, $file)
		$filedir = stringleft($file, stringinstr($file, '\', 0, -1)-1)
		$fileext = stringtrimleft($file, stringinstr($file, '.', 0, -1))
		$filename = stringtrimright(stringtrimleft($file, stringlen($filedir)+1), stringlen($fileext)+1)
		$dirlist = '|' & $filedir & '\' & $filename & '|' & ReadHist('directory')
		GUICtrlSetData($dircont, $dirlist, $filedir & '\' & $filename)
		GUICtrlSetState($dircont, $GUI_FOCUS)
	else
		GUICtrlSetData($filecont, ReadHist('file'))
		GUICtrlSetData($dircont, ReadHist('directory'))
	endif

	; Set events
	GUISetOnEvent($GUI_EVENT_DROPPED, "GUI_Drop")
	GUICtrlSetOnEvent($filebut, "GUI_File")
	GUICtrlSetOnEvent($dirbut, "GUI_Directory")
	GUICtrlSetOnEvent($ok, "GUI_Ok")
	GUICtrlSetOnEvent($cancel, "GUI_Exit")
	GUISetOnEvent($GUI_EVENT_CLOSE, "GUI_Exit")

	; Display GUI and wait for action
	GUISetState(@SW_SHOW)
	$finishgui = 0
	while 1
		if $finishgui then exitloop
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

; Update history
WriteHist('file', $file)
WriteHist('directory', $outdir)

; Extract contents from known file extensions
if $fileext = "7z" then
	extract("7z", "7-Zip archive")

elseif $fileext = "ace" then
	extract("ace", "ACE archive")

elseif $fileext = "arc" then
	extract("arc", "ARC archive")

elseif $fileext = "arj" then
	extract("arj", "ARJ archive")

elseif $fileext = "bin" then
	extract("bin", "BIN/CUE CD-ROM image")

elseif $fileext = "bz2" then
	extract("bz2", "bzip2 compressed file")

elseif $fileext = "cab" then
	runwait(@comspec & ' /c ' & $7z & ' l "' & $file & '"' & $output, $filedir, @SW_HIDE)
	if stringinstr(filereadline("c:\uniextract.txt", 4), "Listing archive:", 0) then
		extract("cab", "Microsoft CAB archive")
	else
		extract("iscab", "InstallShield CAB archive")
	endif
	filedelete("c:\uniextract.txt")

elseif $fileext = "chm" then
	extract("chm", "Compiled HTML Help file")

elseif $fileext = "cpio" then
	extract("cpio", "CPIO archive")

elseif $fileext = "cue" then
	extract("bin", "BIN/CUE CD-ROM image")

elseif $fileext = "deb" then
	extract("deb", "Debian package")

elseif stringright($fileext, 1) = "_" AND stringlen($fileext) = 3 then
	extract("expand", "Microsoft Compressed file")

elseif $fileext = "gz" then
	extract("gz", "gzip compressed file")

elseif $fileext = "hlp" then
	extract("hlp", "Windows Help file")

elseif $fileext = "img" then
	extract("img", "Floppy disk image")

elseif $fileext = "iso" then
	extract("iso", "ISO CD-ROM image")

elseif $fileext = "lzh" OR $fileext = "lha" then
	extract("lzh", "LZH compressed file")

elseif $fileext = "lzo" then
	extract("lzo", "LZO compressed file")

elseif $fileext = "msi" then
	extract("msi", "Windows Installer (MSI) package")
	
elseif $fileext = "rar" OR $fileext = "001" then
	extract("rar", "RAR archive")

elseif $fileext = "rpm" then
	extract("rpm", "RPM package")

elseif $fileext = "tar" then
	extract("tar", "Tar archive")

elseif $fileext = "tbz2" OR $fileext = "tgz" OR $fileext = "tz" then
	extract("tar", "Compressed Tar archive")

elseif $fileext = "z" then
	extract("Z", "LZW compressed file")

elseif $fileext = "zip" OR $fileext = "jar" OR $fileext = "xpi" then
	extract("zip", "ZIP archive")

; Determine type of .exe and extract if possible
elseif $fileext = "exe" then

	; Backup existing PEiD options
	splashtexton($title, "Scanning file.", 275, 25, -1, $height, 16)
	$exsig = regread("HKCU\Software\PEiD", "ExSig")
	$loadplugins = regread("HKCU\Software\PEiD", "LoadPlugins")
	$stayontop = regread("HKCU\Software\PEiD", "StayOnTop")

	; Set PEiD options
	regwrite("HKCU\Software\PEiD", "ExSig", "REG_DWORD", 0)
	regwrite("HKCU\Software\PEiD", "LoadPlugins", "REG_DWORD", 0)
	regwrite("HKCU\Software\PEiD", "StayOnTop", "REG_DWORD", 0)

	; Analyze file
	run($peid & ' -hard "' & $file & '"', @scriptdir, @SW_HIDE)
	;winwait("classname=#32770")
	winwait($peidtitle)
	while ($filetype = "") OR ($filetype = "Scanning...")
		sleep (100)
		$filetype = controlgettext($peidtitle, "", "Edit2")
	wend
	;winwait("classname=#32770")
	winclose($peidtitle)
	splashoff()

	; Determine known filetypes
	select
		case stringinstr($filetype, "Nullsoft PiMP SFX", 0)
			extract("nsis", "NSIS package");

		case stringinstr($filetype, "Borland Delphi", 0)
			runwait(@comspec & ' /c ' & $inno & ' "' & $file & '"' & $output, $filedir, @SW_HIDE)
			if stringinstr(filereadline("c:\uniextract.txt", 1), "Version detected:", 0) then
				extract("inno", "Inno Setup package");
			endif
			runwait(@comspec & ' /c ' & $zip & ' -l "' & $file & '"' & $output, $filedir, @SW_HIDE)
			if NOT stringinstr(filereadline("c:\uniextract.txt", 2), "signature not found", 0) then
				extract("zip", "Self-Extracting Zip archive");
			endif
			filedelete("c:\uniextract.txt")

		case stringinstr($filetype, "Inno Setup", 0)
			extract("inno", "Inno Setup package");

		case stringinstr($filetype, "InstallShield 2003", 0)
			extract("isexe", "IstallShield package");

		case stringinstr($filetype, "Microsoft Visual C++", 0) AND NOT stringinstr($filetype, "SPx Method", 0)
			runwait(@comspec & ' /c ' & $7z & ' l "' & $file & '"' & $output, $filedir, @SW_HIDE)
			if stringinstr(filereadline("c:\uniextract.txt", 4), "Listing archive:", 0) then
				extract("7z", "7-Zip Installer package");
			endif
			filedelete("c:\uniextract.txt")

		case stringinstr($filetype, "PEtite", 0)
			runwait(@comspec & ' /c ' & $arj & ' l "' & $file & '"' & $output, $filedir, @SW_HIDE)
			if stringinstr(filereadline("c:\uniextract.txt", 5), "Archive created:", 0) then
				extract("arj", "Self-Extracting ARJ archive");
			endif
			; Might be an Ace file, but no way to test
			extract("ace", "Self-Extracting ACE archive");
			filedelete("c:\uniextract.txt")

		case stringinstr($filetype, "RAR SFX", 0) 
			extract("rar", "Self-Extracting RAR archive");

		case stringinstr($filetype, "SPx Method", 0) 
			extract("cab", "Self-Extracting Microsoft CAB archive");

		case stringinstr($filetype, "CAB SFX", 0) 
			extract("cab2", "Self-Extracting Microsoft CAB archive");

		case stringinstr($filetype, "Wise Installer", 0) OR stringinstr($filetype, "PEncrypt 4.0", 0)
			extract("wise", "Wise Installer package");

		case stringinstr($filetype, "ZIP SFX", 0)
			extract("zip", "Self-Extracting ZIP archive");

		; Default case for non-PE executables - try 7zip and unzip
		case stringinstr($filetype, "Not a valid PE file")
			runwait(@comspec & ' /c ' & $7z & ' l "' & $file & '"' & $output, $filedir, @SW_HIDE)
			if stringinstr(filereadline("c:\uniextract.txt", 4), "Listing archive:", 0) then
				extract("7z", "Unknown 7-Zip archive");
			endif
			runwait(@comspec & ' /c ' & $zip & ' -l "' & $file & '"' & $output, $filedir, @SW_HIDE)
			if stringinstr(filereadline("c:\uniextract.txt", 2), "Length", 0) then
				extract("zip", "Unknown Zip archive");
			endif
			filedelete("c:\uniextract.txt")

		; Default case for all other executables - try 7zip and unzip
		case else
			runwait(@comspec & ' /c ' & $7z & ' l "' & $file & '"' & $output, $filedir, @SW_HIDE)
			if stringinstr(filereadline("c:\uniextract.txt", 4), "Listing archive:", 0) then
				extract("7z", "Unknown 7-Zip archive");
			endif
			runwait(@comspec & ' /c ' & $zip & ' -l "' & $file & '"' & $output, $filedir, @SW_HIDE)
			if stringinstr(filereadline("c:\uniextract.txt", 2), "Length", 0) then
				extract("zip", "Unknown Zip archive");
			endif
			filedelete("c:\uniextract.txt")
	endselect

	; Exit with unknown file type
	terminate("unknownexe", $file, $filetype)

; Unknown extension
else
	terminate("unknownext", $file, "")
endif

exit

; -------------------------- Begin Custom Functions ---------------------------

; Read history
func ReadHist($field)
	if $field = 'file' then
		$reg = "HKCU\Software\UniExtract\History\File"
	elseif $field = 'directory' then
		$reg = "HKCU\Software\UniExtract\History\Directory"
	else
		return;
	endif
	local $history
	for $i = 0 to 9
		$value = regread($reg, $i)
		if $value <> "" then $history = $history & '|' & $value
	next
	$history = stringtrimleft($history, 1)
	return $history
endfunc

; Write history
func WriteHist($field, $new)
	if $field = 'file' then
		$reg = "HKCU\Software\UniExtract\History\File"
	elseif $field = 'directory' then
		$reg = "HKCU\Software\UniExtract\History\Directory"
	else
		return;
	endif
	$histarr = stringsplit(ReadHist($field), '|')
	regwrite($reg, "0", "REG_SZ", $new)
	if $histarr[1] == "" then return
	for $i = 1 to $histarr[0]
		if $i > 9 then exitloop
		if $histarr[$i] = $new then
			regdelete($reg, string($i))
			continueloop
		endif
		regwrite($reg, string($i), "REG_SZ", $histarr[$i])
	next
endfunc

; Extract from known archive format
func extract($arctype, $arcdisp)
	; Display banner and create subdirectory
	dim $createdir
	splashtexton($title, "Extracting files from:" & @CRLF & $arcdisp, 275, 45, -1, $height, 16)
	if not fileexists($outdir) then
		$validdir = dircreate($outdir)
		if not $validdir then terminate("invaliddir", $outdir, "")
		$createdir = 1
	endif

	; Extract archive based on filetype
	select
		case $arctype == "7z"
			runwait(@comspec & ' /c ' & $7z & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "ace"
			runwait(@comspec & ' /c ' & $ace & ' -x "' & $file & '" "' & $outdir & '"' & $output, $filedir)

		case $arctype == "arc"
			runwait(@comspec & ' /c ' & $arc & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "arj"
			runwait(@comspec & ' /c ' & $arj & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "bin"
			$convert =  msgbox(65, $title, "BIN/CUE CD-ROM images cannot be extracted directly.  Instead, this image" & @CRLF & "will be converted to an ISO CD-ROM image, which will then be extracted." & @CRLF & @CRLF & "Would you like to continue?" & @CRLF & "Note: This process will take several minutes.")
			if $convert <> 1 then
				dirremove($outdir, 0)
				exit
			endif
			if NOT fileexists($filedir & '\' & $filename & ".bin") then
				msgbox(48, $title, "Error: Could not find:" & @CRLF & $filedir & '\' & $filename & ".bin" & @CRLF & @CRLF & "Both " & $filename & ".bin and " & $filename & ".cue are needed.")
				dirremove($outdir, 0)
				exit
			endif
			if NOT fileexists($filedir & '\' & $filename & ".cue") then
				msgbox(48, $title, "Error:  Could not find:" & @CRLF & $filedir & '\' & $filename & ".cue" & @CRLF & @CRLF & "Both " & $filename & ".bin and " & $filename & ".cue are needed.")
				dirremove($outdir, 0)
				exit
			endif
			controlsettext($title, '', 'Static1', "Extracting files from:" & @CRLF & "BIN/CUE CD-ROM image (Stage 1)")
			runwait(@comspec & ' /c ' & $bin & ' "' & $filedir & '\' & $filename & '.cue"' & $output, $filedir)
			msgbox(0, 'Test', 'test')
			$isofile = filefindfirstfile($filedir & '\' & $filename & '-*.iso')
			if $isofile == -1 then
				msgbox(64, $title, "Error:  The BIN/CUE image could not be converted." & @CRLF & "Please ensure that the CUE file is properly formatted.")
				dirremove($outdir, 0)
				terminate("failed", $file, $arcdisp)
			else
				$isofilename = filefindnextfile($isofile)
				controlsettext($title, '', 'Static1', "Extracting files from:" & @CRLF & "BIN/CUE CD-ROM image (Stage 2)")
				runwait(@comspec & ' /c ' & $iso & ' x "' & $filedir & '\' & $isofilename & '"' & $output, $outdir)
				if dirgetsize($outdir) == 0 then
					$image = msgbox(51, $title, "Error:  An ISO image was created from tbe BIN/CUE image, but it could not be converted." & @CRLF & "Would you like to keep the ISO image for further analysis?")
					if $image == 7 then filedelete($filedir & '\' & $isofilename)
					dirremove($outdir, 0)
					exit
				else
					filedelete($filedir & '\' & $isofilename)
				endif
			endif

		case $arctype == "bz2"
			runwait(@comspec & ' /c ' & $bz2 & ' x "' & $file & '"' & $output, $outdir)
			if stringtrimleft($filename, stringinstr($filename, '.', 0, -1)) = "tar" then
				runwait(@comspec & ' /c ' & $tar & ' x "' & $outdir & '\' & $filename  & '"' & $output, $outdir)
				filedelete($outdir & '\' & $filename)
			endif

		case $arctype == "cab"
			runwait(@comspec & ' /c ' & $cab & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "cab2"
			runwait('"' & $file & '" /q /x:"' & $outdir & '"', $outdir)

		case $arctype == "chm"
			runwait(@comspec & ' /c ' & $chm & ' x "' & $file & '"' & $output, $outdir)
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
			runwait(@comspec & ' /c ' & $cpio & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "deb"
			runwait(@comspec & ' /c ' & $deb & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "expand"
			runwait(@comspec & ' /c ' & $expand & ' -r "' & $file & '" "' & $outdir & '"' & $output, $outdir)

		case $arctype == "gz"
			runwait(@comspec & ' /c ' & $gz & ' x "' & $file & '"' & $output, $outdir)
			if stringtrimleft($filename, stringinstr($filename, '.', 0, -1)) = "tar" then
				runwait(@comspec & ' /c ' & $tar & ' x "' & $outdir & '\' & $filename  & '"' & $output, $outdir)
				filedelete($outdir & '\' & $filename)
			endif
			
		case $arctype == "hlp"
			runwait(@comspec & ' /c ' & $hlp & ' "' & $file & '"' & $output, $outdir)
			if dirgetsize($outdir) <> 0 then
				dircreate($outdir & '\Reconstructed')
				runwait(@comspec & ' /c ' & $hlp & ' /r /n "' & $file & '"' & $output, $outdir & '\Reconstructed')
				filemove($outdir & '\Reconstructed\' & $filename & '.rtf', $outdir & '\' & $filename & '_Reconstructed.rtf')
				dirremove($outdir & '\Reconstructed', 1)
			endif

		case $arctype == "img"
			runwait(@comspec & ' /c ' & $img & ' -x "' & $file & '"' & $output, $outdir)

		case $arctype == "inno"
			runwait(@comspec & ' /c ' & $inno & ' -x "' & $file & '"' & $output, $outdir)

		case $arctype == "iscab"
			runwait(@comspec & ' /c ' & $iscab & ' l -o "' & $file & '"' & $output, $outdir)
			$infile = fileopen("c:\uniextract.txt", 0)
			$line = filereadline($infile)
			do
				$isfile = stringtrimleft($line, stringinstr($line, ' ', 0, -1))
				runwait(@comspec & ' /c ' & $iscab & ' e "' & $file & '" "' & $isfile & '"', $outdir, @SW_HIDE)
				$line = filereadline($infile)
			until @error
			fileclose($infile)

		case $arctype == "isexe"
			filemove($file, $outdir)
			run(@comspec & ' /c ' & $isexe & ' "' & $outdir & '\' & $filename & '.' & $fileext & '"' & $output, $outdir)
			winwait(@comspec)
			winactivate(@comspec)
			send("{ENTER}")
			processwaitclose($isexe)
			filemove($outdir & '\' & $filename & '.' & $fileext, $filedir)
			if dirgetsize($outdir) == 0 then
				$cache = msgbox(49, $title, "Initial extraction failed.  However, it may be possible to extract files" & @CRLF & "from this archive by instructing the installer to run in cache mode." & @CRLF & @CRLF & "Do you wish to try this method?")
				if $cache <> 1 then
					dirremove($outdir, 0)
					exit
				endif
				$cache = msgbox(65, $title, "When you click OK, the installer will be launched in cache mode." & @CRLF & "Please wait until it completely finishes initialization, then cancel the installer." & @CRLF & @CRLF & "Note:  It may take a few seconds for " & $title & " to complete extraction.")
				if $cache <> 1 then
					dirremove($outdir, 0)
					exit
				endif
				runwait('"' & $file & '" /b"' & $outdir & '"', $filedir)
				filewriteline("c:\uniextract.txt", $arcdisp & " extractions cannot be logged.")
			endif

		case $arctype == "iso"
			runwait(@comspec & ' /c ' & $iso & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "lzh"
			runwait(@comspec & ' /c ' & $lzh & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "lzo"
			runwait(@comspec & ' /c ' & $lzo & ' -d -p"' & $outdir & '" "' & $file & '"' & $output, $filedir)

		case $arctype == "msi"
			runwait('msiexec.exe /a "' & $file & '" /qb /log c:\uniextract.txt TARGETDIR="' & $outdir & '"', $filedir)

		case $arctype == "nsis"
			runwait(@comspec & ' /c ' & $nsis & ' x -y "' & $file & '"' & $output, $outdir)
			
		case $arctype == "rar"
			runwait(@comspec & ' /c ' & $rar & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "rpm"
			runwait(@comspec & ' /c ' & $rpm & ' x "' & $file & '"' & $output, $outdir)

		case $arctype == "tar"
			if $fileext = "tar" then
				runwait(@comspec & ' /c ' & $tar & ' x "' & $file & '"' & $output, $outdir)
			else
				runwait(@comspec & ' /c ' & $7z & ' x "' & $file & '"' & $output, $outdir)
				runwait(@comspec & ' /c ' & $tar & ' x "' & $outdir & '\' & $filename  & '.tar"' & $output, $outdir)
				filedelete($outdir & '\' & $filename & '.tar')
			endif

		case $arctype == "wise"
			$choice = WiseSelect()

			; Extract with E_WISE
			if $choice = $wise_ewise then
				runwait(@comspec & ' /c ' & $wise_ewise & ' "' & $file & '" "' & $outdir & '"' & $output, $filedir)
				if dirgetsize($outdir) <> 0 then
					runwait(@comspec & ' /c 00000000.BAT', $outdir, @SW_HIDE)
					filedelete($outdir & '\00000000.BAT')
				endif

			; Extract with WUN
			elseif $choice = $wise_wun then
				runwait(@comspec & ' /c ' & $wise_wun & ' "' & $filename & '" "' & $outdir & '\' & $filename & '"', $filedir)
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
				filewriteline("c:\uniextract.txt", $arcdisp & " extractions cannot be logged.")

			; Extract using the /x switch
			else
				runwait($file & ' /x ' & $outdir, $filedir)
				filewriteline("c:\uniextract.txt", $arcdisp & " extractions cannot be logged.")
			endif
			
		case $arctype == "Z"
			runwait(@comspec & ' /c ' & $Z & ' x "' & $file & '"' & $output, $outdir)
			if stringtrimleft($filename, stringinstr($filename, '.', 0, -1)) = "tar" then
				runwait(@comspec & ' /c ' & $tar & ' x "' & $outdir & '\' & $filename & '"' & $output, $outdir)
				filedelete($outdir & '\' & $filename)
			endif
			
		case $arctype == "zip"
			runwait(@comspec & ' /c ' & $zip & ' -x "' & $file & '"' & $output, $outdir)
	endselect
	
	; Check for successful output
	splashoff()
	if dirgetsize($outdir) == 0 then
		if $createdir then dirremove($outdir, 0)
		terminate("failed", $file, $arcdisp)
	endif
	terminate("success", "", "")
endfunc

; Handle program termination with appropriate error message
func terminate($status, $name, $id)
	; Display error message if file could not be extracted
	select
		; Display usage information and exit
		case $status == "syntax"
			$syntax = "Extract files from any archive type or installer package."
			$syntax = $syntax & @CRLF & "Usage:  " & @scriptname & " [/help] [filename [destination]]"
			$syntax = $syntax & @CRLF & @CRLF & "Supported Arguments:"
			$syntax = $syntax & @CRLF & "     /help" & @tab & @tab & "Display this help information"
			$syntax = $syntax & @CRLF & "     filename" & @tab & "Name of file to extract"
			$syntax = $syntax & @CRLF & "     destination" & @tab & "Directory to which to extract"
			$syntax = $syntax & @CRLF & @CRLF & "Passing /sub instead of a destination directory name instructs" & @CRLF & $title & " to extract to subdirectory named after the archive."
			$syntax = $syntax & @CRLF & @CRLF & "Example:"
			$syntax = $syntax & @CRLF & "     " & @scriptname & " c:\1\example.zip c:\test"
			$syntax = $syntax & @CRLF & @CRLF & "Running " & $title & " without any arguments will" & @CRLF & "prompt the user for the filename and destination directory."
			msgbox(48, $title, $syntax)

		; Display file not found error and exit
		case $status == "notfound"
			msgbox(48, $title, $name & " could not be found.")

		; Display error information and exit
		case $status == "unknownexe"
			msgbox(48, $title, $file & " cannot be extracted." & @CRLF & "Filetype returned was: " & $id)
		case $status == "unknownext"
			msgbox(48, $title, $file & @CRLF & "has an unknown extension and cannot be extracted.")
		case $status == "invaliddir"
			msgbox(48, $title, $name & @CRLF & "could not be created.  Please select a valid destination.")

		; Display failed attempt information and exit
		case $status == "failed"
			; Convert log to DOS format
			$infile = fileopen("c:\uniextract.txt", 0)
			$outfile = fileopen("c:\uniextract_temp.txt", 2)
			$line = filereadline($infile)
			do
				filewriteline($outfile, $line)
				$line = filereadline($infile)
			until @error
			fileclose($outfile)
			fileclose($infile)
			filemove("c:\uniextract_temp.txt", "c:\uniextract.txt", 1)
			msgbox(48, $title, $file & " could not be extracted." & @CRLF & "It appears to be a " & $id & ", which is supported, but extraction failed." & @CRLF & @CRLF & "Please see the log file, c:\uniextract.txt, for more information.")

		; Exit successfully
		case $status == "success"
			filedelete("c:\uniextract.txt")
	endselect
	
	; Restore previous PEiD options
	if $exsig then regwrite("HKCU\Software\PEiD", "ExSig", "REG_DWORD", $exsig)
	if $loadplugins then regwrite("HKCU\Software\PEiD", "LoadPlugins", "REG_DWORD", $loadplugins)
	if $stayontop then regwrite("HKCU\Software\PEiD", "StayOnTop", "REG_DWORD", $stayontop)
	exit
endfunc

; Function to prompt user for choice of Wise extraction method
func WiseSelect()
	; Create GUI
	opt("GUIOnEventMode", 0)
	GUICreate($title, 330, 180)
	$header = GUICtrlCreateLabel("Wise Installer Extraction", 5, 5, 345, 20)
	GUICtrlCreateLabel($title & " supports the following methods for extracting Wise", 5, 25, -1, 20)
	GUICtrlCreateLabel("Installer packages.  Unfortunately, none of these methods are 100%", 5, 40, -1, 20)
	GUICtrlCreateLabel("reliable.  If the default method does not seem to work, please rerun", 5, 55, -1, 20)
	GUICtrlCreateLabel($title & " and select an alternative method.", 5, 70, -1, 20)
	GUICtrlCreateGroup("Extract Method", 5, 90, 150, 85)
	$wise1 = GUICtrlCreateRadio("E_WISE Unpacker", 10, 110, 140, 20)
	$wise2 = GUICtrlCreateRadio("WUN Unpacker", 10, 130, 140, 20)
	$wise3 = GUICtrlCreateRadio("Wise Installer /x switch", 10, 150, 140, 20)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$ok = GUICtrlCreateButton("&OK", 200, 110, 80, 20)
	$cancel = GUICtrlCreateButton("&Cancel", 200, 140, 80, 20)

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
				endif

			; Exit if Cancel clicked or window closed
			case $action = $GUI_EVENT_CLOSE OR $action = $cancel
				dirremove($outdir, 0)
				exit
		endselect
	wend
endfunc

; ------------------------ Begin GUI Control Functions ------------------------

; Prompt user for file
func GUI_File()
	$file = fileopendialog("Open file", "", "Select file (*.*)", 1)
	if not @error then
		$filelist = '|' & $file & '|' & ReadHist('file')
		GUICtrlSetData($filecont, $filelist, $file)
		if GUICtrlRead($dircont) = "" then
			$filedir = stringleft($file, stringinstr($file, '\', 0, -1)-1)
			$fileext = stringtrimleft($file, stringinstr($file, '.', 0, -1))
			$filename = stringtrimright(stringtrimleft($file, stringlen($filedir)+1), stringlen($fileext)+1)
			$dirlist = '|' & $filedir & '\' & $filename & '|' & ReadHist('directory')
			GUICtrlSetData($dircont, $dirlist, $filedir & '\' & $filename)
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
		$defdir = '';
	endif
	$outdir = fileselectfolder("Extract to", "", 3, $defdir)
	if not @error then
		$dirlist = '|' & $outdir & '|' & ReadHist('directory')
		GUICtrlSetData($dircont, $dirlist, $outdir)
	endif
endfunc

; Set file to extract and target directory, then exit
func GUI_Ok()
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
			$file = '';
		else
			$file = $file & " does not exist." & @CRLF;
		endif
		msgbox(48, $title, $file & "Please select valid file.")
	endif
endfunc

; Process dropped files outside of file input box
func GUI_Drop()
	if fileexists(@GUI_DragFile) then
		$file = @GUI_DragFile
		$filelist = '|' & $file & '|' & ReadHist('file')
		GUICtrlSetData($filecont, $filelist, $file)
		if GUICtrlRead($dircont) = "" then
			$filedir = stringleft($file, stringinstr($file, '\', 0, -1)-1)
			$fileext = stringtrimleft($file, stringinstr($file, '.', 0, -1))
			$filename = stringtrimright(stringtrimleft($file, stringlen($filedir)+1), stringlen($fileext)+1)
			$dirlist = '|' & $filedir & '\' & $filename & '|' & ReadHist('directory')
			GUICtrlSetData($dircont, $dirlist, $filedir & '\' & $filename)
		endif
	endif
endfunc

; Exit if Cancel clicked or window closed
func GUI_Exit()
	exit
endfunc

