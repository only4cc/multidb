use strict;
use warnings;

my $tenant   = shift;
my $ambiente = shift;

my $FACTOR   = 1;
my $MB       = 100;
my @oldfiles = <C:\\e-contact\\admin\\data\\$tenant\\$ambiente\\out\\tlog\\*.old>;
my $hoy      = localtime()." ";

my $ctaorigen	 ="eco_dba\@e-contact";
my $emaildestino ="ArquitecturaDB\@e-contact.cl";
my $cc			 ="jtrumper\@e-contact.cl";
my $fresumen     ="C:\\e-contact\\admin\\data\\tlog\\tlog_crece.txt";

my $servername;   #servername:<servername>
my $new_name;
my @t;
my $server;
foreach my $old ( @oldfiles ) {
	$new_name = $old;
	$new_name =~ s/\.old/\.out/;
	print "Comparando $old --> \n \t $new_name ...\n";
	my $ref_old = fill_hash( $old );
	my $ref_new = fill_hash( $new_name );
	my %h_old = %$ref_old;
	my %h_new = %$ref_new;
	my $dif;
	
	print "Revisando $servername\n";
	foreach my $k ( sort keys %h_old) {	
		if ( $k ne $servername ) {
			#print "BD OLD: $k \t tamano: ".$h_old{$k}."\t";
			#rint "BD NEW: $k \t tamano: ".$h_new{$k}."\n";	
			$dif = int($h_new{$k} - $h_old{$k});
			if ( $dif >= $MB ) {
				print "Alarma en $tenant en $servername el Tlog de la bd $k crecio ". $dif ."...\n";
				system("perl C:\\e-contact\\admin\\util\\sendm.pl  $ctaorigen $emaildestino $cc \"Crecimiento excesivo TLog SQL Server en $tenant $servername BD:$k crecimiento:$dif - $hoy\"  $fresumen");
			}
			else {
				print "Sin problemas para $tenant en $servername la bd $k crecio ". $dif ." MB ...\n";
			}
			@t = split(/:/,$servername);
			$server =$t[1];
			system("perl C:\\e-contact\\admin\\multidb\\w2es.pl $server $k $dif $tenant");
		}
	}
}

sub fill_hash {
	my $fname = shift;
	open (my $fh, $fname) or warn "$!\n";
	my $l;
	my %h;
	my @tok;
	while ( $l=<$fh> ) {
		if ( $l =~ /servername/ ) {
			$servername = $l;
		}
		if ( $l =~ /(DBCC|servername)/ ) {
			1;
		} else {
		   @tok = split(/\,/,$l);
		   $h{ $tok[0] } = $tok[1] || '1';
		}
	}
	close( $fh );
	return \%h;
}