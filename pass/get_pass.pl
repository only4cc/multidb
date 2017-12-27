use strict;
use warnings;
use File::KeePass;

my $pass_file = 'MyKeePass2.kdbx'; 
my $kp_db     = File::KeePass->new;

my ($super_secreta, $title) = @ARGV;
 
die "Error\nUso: $0 <supersecreta> <entrada>\n" if (not defined $super_secreta or not defined $title);

$kp_db->load_db($pass_file, $super_secreta);
$kp_db->unlock; 

my $entry = $kp_db->find_entry({ title => $title }); 
if ( defined $entry->{password} ) {
	print $entry->{password};
} else {
	print "no existe entrada para $title";
}

 