@echo off
cd C:\
color 4
type logo.txt
echo Windows Maintenance Script is Starting...

:: Windows Registry Modifications
echo Making Windows Registry modifications...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpWindowSize" /t REG_DWORD /d 38500 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d 3 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d 64 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUBHDetect" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d 38500 /f

:: DISM Process
echo Performing system repair with DISM...
DISM.exe /Online /Cleanup-image /Restorehealth

:: Clean Temporary Files
echo Cleaning temporary files...
del /s /f /q c:\windows\temp\*.*
rd /s /q c:\windows\temp
md c:\windows\temp
del /s /f /q C:\WINDOWS\Prefetch
del /s /f /q %temp%\*.*
rd /s /q %temp%
md %temp%
deltree /y c:\windows\tempor~1
deltree /y c:\windows\temp
deltree /y c:\windows\tmp
deltree /y c:\windows\ff*.tmp
deltree /y c:\windows\history
deltree /y c:\windows\cookies
deltree /y c:\windows\recent
deltree /y c:\windows\spool\printers
del c:\WIN386.SWP

:: Clean Windows Update and Updates
echo Cleaning Windows Update temporary files...
cls
dism /Online /Cleanup-Image /StartComponentCleanup

:: Clean User Temporary Files
echo Cleaning user temporary files...
del /q /f /s %TEMP%\*
cd C:\Windows
del /q /f /s TEMP\*
cd C:\Users\RK\AppData\Local
del /q /f /s TEMP\*

:: Change Color
color 4

:: Check for Windows Updates
echo Checking for Windows updates...
winget upgrade --all
winget upgrade --all --unknown-sources

:: Flush DNS Cache
color 4
echo Flushing DNS cache...
ipconfig /flushdns

:: Check System Files
color 4
echo Checking system files...
sfc /scannow

@echo off
echo Optimizing Windows 11...

:: Run Windows Update
echo Running Windows Update...  
start /wait ms-settings:windowsupdate

:: Disk Cleanup
echo Starting disk cleanup...
start /wait cleanmgr.exe /sagerun:1

:: Clean System Files
echo Cleaning system files...
start /wait cleanmgr.exe /sagerun:2

:: Disable Fast Startup
echo Disabling Fast Startup...
powercfg /hibernate off

:: Clear Temporary Files
echo Clearing temporary files...
forfiles /p "%temp%" /s /m *.* /c "cmd /c del @path"

:: Check Disk Errors
echo Checking disk errors...
chkdsk /f /r

:: Optimize Performance
echo Optimizing disk performance...
defrag C: /O

:: Manage Firewall
echo Going to Firewall settings...
start /wait ms-settings:windowsdefender

:: Clear Browser Cookies and History
echo Clearing browser cookies and history...
rem Add commands to clear browser cookies and history.

echo Windows 11 Optimization Complete.
pause
