@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

REM Clear previous values
set "Eco="
set "Balanced="
set "HighPerformance="
set "UltraPerformance="

REM Get and store power schemes with fixed parsing
for /f "tokens=2,3 delims=: " %%a in ('powercfg -list ^| findstr "GUID"') do (
    set "line=%%a %%b"
    set "guid=!line:~0,36!"
    set "name=!line:~38!"
    if "!name!"=="(节能)" set "Eco=!guid!"
    if "!name!"=="(平衡)" set "Balanced=!guid!"
    if "!name!"=="(高性能)" set "HighPerformance=!guid!"
    if "!name!"=="(卓越性能)" set "UltraPerformance=!guid!"
)

REM Create missing schemes if needed
if not defined Eco powercfg -duplicatescheme a1841308-3541-4fab-bc81-f71556f20b4a >nul 2>&1
if not defined Balanced powercfg -duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1
if not defined HighPerformance powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
if not defined UltraPerformance powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1

REM Get updated GUIDs after creation with fixed parsing
for /f "tokens=2,3 delims=: " %%a in ('powercfg -list ^| findstr "GUID"') do (
    set "line=%%a %%b"
    set "guid=!line:~0,36!"
    set "name=!line:~38!"
    if "!name!"=="(节能)" set "Eco=!guid!"
    if "!name!"=="(平衡)" set "Balanced=!guid!"
    if "!name!"=="(高性能)" set "HighPerformance=!guid!"
    if "!name!"=="(卓越性能)" set "UltraPerformance=!guid!"
)

:menu
cls
echo Power Scheme Control
echo ------------------
echo Current Power Schemes:
if defined Eco echo 1. 节能 [!Eco!]
if defined Balanced echo 2. 平衡 [!Balanced!]
if defined HighPerformance echo 3. 高性能 [!HighPerformance!]
if defined UltraPerformance echo 4. 卓越性能 [!UltraPerformance!]
echo 5. Exit

REM Prompt for user input
set "choice="
set /p "choice=Select power scheme (1-5): "

REM Validate and process user input
if "!choice!"=="" (
    echo No input detected. Please try again.
    timeout /t 2 >null
    goto menu
) else if "!choice!"=="1" (
    if defined Eco (
        powercfg /s "!Eco!"
        if !errorlevel! equ 0 (echo Switched to 节能 mode) else (echo Failed to switch mode)
    ) else (
        echo 节能 mode not found. Please try again.
        timeout /t 2 >null
        goto menu
    )
) else if "!choice!"=="2" (
    if defined Balanced (
        powercfg /s "!Balanced!"
        if !errorlevel! equ 0 (echo Switched to 平衡 mode) else (echo Failed to switch mode)
    ) else (
        echo 平衡 mode not found. Please try again.
        timeout /t 2 >null
        goto menu
    )
) else if "!choice!"=="3" (
    if defined HighPerformance (
        powercfg /s "!HighPerformance!"
        if !errorlevel! equ 0 (echo Switched to 高性能 mode) else (echo Failed to switch mode)
    ) else (
        echo 高性能 mode not found. Please try again.
        timeout /t 2 >null
        goto menu
    )
) else if "!choice!"=="4" (
    if defined UltraPerformance (
        powercfg /s "!UltraPerformance!"
        if !errorlevel! equ 0 (echo Switched to 卓越性能 mode) else (echo Failed to switch mode)
    ) else (
        echo 卓越性能 mode not found. Please try again.
        timeout /t 2 >null
        goto menu
    )
) else if "!choice!"=="5" (
    echo Exiting script...
    timeout /t 2 >null
    exit /b
) else (
    echo Invalid input. Please try again.
    timeout /t 2 >null
    goto menu
)