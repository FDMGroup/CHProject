package CHProject;
use Mojo::Base 'Mojolicious';
use Mango;

# This method will run once at server start
sub startup {
  my $self = shift;
  push@{$self->routes->namespaces},'CHProject::Controller';

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');
  $self->helper( db => \&helper_mango );

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');
  $r->route('/changeName')->via('GET', 'POST')->to('ChangeName#changeName');
  $r->route('/summary')->via('GET', 'POST')->to('summary#summary');
}

sub helper_mango{
	my $self = shift;
	state $mango = Mango->new ( 'mongodb://localhost:27017' );
	return $mango->db ('CompaniesHouse');
}

1;
