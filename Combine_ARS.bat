@echo off
setlocal
cd /d "%~dp0"
if errorlevel 1 (
  echo ERROR: Cannot access the batch file folder.
  pause
  exit /b 1
)
for %%N in (001 002 003 004 005) do (
  if not exist "AutomaticRedditStories_Update.zip.part%%N" (
    echo ERROR: Missing part %%N
    pause
    exit /b 1
  )
)
echo Combining the five ZIP parts...
copy /b "AutomaticRedditStories_Update.zip.part001"+"AutomaticRedditStories_Update.zip.part002"+"AutomaticRedditStories_Update.zip.part003"+"AutomaticRedditStories_Update.zip.part004"+"AutomaticRedditStories_Update.zip.part005" "AutomaticRedditStories_Update.zip" >nul
if errorlevel 1 (
  echo ERROR: Failed to combine ZIP parts.
  pause
  exit /b 1
)
echo Extracting the application...
powershell.exe -NoProfile -Command "Expand-Archive -LiteralPath '.\AutomaticRedditStories_Update.zip' -DestinationPath '.\AutomaticRedditStories' -Force"
if errorlevel 1 (
  echo ERROR: Failed to extract the ZIP.
  pause
  exit /b 1
)
if not exist "AutomaticRedditStories\AutomaticRedditStories.exe" (
  echo ERROR: Application EXE missing after extraction.
  pause
  exit /b 1
)
echo Launching AutomaticRedditStories...
start "" "%~dp0AutomaticRedditStories\AutomaticRedditStories.exe"
if errorlevel 1 (
  echo ERROR: Failed to launch the application.
  pause
  exit /b 1
)
echo Done.
pause
