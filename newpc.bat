@echo off
:init
@setlocal enableextensions
set config_dir=%~dp0
chcp 65001 >>nul

if not defined bin_dir set bin_dir=%~dp0bin\
set output=con
rem need to fix user pref


:internal
if exist "%CONFIG_DIR%\setup.cfg" (
for /f "delims=" %%a in ('type "%CONFIG_DIR%\setup.cfg"^|findstr /b "internal.force_echo"') do set %%a
for /f "delims=" %%a in ('type "%CONFIG_DIR%\setup.cfg"^|findstr /b "internal.test.err.enable"') do set %%a
for /f "delims=" %%a in ('type "%CONFIG_DIR%\setup.cfg"^|findstr /b "internal.test.err"') do set %%a
for /f "delims=" %%a in ('type "%CONFIG_DIR%\setup.cfg"^|findstr /b "internal.force_pause"') do set %%a
)



set dbls_ver=2.0.114.00000
set brand_ver=0.2.0.2
set dbls_stat=alpha

set dbls_brand=Setup
   set dbls_title=Andre's New Device Configurator
set dbls_underline================================
set dbls_subtext=Configuring your device...
set dbls_act_text=Please wait while Setup installs and configures your copy of %dbls_brand%...
set dbls_notice_text=Your system administrator has made an automated installer, if something goes wrong, please contact your system adminstrator.
set dbls_copyrt_text=(C) Copyright 2018 - 2023 Duplex Software Corp.
set dbls_ver_show=1
set dflt_logdir=%config_dir%\Logs


set ApplicationName=%dbls_brand%
set CompanyName=Duplex Software

@cd /d "%~dp0"

set dir_brand=%companyname%\%applicationname%
rem echo %config_dir%
if exist "%systemroot%\SysWOW64" (
	set os_x64=1
) else (
	set os_x64=0
)
set err_num=0
set output=con
rem set output_deb=nul
set con_dirty=0
set setup_state=0
set ins_att=0
if %dbls_ver_show%==1 (set dbls_contitle=%dbls_title% v%brand_ver%) else (set dbls_contitle=%dbls_title%)
rem The line of code below is used to turn on echo, only if it is a in development/alpha build.
if "%internal.force_echo%"=="1" (if %dbls_stat%==dev (@echo on ) else (goto :placeholder))
:placeholder
rem These are features of the Baseboard CSU launcher, that are currently unimplemented in DBLS...




rem Other unimplemented features

:runmode
if "%*" =="" (
	set mode=0
	rem This is the default mode, the script is running without parameters
) else (
	set mode=1
	rem The script is running with parameters
)



rem	set dbls_ver_dgts=2

:names
set esse_name=Andre's Essentials
set meapps_name=Personal apps (messaging and statistical apps)
set av_name=Audio/DVD related apps
set vm_name=Virtualization software
set diskmulti_name=Multi-boot and disk backup software
set devapps_name=Developer tools (Visual Studio Code)

:set_perf
rem Use an alternate working directory
if exist "%CONFIG_DIR%\setup.cfg" (
for /f "delims=" %%a in ('type "%CONFIG_DIR%\setup.cfg"^|findstr /b "skip_betamsg"') do set %%a
for /f "delims=" %%a in ('type "%CONFIG_DIR%\setup.cfg"^|findstr /b "bin_path"') do set %%a
for /f "delims=" %%a in ('type "%CONFIG_DIR%\setup.cfg"^|findstr /b "install_feat_esse"') do set %%a
for /f "delims=" %%a in ('type "%CONFIG_DIR%\setup.cfg"^|findstr /b "install_feat_av"') do set %%a
for /f "delims=" %%a in ('type "%CONFIG_DIR%\setup.cfg"^|findstr /b "install_feat_meapps"') do set %%a
for /f "delims=" %%a in ('type "%CONFIG_DIR%\setup.cfg"^|findstr /b "install_feat_vm"') do set %%a
for /f "delims=" %%a in ('type "%CONFIG_DIR%\setup.cfg"^|findstr /b "install_feat_diskmulti"') do set %%a
for /f "delims=" %%a in ('type "%CONFIG_DIR%\setup.cfg"^|findstr /b "skip_wgupg"') do set %%a
for /f "delims=" %%a in ('type "%CONFIG_DIR%\setup.cfg"^|findstr /b "skip_nofastboot"') do set %%a
for /f "delims=" %%a in ('type "%CONFIG_DIR%\setup.cfg"^|findstr /b "skip_win10dvd"') do set %%a
for /f "delims=" %%a in ('type "%CONFIG_DIR%\setup.cfg"^|findstr /b "log"') do set %%a
for /f "delims=" %%a in ('type "%CONFIG_DIR%\setup.cfg"^|findstr /b "log_dir"') do set %%a
)
	if not defined log_dir (set log_dir=%dflt_logdir%)


