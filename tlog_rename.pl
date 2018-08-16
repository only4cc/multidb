use strict;
use warnings;

use File::Copy qw(move);

my $tenant   = shift;
my $ambiente = shift;

my @oldfiles = <C:\\e-contact\\admin\\data\\$tenant\\$ambiente\\out\\tlog\\*.out>;

my $new_name;
foreach my $old ( @oldfiles ) {
	$new_name = $old;
	$new_name =~ s/\.out/\.old/;
	#print "Renombrando $old --> \n \t $new_name ...\n";
	move $old, $new_name;
	unlink $old;
}