@echo off
title variables
echo bienvenido al ejercicio para aprender variables
echo .
echo presiona una tecla para continuar
pause > nul
set /p nombre=como te llamas?
set /p edad=cuantos anios tenes?
set /p comida= que comes?
pause > nul
echo hola %nombre%
echo veo que tienes %edad% anios verdad?
echo como rayos te puede gustar %comida%?
pause > nul
exit