:bypass
rem Setup parameters

if "%*"=="-?" goto :help
if defined "%*" (
if /i "%~1"=="-help" goto :help



rem Help_inst_chk
if "%~2"=="-?" set help_inst=2
if "%~3"=="-?" set help_inst=3
if "%~4"=="-?" set help_inst=4
if "%~5"=="-?" set help_inst=5
if "%~6"=="-?" set help_inst=6
if "%~7"=="-?" set help_inst=7
if "%~8"=="-?" set help_inst=8
if "%~9"=="-?" set help_inst=9


if /i "%~1"=="-log" (
	if "%help_inst%"=="2" goto :help_log_cmd
	if "%help_inst%"=="3" goto :help_log_cmd
	if "%~2"=="" goto :help_log_cmd
	if /i "%~2"=="none" ( set log=0 ) else (set log_dir="%~2")
)
if /i "%~2"=="-log" (
	if "%help_inst%"=="3" goto :help_log_cmd
	if "%help_inst%"=="4" goto :help_log_cmd
	if "%~3"=="" goto :help_log_cmd
	if /i "%~3"=="none" ( set log=0 ) else (set log_dir=%~3)
)
if /i "%~3"=="-log" (
	if "%help_inst%"=="4" goto :help_log_cmd
	if "%help_inst%"=="5" goto :help_log_cmd
	if "%~4"=="" goto :help_log_cmd
	if /i "%~4"=="none" ( set log=0 ) else (set log_dir=%~4)
)
if /i "%~4"=="-log" (
	if "%help_inst%"=="5" goto :help_log_cmd
	if "%help_inst%"=="6" goto :help_log_cmd
	if "%~5"=="" goto :help_log_cmd
	if /i "%~5"=="none" ( set log=0 ) else (set log_dir=%~5)
)
if /i "%~5"=="-log" (
	if "%help_inst%"=="6" goto :help_log_cmd
	if "%help_inst%"=="7" goto :help_log_cmd
	if "%~6"=="" goto :help_log_cmd
	if /i "%~6"=="none" (set log=0 ) else (set log_dir=%~6)
)
if /i "%~6"=="-log" (
	if "%help_inst%"=="7" goto :help_log_cmd
	if "%help_inst%"=="8" goto :help_log_cmd
	if "%~7"=="" goto :help_log_cmd
	if /i "%~7"=="none" (set log=0 ) else (set log_dir=%~7)
)




if /i "%~1"=="-javapath" (
	if not defined help_inst ( 
		set java_path=%~2 
	) else (
	if "%help_inst%"=="2" goto :help_java_cmd
	if "%help_inst%"=="3" goto :help_java_cmd
	)
)


if /i "%~3"=="-javapath" (
	if not defined help_inst (
		set java_path=%~4 
	) else (
	if "%help_inst%"=="4" goto :help_java_cmd
	if "%help_inst%"=="5" goto :help_java_cmd
	)
)

)

rem if "%*"=="-skip" goto :BBStart
if "%*"=="-pmchk" goto :pmchk
if "%*"=="-skip_betamsg" set skip_betamsg=1



:setlog
set CUR_YYYY=%date:~10,4%
set CUR_MM=%date:~4,2%
set CUR_DD=%date:~7,2%
set CUR_HH=%time:~0,2%
if %CUR_HH% lss 10 (set CUR_HH=0%time:~1,1%)

rem set CUR_NN=%time:~3,2%
rem set CUR_SS=%time:~6,2%
rem set CUR_MS=%time:~9,2%

set SUBFILENAME=%CUR_YYYY%-%CUR_MM%-%CUR_DD%


rem This check if the Event Logger is enabled
if "%log%"=="1" (
	if not exist "%log_dir%" mkdir "%log_dir%"
	if not exist "%log_dir%" goto :e05
	goto :LOGISON
) else (
	set log_inst="%tmp%\%dir_brand%\%subfilename%.log"
	if not exist "%tmp%\%dir_brand%" mkdir "%tmp%\%dir_brand%"
	goto :main
)

:LOGISON
set log_dir=%log_dir:"=%
set log_inst="%log_dir%\%SUBFILENAME%.log"
rem set log_inst=^> _^&type _^&type _^>^>%log_dir%\%SUBFILENAME%.log
echo.>>%log_inst%
echo.>>%log_inst%
echo.>>%log_inst%
echo ===================================== [%dbls_brand%] Started on %DATE% %TIME% =====================================>>%log_inst% 
call :info_text



