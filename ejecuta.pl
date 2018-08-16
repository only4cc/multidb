#
# Parametros:
#      $listname : archivo con la lista de parametros para ejecutar
#      $tplname  : plantilla del comando con los "placeholders" parametros 
#
# Invocacion:
# 			perl ejecuta.pl [param\params.txt]  [tpl\plantilla.tpl]
#

use strict;
use warnings;
use Template;

my $DEBUG = 0;

my $listname = shift || '.\\param\params.txt';
my $tplname  = shift || '.\\tpl\plantilla.tpl';

die "Error:\n$0 [<archivo_parametros>] [<nombre_plantilla>]\n" if ( ! $listname or ! $tplname );

my $template = Template->new();
	
open (my $fh, "$listname") or die "Error: No se pudo leer archivo de parametros $listname\n";

print "ejecucion usando la plantilla $tplname y parametros desde $listname ...\n" if $DEBUG; 
my $l;
my $linea = 1;
while ( $l=<$fh> ) {
	next if ( $l =~ /^(#|\s+)/ );   # Para saltarse lineas  ...
	chomp($l);
	my $copia_l = $l;
	print "Procesando $linea: ";
	my @partes = split(/\,/,$copia_l);
	$partes[4] = '***********';
	print join(',',@partes);
		
    my @val = split(/\,/,$l);
	my $vars = { 
				host		=> $val[0],
				server		=> $val[1],
				dbname 		=> $val[2],
				user		=> $val[3],
				pass		=> $val[4],
				scriptfile	=> $val[5],
				logfile		=> $val[6],
				param_fijos	=> $val[7]
			};
		
	print "\nParametros:\n" if $DEBUG;
	foreach my $k ( keys %$vars ) {
		die "Parametro $k con error\n" if ( ! $$vars{$k} and $k ne 'param_fijos' );
		if ( $k ne 'pass' ) {
			print "$k \t $$vars{$k}\n" if ( $$vars{$k} and $DEBUG );
		}
	}
	print "\n";
	
	my $output;
    $template->process($tplname, $vars, \$output)
					or die "Error en uso del Template : ", $template->error(), "\n";

	my $cmd = $output;
	$cmd =~ s/\n//g;
	if ( $DEBUG ) {
		print "Ejecutando:\n$cmd\n";  
	}
	my $resp = `$cmd`;
	print $resp;

	++$linea;
} 
close $fh;


