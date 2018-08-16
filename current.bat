set tenant=%1
set ambiente=prod
perl ejecuta.pl param\%tenant%\%ambiente%\current.txt
