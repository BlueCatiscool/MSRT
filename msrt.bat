@echo off
Title Suspicious Malware Removal Tool by BlueCatiscool

mkdir C:\Program Files\SMRT\logs && cls

set LogDirectory="C:\Program Files\SMRT\Logs" && set LogFile=%LogDirectory%\MalwareScanLog.txt

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo %LogFile%
    echo This script requires [36madministrator privileges[0m.
    echo Please right-click on the script and select "Run as administrator".
    pause >nul
    exit /b
)

echo Starting malware scan, please wait.......

"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -SignatureUpdate >> %LogFile%"

echo Malware scan completed.

if exist "%LogFile%" (
    findstr /C:"Threat Detected" "%LogFile%" >nul
    if %errorlevel% equ 0 (
        echo Threats were detected during the scan.
        echo Taking necessary actions to remove the malware...
        "%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Remove -All -Quiet
        echo Malware removal completed.
    ) else (
        echo No threats were detected during this scan.
    )
    del "%LogFile%" /q
) else (
    echo Could not find MalwareScanLog.txt. Please check the scan log for more information.
)

echo Malware removal tool has finished.
echo Press any key to close this program...
pause >nul
