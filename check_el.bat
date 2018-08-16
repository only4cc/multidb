set tenant=%1
set ambiente=%2
echo Revisando errorlogs de: %tenant%  ambiente: %ambiente% ...

REM Borra salidas anteriores ...
perl -w C:\e-contact\admin\multidb\check_el.pl %tenant% %ambiente% 
echo.
echo.
