use POSIX 'strftime';
my $date = strftime '%Y%m%d', localtime;

my $fname=shift;
my $newname = $fname; 
$newname =~ s/zip//gi;

rename $fname, $newname."$date".'.zip';
