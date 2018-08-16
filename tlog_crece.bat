@echo off
REM
REM Revision de crecimiento de los TLog 
REM de los SQL Server aca detallados
REM
REM

REM Constantes
set ctaorigen=eco_dba@e-contact
set emaildestino=ArquitecturaDB@e-contact.cl
REM set emaildestino=jtrumper@e-contact.cl
set cc=jtrumper@e-contact.cl
set fresumen=C:\e-contact\admin\data\cambios\tlog_crece_resumen.txt
set ambiente=prod

del %fresumen%
echo Monitor de crecimiento T-Log en SQL Server - %date%  >%fresumen%
echo ---------------------------------------------------- >>%fresumen%

echo Ambiente CAAS >>%fresumen%
set tenant=caas
perl C:\e-contact\admin\multidb\tlog_rename.pl %tenant% %ambiente%  
perl C:\e-contact\admin\multidb\ejecuta.pl C:\e-contact\admin\multidb\param\%tenant%\%ambiente%\tlog.txt 
perl C:\e-contact\admin\multidb\tlog_crece.pl %tenant% %ambiente%  

echo Ambiente CLARO >>%fresumen%
set tenant=claro
perl C:\e-contact\admin\multidb\tlog_rename.pl %tenant% %ambiente%  
perl C:\e-contact\admin\multidb\ejecuta.pl C:\e-contact\admin\multidb\param\%tenant%\%ambiente%\tlog.txt 
perl C:\e-contact\admin\multidb\tlog_crece.pl %tenant% %ambiente%  

echo Ambiente BE >>%fresumen%
set tenant=be
perl C:\e-contact\admin\multidb\tlog_rename.pl %tenant% %ambiente%  
perl C:\e-contact\admin\multidb\ejecuta.pl C:\e-contact\admin\multidb\param\%tenant%\%ambiente%\tlog.txt 
perl C:\e-contact\admin\multidb\tlog_crece.pl %tenant% %ambiente%  

echo Ambiente VTR >>%fresumen%
set tenant=vtr
perl C:\e-contact\admin\multidb\tlog_rename.pl %tenant% %ambiente%  
perl C:\e-contact\admin\multidb\ejecuta.pl C:\e-contact\admin\multidb\param\%tenant%\%ambiente%\tlog.txt  tpl\plantilla_vtr.tpl
perl C:\e-contact\admin\multidb\tlog_crece.pl %tenant% %ambiente% 
