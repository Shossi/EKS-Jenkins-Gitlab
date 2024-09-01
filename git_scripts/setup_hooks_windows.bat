@echo off

echo Setting up Git hooks...

xcopy /s /y .\git_hooks\* .git\hooks\

echo Git hooks set up successfully.

exit 0