if "%*"=="-info" call :info
if "%*"=="-i" call :info
if "%force_info_show%"=="1" call :info



rem if /i "%~1"=="-d" goto :diag
rem if /i "%~2"=="-d" goto :diag
rem if /i "%~3"=="-d" goto :diag


title %dbls_title%
if "%internal.test.err.enable%"=="1" (
	echo [%date% %time%] INFO: Internal error message testing is enabled, using a flag>>%log_inst%  
	echo [%date% %time%] INFO: This will cause error messages to appear without warrant, it is recommended to clear the flag, when you're done>>%log_inst%  
	findstr /i /r /c:"^[ ]*:%internal.test.err%\>" "%~f0" >nul 2>nul && goto %internal.test.err%
)


:wip_warn
	rem if "%skip_betamsg%"=="1" goto :sys_chk

	rem if "%dbls_stat%"=="dev" call :dev_msg
	rem if "%dbls_stat%"=="beta" call :dev_msg

goto :sys_chk



:funct_banner_help
	echo.
	echo %dbls_title% Help information
	echo ==================================================
	echo.

	goto :eof


:help
	rem These little utility menus (except for info) don't even interface the logging system and imo is unneccessary, so the whole Exit routine is skipped, for the sake of simplicity.
	call :funct_banner_help

	echo Setup Version: %dbls_ver%
	echo Version: %brand_ver%
	echo For more information about this program's configuration, use the -info or -i parameter 
	echo. 
	echo.
	echo NOTE: Using a parameter that uses paths, use quotation marks in the paths with folders that have spaces, e.g. "D:\cool folder\file.txt"
	echo.
	echo  -help (-?)  =  Shows this help screen.
	echo  -info (-i)  =  Shows this program's configuration information.
	echo  -log        =  To temporarily change the log directory ("-log none" to turn off)
	echo.
	echo For more information about each options, just type the specific parameter and add "-?" to retrieve more information and other options.
	echo   Ex. -javapath -?
	echo.
	call :mode_hdl
	goto :eof




:help_log_cmd
	echo.
	call :funct_banner_help

	echo Parameter Help
	echo.
	echo Allows you to specify a different log directory or to disable saving logs
	echo. 
	echo.
	echo  -log 
	echo        [path]   =  New log directory
	echo        none     =  To disable saving logs
	echo.
	echo   Examples:
	echo     -log "Z:\logs"
	echo     -log none
	echo.
	call :mode_hdl
	goto :eof



:help_nomc_cmd
	echo.
	call :funct_banner_help

	echo Parameter Help
	echo.
	echo Allows you to use this utility without a properly installed copy of Minecraft.
	echo.
	echo NOTE: If you use this to override the check for a Minecraft install and you don't have a copy of Java, you will need to download Java or specify an install of Java.
	echo.
	echo  -nomc
	echo.
	echo   There are no further options for this parameter
	echo.
	call :mode_hdl
	goto :eof


:info
	echo.
	echo Setup Configuration and Environment Information
	echo =======================================================
	echo.

set og_log_inst=%log_inst%
	set log_inst=con
	call :info_text
call :info_text_ext
	set log_inst=%og_log_inst%
	
	if "%mode%"=="1" goto :end
	
	pause
goto :eof


:sys_chk

:winveroverride
rem This will override the check for the installed version of Windows. Use only for when supporting versions of Windows that don't exist when the launcher is being written.
if "%override_winverchk%"=="1" (
	echo [%date% %time%] INFO: Windows version check were overridden, using a flag>>%log_inst% 
	goto :misc_sys_chk
)

if "%override_syschk%"=="1" (
	echo [%date% %time%] INFO: All system checks were overridden, using a flag>>%log_inst% 
	goto :misc_sys_chk
)

:WINVERCHK
setlocal
if "%version%" GEQ "10.0" goto :misc_sys_chk
if "%version%" LEQ "6.3" goto :eos
endlocal

:eos
echo.
echo Windows version %version% is not supported at this time
pause
goto :end

:misc_sys_chk
if defined ChocolateyInstall set choco_inst=1

:unattended
if "%unattend_setup_enable%"=="1" (
	goto :auto_mode
)

:functions
rem the functions 

