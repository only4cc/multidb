@echo off
REM
REM Revision de los SQL Server errorlogs aca detallados
REM

REM Constantes
set tenant=be
set emaildestino=ArquitecturaDB@e-contact.cl
set cc=jtrumper@e-contact.cl
set fresumen=C:\e-contact\admin\data\errorlog\errorlog_BE.txt
set ambiente=prod

del %fresumen%
echo Revision de errorlogs - %date%  >%fresumen%
echo -------------------------------------------------- >>%fresumen%
echo . >>%fresumen%

echo Banco Estado >>%fresumen%
call perl C:\e-contact\admin\multidb\ejecuta.pl   C:\e-contact\admin\multidb\param\%tenant%\%ambiente%\errorlog.txt
echo revisando resumen en %fresumen% ...
call C:\e-contact\admin\multidb\check_el.bat %tenant% %ambiente% >>%fresumen%
echo enviando mail ...

REM ---------- Envia Mail ---------
call perl C:\e-contact\admin\util\sendm.pl  "eco_dba@e-contact.cl" %emaildestino% %cc%  "Revision de errorlogs SQL Server - %date%"  %fresumen%  %fresumen%




