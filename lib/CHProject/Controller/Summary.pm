package CHProject::Controller::Summary;
use Mojo::Base 'Mojolicious::Controller';

sub summary{
	my $self = shift;
	my $id = $self->session("id");
	my $oldname = $self->session("oldname");
	my $newname = $self->session("newname");
	
	$self->render("summary/summary");
}

1;