:info_text

	:loadspecs
		for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
		FOR /F %%A IN ('hostname') DO set comp_name=%%A

		rem chk_inst
		rem FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKCU\SOFTWARE\Duplex Software\Corporate Minecraft Mods Installer" /v "Path" 2^> nul') DO set install_dir="%%B"
		rem FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKLM\SOFTWARE\Duplex Software\Corporate Minecraft Mods Installer" /v "Path" 2^> nul') DO set install_dir="%%B"
		if not defined installdir set installdir=Standalone (N/A)


	:rest
		set bb_ver=%bb_ver:"=%
		if "%diag_mode%"==1 goto :info

		echo System information>>%log_inst% 
		echo -------------------->>%log_inst% 
		echo Setup Version: %dbls_ver%>>%log_inst% 
		echo Version: %brand_ver%>>%log_inst%
		echo OS Version:  Windows v%version%>>%log_inst%
		echo Device Name: %comp_name%>>%log_inst%
		echo Working Dir: %cd%>>%log_inst%
		echo Installed Dir: %installdir%>>%log_inst%
		echo -------------------- >>%log_inst%
		echo.>>%log_inst%

	goto :eof


:info_text_ext
	echo Present Settings >>%output%
	echo -------------------- >>%output%

	if "%log%"=="1" ( 
		echo Log is enabled >>%output%
		echo Log Dir: "%log_dir%" >>%output%
			) else (
			echo Logging is disabled, but a temporary file is created in: "%output%" >>%output%
	)

	echo. >>%output%
	echo ===================================== >>%output%
	echo The following packages are currently selected:
	if "%install_feat_esse%"=="1" echo %esse_name%
	if "%install_feat_meapps%"=="1" echo %meapps_name%
	if "%install_feat_av%"=="1" echo %av_name%
	if "%install_feat_vm%"=="1" echo %vm_name%
	if "%install_feat_diskmulti%"=="1" echo %diskmulti_name%
	echo. >>%output%
	echo Custom Settings >>%output%
	echo -------------------- >>%output%
	if defined skip_wgupg echo skip_wgupg=%skip_wgupg% >>%output%
	if defined skip_nofastboot echo skip_nofastboot=%skip_nofastboot% >>%output%
	if defined skip_win10dvd echo skip_win10dvd=%skip_win10dvd% >>%output%
	echo. >>%output%
	echo ===================================== >>%output%


	echo Other Settings >>%output%
	echo -------------------- >>%output%
	if defined internal.force_echo echo internal.force_echo=%internal.force_echo% >>%output%
	if defined internal.force_pause echo internal.force_pause=%internal.force_pause% >>%output%
	if defined internal.test.err.enable echo internal.test.err.enable=%internal.test.err.enable% >>%output%
	if defined internal.test.err echo internal.test.err=%internal.test.err% >>%output%
	if defined skip_betamsg echo skip_betamsg=%skip_betamsg% >>%output%
	echo. >>%output%
	echo ===================================== >>%output%
	echo. >>%output%
	echo Parameters >>%output%
	echo -------------------- >>%output%
	echo %* >>%output%
	echo. >>%output%

	goto :eof




:main
:main_core
call :clean_con
if not "%internal.force_echo%"=="1" cls
if "%auto_inst%"=="1" goto auto_mode

:main_menu
color
echo Configurator version %brand_ver%
echo.
echo.
echo What would you like to install?
echo.
echo [1] %esse_name%
echo      -Disables fast startup
echo [2] %meapps_name%
echo [3] %av_name%
echo [4] %vm_name%
echo [5] %diskmulti_name%
echo [6] %devapps_name%
echo.
echo [8] Scripts and extras!
echo [9] All
echo.
echo [A] Advanced Options
echo [H] Help information
echo [0] or [C] Exit/cancel
echo.
set /p input=[0-9, A,C,H ?]

if not defined input goto :main
rem state 0 = Setup isn't doing anything yet or is done
rem state 1 = installing 
rem state 2 = preparing
rem state 3 = collecting info
if "%input%"=="1" set install_feat_esse=1
if "%input%"=="2" set install_feat_meapps=1
if "%input%"=="3" set install_feat_av=1
if "%input%"=="4" set install_feat_vm=1
if "%input%"=="5" set install_feat_diskmulti=1
if "%input%"=="6" set install_feat_devapps=1

if "%input%"=="8" goto :extras_menu


if "%input%"=="9" (
	set install_feat_esse=1
	set install_feat_meapps=1
	set install_feat_av=1
	set install_feat_vm=1
	set install_feat_diskmulti=1
	set install_feat_devapps=1
	)

if "%input%"=="0" goto :end
if /i "%input%"=="a" goto :custom
if /i "%input%"=="c" goto :end
if /i "%input%"=="b" goto :debug
if /i "%input%"=="h" call :help 

