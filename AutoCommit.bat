@echo off
echo Commit Automatico
set /p razon=rason del commit?
git add *
git commit -m %razon%
git push
echo terminado
pause
exit