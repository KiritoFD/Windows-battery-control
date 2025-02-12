@echo off
setlocal

:: Define power schemes GUIDs
set "Eco=cbf70548-b55b-49e2-9efd-07581c23adf2"
set "Balanced=40eda744-de89-4383-94fd-00f30c3a61d4"
set "HighPerformance=4cc712c1-cb8e-483d-9b82-5b95effa045d"
set "UltraPerformance=3cea01f8-6d36-47bd-84be-b76a31c7e6de"

:: Display current power scheme
for /f "tokens=2 delims=: " %%a in ('powercfg /getactivescheme') do (
    set "currentScheme=%%a"
)
echo Current Power Scheme: %currentScheme%

:menu
:: Prompt user to select power scheme
echo Please select a power scheme:
echo 1. Eco
echo 2. Balanced
echo 3. High Performance
echo 4. Ultra Performance
echo 5. Exit

set /p "choice=Enter a number to select a power scheme (1-5): "

:: Switch power scheme based on user input
if "%choice%"=="1" (
    powercfg -s %Eco%
    echo Switched to Eco mode.
) else if "%choice%"=="2" (
    powercfg -s %Balanced%
    echo Switched to Balanced mode.
) else if "%choice%"=="3" (
    powercfg -s %HighPerformance%
    echo Switched to High Performance mode.
) else if "%choice%"=="4" (
    powercfg -s %UltraPerformance%
    echo Switched to Ultra Performance mode.
) else if "%choice%"=="5" (
    echo Exiting script.
    exit /b
) else (
    echo Invalid input, please enter a number between 1-5.
    pause
    
)
goto menu
pause