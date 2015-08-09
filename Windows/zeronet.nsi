; Zeronet.nsi
;
; This script is based on example1.nsi, but it remember the directory, 
; has uninstall support and (optionally) installs start menu shortcuts.
;
; It will install Zeronet.nsi into a directory that the user selects,

;--------------------------------

; The name of the installer
Name "Zeronet"

; The file to write
OutFile "install-zeronet.exe"

; The default installation directory
InstallDir "C:\Zeronet"

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\Zeronet" "Install_Dir"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

;--------------------------------

; Pages

Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

; The stuff to install
Section "Zeronet"

  SectionIn RO
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File /r "Python"
  File "zeronet.cmd"

  ; $APPDATA

  ; Write the installation path into the registry
  WriteRegStr HKLM "SOFTWARE\Zeronet" "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Zeronet" "DisplayName" "Zeronet"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Zeronet" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Zeronet" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Zeronet" "NoRepair" 1
  WriteUninstaller "uninstall.exe"

  SetOutPath "$INSTDIR"
  ExecShell "open" "$INSTDIR\zeronet.cmd"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts"

  CreateDirectory "$SMPROGRAMS\Zeronet"
  CreateShortCut "$SMPROGRAMS\Zeronet\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\Zeronet\Zeronet.lnk" "$INSTDIR\zeronet.cmd" "" "$INSTDIR\zeronet.cmd" 0
  
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Zeronet"
  DeleteRegKey HKLM "SOFTWARE\Zeronet"


  Delete "$SMPROGRAMS\Zeronet\*.*"

  ; Remove directories used
  RMDir "$SMPROGRAMS\Zeronet"
  RMDir /r "$INSTDIR"

SectionEnd
