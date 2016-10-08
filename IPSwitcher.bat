@echo off 

set networkname="Ethernet"

@rem This is one place  =====================================
set labIPAddr=192.168.0.89
set labMask=255.255.255.0
set labGateway=192.168.0.1
set labDNS1=114.114.114.114
set labDNS2=114.114.115.115

@rem this is another place  =====================================
set dormIPAddr=192.168.0.89
set dormMask=255.255.255.0
set dormGateway=192.168.0.1
set dormDNS1=8.8.8.8
set dormDNS2=8.8.4.4

echo Need run as Administrator !!!

echo     ==================== IP Switcher =======================

echo       1.set ip for place1
echo.
echo       2.set ip for place2
echo.
echo       3.set ip by dhcp
echo.
echo       4.quit 
echo.

set /p choice=                 input your choice：

if "%choice%"=="1"  goto lab
if "%choice%"=="2"  goto dorm
if "%choice%"=="3"  goto dhcp
if "%choice%"=="4"  goto exit
if "%choice%"=="q"  goto exit
if "%choice%"=="Q"  goto exit

goto main

@rem ======================================================
:lab

set IP=%labIPAddr%
set Gateway=%labGateway%
set Mask=%labMask%
set DNS1=%labDNS1%
set DNS2=%labDNS2%
goto end

@rem =======================================================
:dorm

set IP=%dormIPAddr%
set Gateway=%dormGateway%
set Mask=%dormMask%
set DNS1=%dormDNS1%
set DNS2=%dormDNS2%
goto end

@rem =======================================================
:dhcp

netsh interface ip set address %networkname% dhcp
netsh interface ip set dns %networkname% dhcp 
ipconfig /flushdns 
echo Finish
pause
exit

@rem =======================================================
:end

netsh interface ipv4 set dnsservers %networkname% static %DNS1% primary no
netsh interface ipv4 add dnsservers %networkname% %DNS2% no
netsh interface ipv4 set address %networkname% static %IP% %Mask% %Gateway%
ipconfig /flushdns 
echo Finish
pause
exit
