set tenant=%1
set ambiente=%2
perl ejecuta.pl param\%tenant%\%ambiente%\usuarios_sysadmin.txt

REM perl zipea.pl ..\data\out\dbnames\  ..\data\out\\usuarios_sysadmin.zip
REM perl datea.pl ..\data\out\\usuarios_sysadmin.zip
