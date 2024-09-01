@echo off

echo Installing prerequisites on Windows using Chocolatey...

:: Check if Chocolatey is installed
choco -v >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is not installed. Installing Chocolatey...
    @powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"
    @powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
    refreshenv
)

:: Install tree
choco install tree --yes

:: Install terraform-docs
choco install terraform-docs --yes

:: Install python and pylint
choco install python --yes
pip install pylint

:: Locate terraform-docs and add it to PATH if not already present
for /f "delims=" %%a in ('where terraform-docs') do (
    set "terraform_docs_path=%%~dpa"
)
if not defined terraform_docs_path (
    echo "Adding terraform-docs to PATH..."
    set "terraform_docs_path=C:\ProgramData\chocolatey\lib\terraform-docs\tools\"
    setx PATH "%PATH%;%terraform_docs_path%"
)

:: Locate pylint and add it to PATH if not already present
for /f "delims=" %%a in ('where pylint') do (
    set "pylint_path=%%~dpa"
)
if not defined pylint_path (
    echo "Adding pylint to PATH..."
    for /f "delims=" %%a in ('pip show pylint ^| findstr /r /c:"Location:"') do (
        set "pylint_location=%%a"
    )
    set "pylint_location=%pylint_location:Location=%
    set "pylint_location=%pylint_location: =%\Scripts\"
    setx PATH "%PATH%;%pylint_location%"
)

echo Installation completed. Please restart your terminal or run 'refreshenv' to apply changes.

exit 0