if %input% GEQ 9 (
	if not "%call_good%"=="1" call :invalid
)
if %input% GEQ 1 (
	set setup_state=3
	goto :common
)
goto :main

:incompl
set con_dirty=1
echo.
echo Not implemented
pause

goto :eof


:custom
rem multiple_choice_ux
set call_good=1
if not "%internal_feat_exp_multiple_choice_ux%"=="1" (
	call :incompl
	goto :main
)






goto :custom



:extras_menu
set call_good=1
cls

echo.
echo Scripts 
echo.
echo [1] Disable fast startup [not available yet standalone]
echo [2] Update Windows [not implemented]
echo [3] ???   TBA
echo [4] ???   TBA
echo [5] ???   TBA
echo.
echo Extras (commands/options available)
echo [6] Shutdown / Restart
echo [7] Lock device 
echo [8] ???   TBA
echo [9] ???   TBA
echo.
echo [0] or [C] Cancel and Go back to the Main Menu
echo.
set /p input=[0-9, A,C,H ?]

set con_dirty=1



if "%input%"=="0" goto :main
if /i "%input%"=="b" goto :debug
if /i "%input%"=="c" goto :main
rem if "%input%" GEQ "1" goto :common



call :invalid

goto :extras_menu


:toolset
rem I will move all the extra command sets to here
rem   --Andre

:power_ux
rem need to add the prompt lolol
call :incompl

rem		echo.
rem		echo Do you want to restart or shutdown or cancel?
rem		pause
goto :eof

:power_shutdown
echo.
echo Your device will shutdown in 60 seconds...
shutdown /s /t 60 /c "Shutdown requested by %dbls_title%
waitfor null /t 60
goto :eof

:lock_sys
rundll32.exe user32.dll,LockWorkStation
goto :eof



:debug
set con_dirty=1
color 02
set cmd=
echo.
echo [Debug mode]
echo.
echo If accessed by accident, don't type anything, just press Enter
set /p cmd=
%cmd%
goto :main_core	

:auto_mode
rem owo
set setup_state=2
echo.
echo Setup is starting...
echo Please wait...
echo.
echo.
echo An automated unattended file was found and the following packs will be installed:
if "%install_feat_esse%"=="1" echo  - %esse_name%
if "%install_feat_meapps%"=="1"  echo  - %meapps_name%
if "%install_feat_av%"=="1"  echo  - %av_name%
if "%install_feat_vm%"=="1"  echo  - %vm_name%
if "%install_feat_diskmulti%"=="1"  echo  - %diskmulti_name%
if "%install_feat_devapps%"=="1"  echo  - %devapps_name%

if "%script_enable%"=="1" echo The following scripts will also run:
	


echo.
timeout /t 30

color 90


:common
if "%setup_state%"=="0" (
	rem uh oh  Setup wasn't supposed to begin, backtracking...
	goto :main
)

color
title %dbls_title%
cls
echo %dbls_contitle% 
echo %dbls_underline%
echo.
echo.
echo %dbls_subtext%
echo.
echo.
echo.
echo %dbls_act_text%
echo.
echo.
echo.
echo.
echo %dbls_notice_text%
echo.
echo.
echo %dbls_copyrt_text%
echo.
echo.

set ins_att=0
rem the command above effectively sets the errorlevel, or actually the amount of attempts, which could be useful
call :chk_winget

goto :common_tasks2


:chk_winget
for /f "tokens=2,*" %%a in ('powershell Get-AppxPackage -Name Microsoft.DesktopAppInstaller^| findstr /i "WindowsApps"') do set "winget_dir=%%b"
if not exist "%winget_dir%\winget.exe" (
	if %ins_att% GEQ 1 (
		set err_num=e01

	)
	call :install_winget
)

goto :eof

:install_winget
rem add alt bin support and if exist stuff
rem maybe add unzip rotinue?

rem credit to GFOXSH on github.com!

cd %~dp0\bin\feat_ms_appinstaller
for /f %%i in ('dir /b *VCLibs.140.00_*.appx 2^>nul ^| find /i "x64"') do set "VCLibsX64=%%i"
for /f %%i in ('dir /b *VCLibs.140.00_*.appx 2^>nul ^| find /i "x86"') do set "VCLibsX86=%%i"
for /f %%i in ('dir /b *VCLibs.140.00.UWPDesktop_*.appx 2^>nul ^| find /i "x64"') do set "VCLibsUWPX64=%%i"
for /f %%i in ('dir /b *VCLibs.140.00.UWPDesktop_*.appx 2^>nul ^| find /i "x86"') do set "VCLibsUWPX86=%%i"
for /f %%i in ('dir /b *UI.Xaml.2.7_*.appx 2^>nul ^| find /i "x64"') do set "UIXaml7X64=%%i"
for /f %%i in ('dir /b *UI.Xaml.2.7_*.appx 2^>nul ^| find /i "x86"') do set "UIXaml7X86=%%i"
for /f %%i in ('dir /b *DesktopAppInstaller*.msixbundle 2^>nul') do set "AppInstaller=%%i"

