@echo off
REM
REM Revision de los SQL Server errorlogs aca detallados
REM

REM Constantes
set ctaorigen=eco_dba@e-contact
REM set emaildestino=jtrumper@e-contact.cl
set emaildestino=ArquitecturaDB@e-contact.cl
set cc=""
REM set cc=jtrumper@e-contact.cl
set fresumen=C:\e-contact\admin\data\errorlog\errorlog_resumen.txt
set ambiente=prod

REM Borra salidas anteriores ...
del %fresumen%

echo Revision de errorlogs - %date%  >%fresumen%
echo -------------------------------------- >>%fresumen%
echo. >>%fresumen%

echo CAAS >>%fresumen%
set tenant=caas
del /F C:\e-contact\admin\data\%tenant%\%ambiente%\out\errorlog\*.out
perl C:\e-contact\admin\multidb\ejecuta.pl   C:\e-contact\admin\multidb\param\%tenant%\%ambiente%\errorlog.txt
call C:\e-contact\admin\multidb\check_el.bat %tenant% %ambiente% >>%fresumen%
 
echo CLARO >>%fresumen%
set tenant=claro
del /F C:\e-contact\admin\data\%tenant%\%ambiente%\out\errorlog\*.out
perl C:\e-contact\admin\multidb\ejecuta.pl   C:\e-contact\admin\multidb\param\%tenant%\%ambiente%\errorlog.txt
call C:\e-contact\admin\multidb\check_el.bat %tenant% %ambiente% >>%fresumen%

echo Banco Estado >>%fresumen%
set tenant=be
del /F C:\e-contact\admin\data\%tenant%\%ambiente%\out\errorlog\*.out
perl C:\e-contact\admin\multidb\ejecuta.pl   C:\e-contact\admin\multidb\param\%tenant%\%ambiente%\errorlog.txt
call C:\e-contact\admin\multidb\check_el.bat %tenant% %ambiente%  >>%fresumen%

echo VTR >>%fresumen%
set tenant=vtr
del /F C:\e-contact\admin\data\%tenant%\%ambiente%\out\errorlog\*.out
perl C:\e-contact\admin\multidb\ejecuta.pl   C:\e-contact\admin\multidb\param\%tenant%\%ambiente%\errorlog.txt  tpl\plantilla_vtr.tpl
call C:\e-contact\admin\multidb\check_el.bat %tenant% %ambiente% >>%fresumen%

REM ---------- Envia Mail ---------
perl C:\e-contact\admin\util\sendm.pl  %ctaorigen% %emaildestino% %cc%  "Revision de errorlogs SQL Server - %date%"  %fresumen% %fresumen%

REM ---------- Revisa si corresponde enviar Ticket ---------
perl C:\e-contact\admin\multidb\avisar.pl %fresumen% "RESUMEN: Encontre"



