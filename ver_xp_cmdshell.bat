set tenant=%1
set ambiente=%2
perl C:\e-contact\admin\multidb\ejecuta.pl C:\e-contact\admin\multidb\param\%tenant%\%ambiente%\ver_xp_cmdshell.txt

REM perl zipea.pl ..\data\out\%tenant%\%ambiente%\  ..\data\%tenant%\%ambiente%\\ver_xp_cmdshell.zip
REM perl datea.pl "out\\audit.zip"