if %os_x64%==1 (
	set "DepInstaller=%VCLibsUWPX64%,%VCLibsUWPX86%,%UIXaml7X64%,%UIXaml7X86%"
) else (
	set "DepInstaller=%VCLibsUWPX86%,%UIXaml7X86%"
)
powershell -NoLogo -NoProfile -NonInteractive -InputFormat None -ExecutionPolicy Bypass Add-AppxPackage -Path %AppInstaller% -DependencyPath %DepInstaller%

cd %~dp0

set /a inst_att = %ins_att% + 1
call :chk_winget
set path=%path%;%winget_dir%


:common_tasks2
if not "%skip_wgupg%"=="1" winget upgrade -r --accept-source-agreements
if not "%skip_chocupg%"=="1" choco upgrade all -y

if not defined ChocolateyInstall (
	winget install --id "Chocolatey.Chocolatey"
	set path=%path%;%systemdrive%\ProgramData\chocolatey
)

if "%install_feat_esse%"=="1" call :install_esse
if "%install_feat_av%"=="1" call :install_av
if "%install_feat_meapps%"=="1" call :install_meapps
if "%install_feat_vm%"=="1" call :install_vm
if "%install_feat_diskmulti%"=="1" call :install_diskmulti
if "%install_feat_devapps%"=="1" call :install_devapps
goto :finalize


:install_esse
winget install --id "7zip.7zip"
choco install paint.net -y


:nofastboot
if "%skip_nofastboot%"=="1" goto :more_esse
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /V HiberbootEnabled /T REG_dWORD /D 0 /F

goto :eof


:install_av
winget install --id "LIGHTNINGUK.ImgBurn" --silent
%bin_dir%av\audacity-win-2.1.3.exe /silent
%bin_dir%av\Lame_v3.99.3_for_Windows.exe /silent
%bin_dir%av\ffmpeg-win-2.2.2.exe /silent

:install_w10dvd
if "%skip_win10dvd%"=="1" goto :eof
if %os_x64%=="1" (set w10dvd_msi_bin=windows10.0-kb3081704-x64.msi ) else (set w10dvd_msi_bin=windows10.0-kb3081704-x86.msi)
mkdir %systemdrive%\temp
msiexec /a %bin_dir%av\w10_dvd\%w10dvd_msi_bin% /qb TARGETDIR=%systemdrive%\temp
powershell -noprofile Add-AppxProvisionedPackage -Online -PackagePath "$env:SystemDrive\temp\InstallDVDAppxPackage\cd0c0ffe0ee94518833e70b1e931fcff.appxbundle" -Licensepath "$env:SystemDrive\temp\InstallDVDAppxPackage\cd0c0ffe0ee94518833e70b1e931fcff_License1.xml"

rmdir /s /q %systemdrive%\temp
goto :eof


:install_meapps
choco install WhatPulse
winget install --id "Discord.Discord" --silent
rem winget install --id "Mojang.MinecraftLauncher" --silent
winget install --id "th-ch.YouTubeMusic" --silent
winget install --id "Valve.Steam" --silent
goto :eof

:install_devapps
winget install --id "Microsoft.VisualStudioCode"
choco install filezilla 
goto :eof

:install_vm
winget install --id "VMware.WorkstationPlayer" --silent
goto :eof

:install_diskmulti
winget install --id "CrystalDewWorld.CrystalDiskInfo"
winget install --id "CrystalDewWorld.CrystalDiskMark"

goto :eof

:msupdate
echo not implemented
pause
goto :eof

:finalize
cls
color 27
echo Installation complete
echo =======================
echo.
echo The following pack(s) has been installed:
if "%install_feat_esse%"=="1" echo  √ %esse_name%
if "%install_feat_meapps%"=="1"  echo  √ %meapps_name%
if "%install_feat_av%"=="1"  echo  √ %av_name%
if "%install_feat_vm%"=="1"  echo  √ %vm_name%
if "%install_feat_diskmulti%"=="1"  echo  √ %diskmulti_name%
echo --------------------------
echo.
echo.
echo Thank you for using my device configurator!
echo.
echo You can check out me out on my website or support me with a tip, if you're feeling generous that is! ^<3
echo.
echo.
echo All the packs have finished installing, would you like to return to the main menu or perform some additional tasks?
echo.
echo [1] Return to Main menu
echo [2] Manage screen timeout and system name
echo [3] Install more apps using ninite.com
echo [4] Enable Microsoft Update and open Windows Update
echo [5] Visit my website andreg.org   ^<3
echo.
echo [0] Exit
echo.
set /p input=[0-5 ?]
if /i "%input%"=="1" goto :main_core
if /i "%input%"=="2" call :fin_steps
if /i "%input%"=="3" explorer http://ninite.com
if /i "%input%"=="4" call :msupdate
if /i "%input%"=="5" explorer http://andreg.org


