#
# Parametros:
#      $tplname  : plantilla del comando con los "placeholders" parametros 
#
use strict;
use warnings;
use Template;
use Getopt::Long;


# carga la plantilla de ejecucion del sqlcmd
# "C:\...\sqlcmd.exe" -S [% server %] -d [% dbname %] -U [% user %] -P [% pass %] -t 3 -i [% scriptfile %] [% param_fijos %] >> [% logfile %]

my $tplname  = shift || 'plantilla.tpl';
my $template = Template->new();

my $server;
my $dbname;
my $user;
my $password;
my $scriptfile;
  
GetOptions(
  'server=s' => \$server,
  'dbname=s' => \$dbname,
  'user=s' => \$user,
  'password=s' => \$password,
  'scriptfile=s' => \$scriptfile,
) or die "$0: Opciones invalidas\n";


print $server;
print $dbname;
print $user;
print $password;
print $scriptfile;

my $vars = {
	server		=> $server,
	dbname		=> $dbname,
	user		=> $user,
	pass		=> $password,
	scriptfile	=> $scriptfile,
	logfile		=> $scriptfile.".log",
#	param_fijos	=> $ARGV[5],
};
	

my $output_tpl;
$template->process($tplname, $vars, \$output_tpl)
					or die "Error en uso del Template : ", $template->error(), "\n";

my $cmd = $output_tpl;
$cmd =~ s/\n//g;
print "Ejecutando $cmd";
# Por el momento sin ejecutar ..
=begin
my $resp = `$cmd`;
=cut


