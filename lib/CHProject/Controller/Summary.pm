package CHProject::Controller::Summary;
use Mojo::Base 'Mojolicious::Controller';
#use Mango;
#use Mango::BSON qw/ ;

sub summary{
	my $self = shift;
	my $id = $self->stash("id");
	my $oldname = $self->stash("oldname");
	my $newname = $self->stash("newname");

	$self->render;
}

1;

__DATA__
@@summary.html.ep
%include 'summary', oldname => $oldName, newname => $self->param($new_Name), id => $self->param('new_Name')

