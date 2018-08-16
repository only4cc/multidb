use strict;
use warnings;
use DateTime;
use Date::Calc qw(Delta_Days);
my $hoy = DateTime->now;
my $dias = 1;

## Recibir parametros por linea de comando 26/03/2018
my ($cliente, $ambiente) = @ARGV;

my $fecha_anterior = $hoy - DateTime::Duration->new( days => $dias );
print "tenant:$cliente ambiente:$ambiente - revision desde : $fecha_anterior\n";

my $area ="C:\\e-contact\\admin\\data\\$cliente\\$ambiente\\out\\errorlog";
chdir $area or die "chdir $area: $!";

my @EL = glob("\*");

if ( scalar @EL == 0 ) {
	print ">>> $cliente | sin registros de falla en errorlogs ...\n";
}

my @tok;
my $ERRORES=0;
my $lin=0;
foreach my $el ( @EL ) {
	print "procesando $el ...\n";
	open( my $fh, $el );
	my $l;
	my $errores_file = 0;
	while ( $l = <$fh> ) {
		++$lin;
		#print "$lin ...\n" if ( $lin % 1000 == 0 );
		if ( $l =~ /error/ ) {
			if ( $l !~ / no errors/ ) {
				@tok = split(/\,/,$l);
				my $dif_dias = difdias_a_hoy($tok[0]);
				#print "dif. dias: $dif_dias \n";
				if ( $dif_dias ) {
					alarma($el,$l);
					++$errores_file;
				}
			}
		}
	}
	print "Encontre $errores_file errores en $el\n" if $errores_file;
	close($fh);
}

if ( $ERRORES ) {
	print "RESUMEN: Encontre $ERRORES errores para $cliente ($lin lineas)\n";
} else {
	print "RESUMEN: Sin errores para $cliente ($lin lineas)\n";
}


sub difdias_a_hoy {
	my $fecha = shift;
	my ($ff,$resto) = split(/\s+/,$fecha); 
	my $hh = substr($hoy,0,10);
	my ($year1,$month1,$day1) = split(/-/,$ff);
	my ($year2,$month2,$day2) = split(/-/,$hh);
	my $Dd = Delta_Days($year1,$month1,$day1, $year2,$month2,$day2);
	#print " $ff y $hh \n\n ";
	#my $Dd = $day2 - $day1;
	if ( $Dd <= 1 ) {
		return 1;
	} else {
		return 0;
	}
}

sub alarma {
	my $el = shift;
	my $linea = shift;
	print "\nError en $el\n";
	++$ERRORES;
	print $linea;
}
