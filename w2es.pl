#
# Objetivo: Registro de tlog en ES
#
# Parametros
#      $ts          : instante o fecha del respaldo
#      $serverid    : id. del servidor o cluster
#      $dbname      : nombre de la bd
#      $tlog_mb     : uso del TLOG en el intervalo en MB
#

use strict;
use warnings;
use Data::Dumper;   # Sacar en amb. de Prod.
use Search::Elasticsearch;
use POSIX qw(strftime);

my $DEBUG = 0;
my $ts    = localtime();  # Epoch 
my $dt    = time();
my $tsf   = strftime('%Y-%m-%dT%H:%M:%S', gmtime($dt));

# Parametros
my $serverid    = shift;
my $dbname      = shift;
my $tlog_mb     = shift;
my $tenant      = shift;

my $HOST  = "10.33.32.116";   
my $PORT  = 9200;

my $e = Search::Elasticsearch->new(
    nodes => [ "$HOST:$PORT" ],
	trace_to => 'Stderr'
);

$e->index(
    index   => 'crece_tlog',
    type    => 'mssql_log',
    body    => {
                    timestamp   => $tsf,
                    serverid    => $serverid,
                    dbname      => $dbname,
                    tlog_mb 	=> ($tlog_mb/1),
					tenant      => $tenant
                }
);

