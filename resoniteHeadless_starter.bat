rem ___________________
rem BEGIN CONFIGURATION
rem ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
set SteamCMD_Dir=SteamCMD.EXE_location_here
rem ^ Location to dirctory containing steamcmd.exe ^
set Server_Dir=location_of_server
rem ^ Location to directory that the Server will be installed in (Changing `location_of_server` is where the server files will be Installed.)^
set Executable_Dir=location_of_server_EXE_file
rem ^ Location to directory containing the following executable (Changing `location_of_server_EXE_file` will need to be the Directory of the EXE, not the file itself.)^
rem ^ For Headless Resonite servers, it will be under "Headless" Folder in the location you install/configure here. You will need to install the server FIRST before seeing the correct EXE file^
set Server_Executable=Resonite.exe
rem ________________
rem BEGIN BATCH CODE
rem ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
cls
@echo off
title Resonite-Headless                                                                                                                                                                 
echo Closing this window will turn off Auto-Start!
echo If the server Crashes, it will Restart in 15 Seconds of it being stopped.
echo.
:start
tasklist /nh /fi "Imagename eq %Server_Executable%" | find "Resonite"
if ERRORLEVEL=1 goto update
if ERRORLEVEL=0 goto close
:update
echo Checking For any Updates to the Server file...
start "" /b /w /high "%SteamCMD_Dir%\steamcmd.exe" +login USER +force_install_dir "%Server_Dir%" +app_update 2519830 -beta headless -betapassword BETAPASSWORD validate +quit :: Remember to change USER and BETAPASSWORD to the corect values!
echo.
echo The Server should have been started!
echo If not, Please ether check for issues in Config, or Give an error code to someone that can help.
echo.
echo Waiting For Crash/Exit...
cd "%Executable_Dir%"
start "" /w /high "%Server_Executable%" :: Using "-log" Will Prevent Automatic Crash Detection
echo Crash/Exit Detected!
echo Will retry to start back up the Server in 15 Seconds...
echo.
echo CTRL+C To Freeze Before Restarting
timeout /t 15
goto start
:close
echo.
echo !ERROR! SERVER ALREADY RUNNING! SHUTDOWN WILL COMMENCE
taskkill /im "%Server_Executable%" /f /t
timeout /t 3
goto start
