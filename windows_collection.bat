
rem =============================================================================================
rem Useful commands

rem for collecting file hashes in a whole folder on Windows
for %F in (*) do @certutil -hashfile "%F" MD5 | find /v "hashfile command completed successfully"

rem =============================================================================================
Rem Upon Connection:

date /t & time /t
tasklist /V
auditpol /get /category:*

reg query hklm\software\microsoft\windows\currentversion\run
reg query hklm\software\microsoft\windows\currentversion\runonce
reg query hklm\software
schtasks /query /v /fo:list
wmic process  get caption,processid,parentprocessid,executablepath
dir.exe /o:d /t:w c:\  c:\windows\temp
dir.exe /o:d /t:w c:\windows\
dir.exe /o:d /t:w c:\windows\system32
dir.exe /o:d /t:w c:\windows\system32\winevt\logs
dir.exe /o:d /t:w "%appdata%\microsoft\windows\start menu\programs\startup"
wevtutil qe security /c:25 /rd:true /f:text

rem =============================================================================================
rem Users Info:

systeminfo
query user
net user
wmic useraccount where "LocalAccount='TRUE'" get Caption, Disabled, Domain, Lockout, PasswordExpires, SID, Status
net localgroup
net session
net start
type %systemroot%\system32\drivers\etc\hosts
arp -a & route print
wmic service list full
wmic product get Caption, InstallDate, Vendor

rem =============================================================================================
rem Networking info

ipconfig /all
netstat /anob
netsh advfirewall show allprofiles
net share

rem =============================================================================================
rem System and hardware information

systeminfo
wmic OS get * /format:list
wmic os get osarchitecture || echo %PROCESSOR_ARCHITECTURE% # Get system cpu architecture
wmic computersystem LIST full # Get OS information
wmic baseboard get Manufacturer, Model, PRoduct, SerialNumber, Version
wmic cpu get deviceID, Addresswidth, MaxClockSpeed, Name, Manufacturer
wmic logicaldisk get name, freespace, systemname, filesystem, size, volumeserialnumber

wmic printer list full
wmic printer get Caption, Default, Direct, Description, Local, Shared, Sharename, Status

wmic path win32_pnpentity where "ConfigManagerErrorCode<>0" get Name, PNPDeviceID
driverquery /v
pnputil /enum-devices /connected

wmic qfe get Caption,Description,HotFixID,InstalledOn # Get installed patches
wmic qfe list full

# list all environment variables
set
wmic environment list /format:list
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"

nslookup %LOGONSERVER%.%USERDNSDOMAIN%  # get logonserver domain dns

#video
wmic path Win32_VideoController get  caption, CurrentHorizontalResolution, CurrentVerticalResolution, Description, DriverVersion, AdapterRAM /format:list

rem =============================================================================================

rem # Before Disconnect check what has changed:

dir.exe /o:d /t:w c:\windows\temp
dir.exe /o:d /t:w c:\windows\system32\winevt\logs
wevtutil qe security /c:25 /rd:true /f:text
netstat /anob
query user
tasklist

exit
