package CHProject::Controller::ChangeName;
use Mojo::Base 'Mojolicious::Controller';
use Mango;
use Mango::BSON;

sub changeName{
	my ($self) = @_;

	if ($self->req->method eq 'POST'){
		$self->render_later;

		#$self->stash(
		#	oldname => $self->param('company_name'),
		#	id => $self->param('company_id'),
		#	newname => $self->param('new_name')
		#);
		
		$self->session(
			oldname => $self->param('company_name'),
			id => $self->param('company_id'),
			newname => $self->param('new_name')
		);

		$self->redirect_to('consentToAct');
	}
}

1;
