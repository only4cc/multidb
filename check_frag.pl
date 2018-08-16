use strict;
use warnings;
use DateTime;
use Date::Calc qw(Delta_Days);
my $hoy = DateTime->now;
my $dias = 1;

my $UMBRAL_FRAGM = 0.1;

my $fecha_anterior = $hoy - DateTime::Duration->new( days => $dias );
print "revision desde : $fecha_anterior\n";

my $area ="C:\\e-contact\\admin\\data\\out\\fragment";
chdir $area or die "chdir $area: $!";

my @REP_FRAG = glob("\*");

my @tok;
foreach my $rf ( @REP_FRAG ) {
	print "Revisando $rf ...\n";
	open( my $fh, $rf );
	my @lrf = <$fh>;
	close($fh);
	foreach my $l ( @lrf ) {
		#print $l;
		my @tok = split(/\,/,$l);
		#my $j=0;
		#foreach my $t ( @tok ) { print "$j : $t\t"; ++$j; }			
		if ( $tok[6] > $UMBRAL_FRAGM ) {
			print $l;
		} 
	}
}
