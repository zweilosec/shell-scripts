:: Sorry for the janky way of adding the commands to the array!  I am still looking for a better way to do this!
:: Open an issue at https://github.com/zweilosec/shell-scripts/issues if you can help! Thanks!

@echo off
setlocal EnableDelayedExpansion

::	Change Directory to the script's one, since Stupid windows will execute at "\windows\system32" when chosen to run as administrator...
cd /d "%~d0%~p0"

::Get Date and Time
For /F "tokens=1,2,3,4 delims=/ " %%A in ('Date /t') do @( 
Set FullDate="%%D-%%C-%%B"
)

For /F "tokens=1,2,3 delims=: " %%A in ('time /t') do @( 
Set FullTime="%%A-%%B"
)

set dirname="%computername%_%FullDate%_%FullTime%"
mkdir "%dirname%"
cd "%dirname%"
set var=%computername%.txt

rem =============================================================================================
rem Useful commands

rem for collecting file hashes in a whole folder on Windows
::set Arr[0]="for %%F in (*) do @certutil -hashfile "%%F" MD5 | find /v "hashfile command completed successfully""

rem =============================================================================================
Rem Upon Connection:

set Arr[0]=date /t
set Arr[1]=time /t
set Arr[2]=tasklist /V
set Arr[3]=auditpol /get /category:*
set Arr[4]=reg query hklm\software\microsoft\windows\currentversion\run
set Arr[5]=reg query hklm\software\microsoft\windows\currentversion\runonce
set Arr[6]=reg query hklm\software
set Arr[7]=schtasks /query /v /fo:list
set Arr[8]=wmic process get caption,processid,parentprocessid,executablepath
set Arr[9]=dir.exe /o:d /t:w c:\  c:\windows\temp
set Arr[10]=dir.exe /o:d /t:w c:\windows\
set Arr[11]=dir.exe /o:d /t:w c:\windows\system32
set Arr[12]=dir.exe /o:d /t:w c:\windows\system32\winevt\logs
set Arr[13]=dir.exe /o:d /t:w "%appdata%\microsoft\windows\start menu\programs\startup"
set Arr[14]=wevtutil qe security /c:25 /rd:true /f:text

rem =============================================================================================
rem Users Info:

set Arr[15]=whoami /all
set Arr[16]=query user
set Arr[17]=net user
set Arr[18]=wmic useraccount where "LocalAccount='TRUE'" get Caption, Disabled, Domain, Lockout, PasswordExpires, SID, Status
set Arr[19]=net localgroup
set Arr[20]=net session
set Arr[21]=net start
set Arr[22]=type "%systemroot%\system32\drivers\etc\hosts"
set Arr[23]=arp -a ^& route print
set Arr[24]=wmic service list full
set Arr[25]=wmic product get Caption, InstallDate, Vendor

rem =============================================================================================
rem Networking info

set Arr[26]=ipconfig /all
set Arr[27]=netstat /anob
set Arr[28]=netsh advfirewall show allprofiles
set Arr[29]=net share

rem =============================================================================================
rem System and hardware information

set Arr[30]=systeminfo
set Arr[31]=wmic OS get * /format:list
set Arr[32]=wmic os get osarchitecture || echo "%PROCESSOR_ARCHITECTURE%"
set Arr[33]=wmic computersystem LIST full
set Arr[34]=wmic baseboard get Manufacturer, Model, PRoduct, SerialNumber, Version
set Arr[35]=wmic cpu get deviceID, Addresswidth, MaxClockSpeed, Name, Manufacturer
set Arr[36]=wmic logicaldisk get name, freespace, systemname, filesystem, size, volumeserialnumber

set Arr[37]=wmic printer list full
set Arr[38]=wmic printer get Caption, Default, Direct, Description, Local, Shared, Sharename, Status

set Arr[39]=wmic path win32_pnpentity where "ConfigManagerErrorCode^<^>0" get Name, PNPDeviceID
set Arr[40]=driverquery /v
set Arr[41]=pnputil /enum-devices /connected

rem Get installed patches
set Arr[42]=wmic qfe get Caption,Description,HotFixID,InstalledOn
set Arr[43]=wmic qfe list full

rem list all environment variables
set Arr[44]=set
set Arr[45]=wmic environment list /format:list
set Arr[46]=reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"

rem get logonserver domain dns
set Arr[47]=nslookup "%LOGONSERVER%.%USERDNSDOMAIN%"

rem video
set Arr[48]=wmic path Win32_VideoController get caption, CurrentHorizontalResolution, CurrentVerticalResolution, Description, DriverVersion, AdapterRAM /format:list

rem =============================================================================================

rem # Before Disconnect check what has changed:

set Arr[49]=dir.exe /o:d /t:w c:\windows\temp
set Arr[50]=dir.exe /o:d /t:w c:\windows\system32\winevt\logs
set Arr[51]=wevtutil qe security /c:25 /rd:true /f:text
set Arr[52]=netstat /anob
set Arr[53]=query user
set Arr[54]=tasklist

rem =============================================================================================
:: Loop through all commands and write output to file

set "x=0"

:SymLoop
if not defined Arr[%x%] goto :endLoop
call set COMMAND=%%Arr[%x%]%%
::echo %COMMAND%

REM do your stuff VAL
echo. >> %logfile%
echo. >> %logfile%
echo ================================================================================ >> %logfile%
echo ================================================================================ >> %logfile%
echo [+] %COMMAND% >> %logfile%
echo ================================================================================ >> %logfile%
echo ================================================================================ >> %logfile%
:: Must pipe the output of wmix.exe through "more" to fix Unicode to ASCII problems when outputting to file
:: https://superuser.com/questions/812438/combine-batch-wmic-ansi-unicode-output-formatting/812471#812471
cmd /c "%COMMAND%" | more >> %logfile%
cmd /c %COMMAND%

SET /a "x+=1"
GOTO :SymLoop

:endLoop