if /i "%input%"=="0" goto :end
goto :finalize

:error_table
rem Load error table

rem CSU 2.0+ Deprecation Feature Notices
rem Refrain from using warn_resume in the error message itself

:e01
	set err_desc=You need to run this script as administrator 
	set err_act_desc=
	set err_act=
	set err_post_fix_act=
	set err_type=-1
	goto :setup_except


:e02
	set err_num=e02
	set err_desc=%file% could not be found at %path%
	set err_act_desc=
	set err_act=
	set err_post_fix_act=
	set warn_resume=
	set err_type=-1
	goto :setup_except


:e03
	set err_num=e03
	set err_desc=The configuration working directory is not valid, it may not exist or missing configuration files.
	set err_act_desc=find an error that cannot be occurred... congrats, you found an Easter egg...! somehow...
	set err_act=
	set err_post_fix_act=goto :eof
	set err_type=10
	goto :setup_except

:e04
	set err_num=e04
	set err_desc=The forge binary path "%forge_bin%" is invalid, it may not exist or the binary itself is missing from the path
	set err_act_desc=Edit the Setup configuration file, correct or remove invalid entries
	set err_act=notepad "%CONFIG_DIR%\act_mcautosetup.cfg"
	set err_post_fix_act=call :forge_retry
	set err_type=-1
	goto :setup_except

:forge_retry
	for /f "delims=" %%a in ('type "%CONFIG_DIR%\act_mcautosetup.cfg"^|findstr /b "forge_bin"') do set %%a
	set forge_bin=%forge_bin:"=%
	goto :chk_forge_bin

:e05
	set err_num=e05
	set err_desc=The log directory %log_dir% is invalid, it may not exist or point to a drive or network location that is unreachable. A temporary directory was used to log this fault. Said temporary location is at: "%temp%" with the file name of: "%SUBFILENAME%.log."
	set err_act_desc=Edit the Setup configuration file, correct or remove invalid entries
	set err_act=notepad "%CONFIG_DIR%\act_mcautosetup.cfg"
	set err_post_fix_act=goto :setlog
	set err_type=-1
	goto :setup_except

:e06
	set err_num=e06
	set err_desc=The Java directory "%java_path%" is invalid, it may not exist or the binaries are missing from the path 
	set err_act_desc=Edit the Setup configuration file, correct or remove invalid entries
	set err_act=notepad "%CONFIG_DIR%\act_mcautosetup.cfg"
	set err_post_fix_act=goto :java_retry
	set err_type=-1
	goto :setup_except

:e07
	set err_num=e07
	set err_desc=Minecraft was detected to be installed, but the bundled Java Runtime is not available. This may be due to never launching Minecraft into the game itself.
	set err_act_desc=Open Minecraft and create a 1.12.2 profile, start it and wait for it to set itself up, then once the game opens, close it and return to Setup
	set err_act=call :new_mc_logic
	set err_post_fix_act=goto :java_retry
	set err_type=-1
	goto :setup_except



:java_retry
	set java_path=
	for /f "delims=" %%a in ('type "%CONFIG_DIR%\act_mcautosetup.cfg"^|findstr /b "java_path"') do set %%a
	goto :java_determine

rem Internal errors
:ee00
set err_num=ee00
set err_desc=An unknown error has been encountered. This is most likely caused by a programming error in this application. Setup cannot continue.
set err_act_desc=Please report this problem to %company_name%. 
set err_act=call :info
set err_post_fix_act=call :info
set err_type=-1
goto :setup_except

:ee01
set err_num=ee01
set err_desc=The log directory "%log_dir%" is invalid, it may not exist or point to a drive or network location that is unreachable. A temporary directory was used to log this fault. Said location is at: %temp% with the file name of: %SUBFILENAME%.log.
set err_act_desc=Edit the Setup configuration file, correct or remove invalid entries
set err_act=notepad "%CONFIG_DIR%\act_mcautosetup.cfg"
set err_post_fix_act=goto :setlog
set err_type=-1
goto :setup_except

