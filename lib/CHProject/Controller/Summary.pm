package CHProject::Controller::Summary;
use Mojo::Base 'Mojolicious::Controller';

sub summary{
	my $self = shift;
	my $id = $self->stash("id");
	my $oldname = $self->stash("oldname");
	my $newname = $self->stash("newname");
	
	$self->render("summary/summary");
}

1;

