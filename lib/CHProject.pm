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
  $r->route('/changeName')->via('GET', 'POST')->to('ChangeName#changeName');
  $r->route('/summary')->via('GET', 'POST')->to('Summary#summary');
  $r->route('/consentToAct')->via('GET', 'POST')->to('ConsentToAct#consentToAct');
}

1;
