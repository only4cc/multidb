"C:\Program Files (x86)\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn\sqlcmd.exe"  -s "," -W -h-1  -H [% host %] -S [% server %] -d [% dbname %] -U [% user %] -P [% pass %] -t 3 -i [% scriptfile %] [% param_fijos %]  >> [% logfile %]

