package CHProject;
use Mojo::Base 'Mojolicious';
use Mojolicious::Plugins;
use Mango;

# This method will run once at server start
sub startup {
  my $self = shift;
  push@{$self->routes->namespaces},'CHProject::Controller';

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');
  $self->plugin('Helpers');
  $self->helper( db => \&helper_mango );

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');
  $r->route('/changeName')->via('GET', 'POST')->to('ChangeName#changeName');
  $r->route('/summary')->via('GET', 'POST')->to('Summary#summary');
  $r->get('/update')->to('Update#update');
  $r->route('/consentToAct')->via('GET', 'POST')->to('ConsentToAct#consentToAct');
}

sub helper_mango {
	my $self = shift;
	state $mango = Mango->new( 'mongodb://localhost:27017' );
	return $mango->db( 'CompaniesHouse' );
}

1;
