@echo off 

set networkname="本地连接"

@rem 这里是实验室的IP地址信息  =====================================
set labIPAddr=192.168.0.89
set labMask=255.255.255.0
set labGateway=192.168.0.1
set labDNS1=114.114.114.114
set labDNS2=114.114.115.115

@rem 这里是宿舍的IP地址信息  =====================================
set dormIPAddr=192.168.0.89
set dormMask=255.255.255.0
set dormGateway=192.168.0.1
set dormDNS1=8.8.8.8
set dormDNS2=8.8.4.4

echo 注意：本脚本需要右键使用管理员权限运行！！！

echo     ==================== IP Switcher =======================

echo       1.设置实验室的IP
echo.
echo       2.设置宿舍的IP
echo.
echo       3.设置成DHCP自动获取
echo.
echo       4.退出 
echo.

set /p choice=                 输入选择的操作[eg:1,2...]：

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
cmd /c netsh interface ip set address %networkname% dhcp
cmd /c netsh interface ip set dns %networkname% dhcp 
echo 完成
pause
exit

@rem =======================================================
:end

netsh interface ipv4 set dnsservers %networkname% static %DNS1% primary no
netsh interface ipv4 add dnsservers %networkname% %DNS2% validate=no
netsh interface ipv4 set address %networkname% static %IP% %Mask% %Gateway%

echo 完成
pause
exit
