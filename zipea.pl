use Archive::Zip;   

my $dir     = shift;
my $destino = shift;

my $obj = Archive::Zip->new();   
my @files = <$dir/*>;

foreach $file (@files) {
    $obj->addFile($file);   
}

if ($obj->writeToFileNamed($destino) != AZ_OK) {  
    print "Error!";
} else {
    print "Archivo creado!";
}