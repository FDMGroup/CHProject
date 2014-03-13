package CHProject::Controller::Summary;
use Mojo::Base 'Mojolicious::Controller';
#use Mango;
#use Mango::BSON qw/ ;

sub summary{
	my $self = shift;
	my $id = $self->session->{id};
	my $oldname = $self->session->{oldname};
	my $newname = $self->session->{newname};

	$self->render;
}

1;

