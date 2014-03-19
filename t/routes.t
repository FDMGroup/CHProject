#perl
use strict;
use warnings;
use Test::More;
use Test::Mojo;
use CHProject;
use Mojo;
use Mango;

my $self = shift;
my $mango = Mango->new( 'mongodb://localhost:27017' );
$mango->db( 'CompaniesHouse' );

my $t = Test::Mojo->new('CHProject');

$t->get_ok('/');
$t->get_ok('/changeName');
$t->get_ok('/summary');
$t->get_ok('/update');
$t->get_ok('/consentToAct');

$t = $t->request_ok(Mojo::Transaction::HTTP->new);

my $id = '15';
my $tx = $t->ua->post('/changeName' => form => {company_id => $id });
$t->request_ok($tx);

done_testing();
