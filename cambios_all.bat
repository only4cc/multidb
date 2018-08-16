@echo off
REM
REM Revision de cambios los SQL Server aca detallados
REM
REM

REM Constantes
set ctaorigen=eco_dba@e-contact
set emaildestino=ArquitecturaDB@e-contact.cl
REM set emaildestino=jtrumper@e-contact.cl
set cc=jtrumper@e-contact.cl
set fresumen=C:\e-contact\admin\data\cambios\cambios_resumen.txt
set ambiente=prod

del %fresumen%
echo Cambios en SQL Server - %date%  >%fresumen%
echo ------------------------------------------- >>%fresumen%

echo Ambiente CAAS >>%fresumen%
set tenant=caas
del  C:\e-contact\admin\data\%tenant%\%ambiente%\out\cambios\*.out
perl C:\e-contact\admin\multidb\ejecuta.pl C:\e-contact\admin\multidb\param\%tenant%\%ambiente%\cambios.txt 
type C:\e-contact\admin\data\%tenant%\prod\out\cambios\*.*   >>%fresumen%
echo. >>%fresumen%

echo Ambiente CLARO >>%fresumen%
set tenant=claro
del  C:\e-contact\admin\data\%tenant%\%ambiente%\out\cambios\*.out
perl C:\e-contact\admin\multidb\ejecuta.pl C:\e-contact\admin\multidb\param\%tenant%\%ambiente%\cambios.txt 
type C:\e-contact\admin\data\%tenant%\prod\out\cambios\*.*   >>%fresumen%
echo. >>%fresumen%

echo Ambiente VTR >>%fresumen%
set tenant=vtr
echo. >>%fresumen%
del  C:\e-contact\admin\data\%tenant%\%ambiente%\out\cambios\*.out
call perl C:\e-contact\admin\multidb\ejecuta.pl C:\e-contact\admin\multidb\param\%tenant%\%ambiente%\cambios.txt tpl\plantilla_vtr.tpl
call type C:\e-contact\admin\data\%tenant%\prod\out\cambios\*.*   >>%fresumen%

echo Ambiente BE >>%fresumen%
set tenant=be
del  C:\e-contact\admin\data\%tenant%\%ambiente%\out\cambios\*.out
perl C:\e-contact\admin\multidb\ejecuta.pl C:\e-contact\admin\multidb\param\%tenant%\%ambiente%\cambios.txt  
type C:\e-contact\admin\data\be\prod\out\cambios\*.*     >>%fresumen%
echo. >>%fresumen%


REM ---------- Envia Mail ---------
perl C:\e-contact\admin\util\sendm.pl  %ctaorigen% %emaildestino% %cc%  "Cambios en los SQL Server - %date%"  %fresumen%

