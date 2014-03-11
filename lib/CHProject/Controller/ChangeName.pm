package CHProject::Controller::ChangeName;
use Mojo::Base 'Mojolicious::Controller';
use Mango;
use Mango::BSON qw/ bson_ts /;

sub changeName{
	my ($self) = @_;
	if ($self->req->method eq 'POST'){
		$self->render_later;

		$self->session(
			oldName=>$self->param('company_name'),
			id => $self->param('company_id'),
			newName => $self->param('new_name')
		);

		my $oldName = $self->param('company_name');
		my $id = $self->param('company_id');
		my $newName = $self->param('new_name');

		$self->redirect_to("changeName");
		return;
		
	}
}

1;