:ee02
set err_num=ee02
set err_desc=An internal error has been been encountered. The present instance of this application could not be determined. This is likely caused by a programming error in this application. Setup cannot continue.
set err_act_desc=Please report this problem to %company_name%. 
set err_act=notepad "%CONFIG_DIR%\act_mcautosetup.cfg"
set err_post_fix_act=goto :setlog
set err_type=-1
goto :setup_except


:diag
rem set diag_mode=1
call :incompl
goto :eof

rem echo.
rem echo Diagnostic mode is enabled
rem set output=%log_inst%
rem set output_deb=%log_inst%
rem set force_info_show=1
rem goto :main

:setup_except
rem This determines whether this is an error or a warning
set con_dirty=1
	rem This value tells the script the the console display is going to be or is "dirty" aka there's a lot of text that should be cleaned when deemed appropriate

set err_enu=%err_num:~0,-2%
set err_numf=%err_num:~1%

echo.
if %err_enu%==e color 47
if %err_enu%==w color 67
title ATTENTION REQUIRED - %dbls_brand% Setup

rem Invalid dir will cause the entire error descriptor to crash Setup...
if not exist %log_inst% (
	set log_inst=%temp%\%SUBFILENAME%.log
)

if %err_enu%==e echo [%date% %time%] ERROR: %err_desc%>>%log_inst% 
if %err_enu%==w echo [%date% %time%] WARNING: %err_desc%>>%log_inst%
if %err_enu%==i echo [%date% %time%] INFO: %err_desc%>>%log_inst%


if %err_enu%==i ( echo A Setup Message is available ) else echo A Setup Exception has occurred
echo.
echo %err_desc%
echo.
echo.
echo %err_act_desc%
echo.
if defined cust_act_msg (echo %cust_act_msg%) else (
	if %err_enu%==e echo Would you like to attempt this fix?
	if %err_enu%==w echo Would you like to continue?
	if %err_enu%==i ( 
		echo To continue, type 'Y' and press Enter to resume Setup. Otherwise, type 'N' if not and press Enter (this will quit Setup^) 
		)
)

set /p input=[Y,N]?
	if /i "%input%"=="y" %err_act% & if %err_enu%==e goto :setup_except_chk
	if %err_enu%==i (if /i "%input%"=="n" goto :end)
	if /i "%input%"=="n" goto :setup_except_chk

	
call :invalid
goto :setup_except




rem function-land

:Invalid
echo The input is not recognized, check your spelling. Please review your options above.
pause
goto :eof

:mode_hdl
if not defined mode goto :ee02
if %mode%==0 (
	pause
	set con_dirty=1
	goto :main
)
set con_dirty=1
goto :eof

:clean_con
if %con_dirty%==1 (
	cls
	color
	set con_dirty=0
	
)
goto :eof






:setup_except_chk
if %err_enu%==i goto :warn_resume
echo.
echo Once you have completed the instructions and corrected the issue(s) above, type 'R' and press Enter to resume Setup.
echo.
echo Error Code: %err_numf%
echo.
echo.

if %err_enu%==e goto :setup_err
if %err_enu%==w goto :setup_warn
echo.

:bad_msg
set err_num=FFF01
cls
title INTERNAL FAULT ENCOUNTERED - %DBLS_TITLE%
echo [%DATE% %TIME%] ERROR: If you are the end-user, send this log to your system administrator or the person who developed this software. Error Code: %err_num%>>%log_inst%
echo.
echo An unexpected error has occurred, there is a programming error in this program. Please notify your system administrator or the person who distributed this piece of software to you, for assistance.
echo.
echo This program will close after dismissing this message.
echo.
echo Error Code: %err_num%
pause
goto :end

:setup_err
echo Or press 'C' to cancel (this will quit Setup)
set /p input=[R,C]?
if /i %input%==r goto :post_err_cleanup
if /i %input%==c set badexit=1 & goto :end

call :invalid
goto :setup_except_chk

:post_err_cleanup
set err_num=0
title %dbls_title%
color 07
%err_post_fix_act% 


:setup_warn
echo Or to ignore this issue, type 'I' and press Enter or type 'C' to cancel (this will quit Setup)
set /p input=[R,I,C]?
if /i %input%==r %err_post_fix_act% & set err_num=0
if /i %input%==i goto %warn_resume% & set err_num=0
if /i %input%==c goto :end 

call :invalid
goto :setup_except_chk


:fin_steps
:autolockprompt
control desk.cpl,,@screensaver
:pc_nameprompt
sysdm.cpl

:end
goto :eof