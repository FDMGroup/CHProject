package CHProject;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;
  push@{$self->routes->namespaces},'CHProject::Controller';

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');
  $r->route('/changeOfName')->via('GET', 'POST')->to('Summary#summary');
}

1;
