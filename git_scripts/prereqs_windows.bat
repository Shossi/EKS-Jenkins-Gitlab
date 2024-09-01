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

:: Install pylint
choco install python --yes
pip install pylint

echo Installation completed. Please restart your terminal or run 'refreshenv' to apply changes.

exit 0


:: in case of pylint command not running after the installation :
:: You will need to Locate your python scripts directory path,
:: Ususally it will look like so : C:\Users\***user***\AppData\Local\Packages\PYTHONVERSION\LocalCache\local-packages\Pythonversion\Scripts
:: This can be found through : pip show pylint
:: The path needs to be added to your env variables in your computer,
:: System Properties > Advanced > Environment Variables > Path > Edit > new
:: and add the scripts path there. after which you will need to restart your ide and it will work.
:: pylint --version to verify.