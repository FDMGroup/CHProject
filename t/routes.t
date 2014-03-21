#perl
use strict;
use warnings;
use Test::More;
use Test::Mojo;
use CHProject;
use Mojo;

my $self = shift;
my $t = Test::Mojo->new('CHProject');

#Some Perl tests to confirm controllers exist
use_ok 'lib::CHProject', 'CHProject.pm should load';
use_ok 'lib::CHProject::Controller::ChangeName', 'ChangeName.pm should load';
use_ok 'lib::CHProject::Controller::ConsentToAct', 'ConsentToAct.pm should load';
use_ok 'lib::CHProject::Controller::Update', 'Update.pm should load';
use_ok 'lib::CHProject::Controller::Summary', 'Summary.pm should load';

#Check each route loads the correct templates, forms have correct fields
$t->get_ok('/')->text_is(title => 'Welcome')->content_like(qr/Mojolicious/);
$t->get_ok('/changeName')->text_is( title => 'Change Company Name')->element_exists('div.form-group')
	->element_exists('input#company_name')
	->element_exists('input#company_id')
	->element_exists('input#new_name')
	->element_exists_not('input#birth');
$t->get_ok('/consentToAct')->text_is( title => 'Consent to Act')->content_like(qr/3 characters/)
	->element_exists('div.form-group')->element_exists_not('input#company_id')
	->element_exists('input#birth')
	->element_exists('input#phone')
	->element_exists('input#passport')
	->element_exists('input#nin')
	->element_exists('input#maiden')
	->element_exists('input#eye')
	->element_exists('input#father');
$t->get_ok('/summary')->text_is( title => 'Summary')->content_like(qr/changed the name to/)
	->element_exists('div img');
$t->get_ok('/update');

$t = $t->request_ok(Mojo::Transaction::HTTP->new);

my $id = '4';
my $tx = $t->ua->post('/changeName' => form => {company_id => $id });
$t->request_ok($tx);

$t->post_ok('/changeName' => form => { company_id => '4', company_name => 'Debenhams PLC', new_name => 'Debenhams'})->text_is( title => 'Consent to Act');

done_testing();
