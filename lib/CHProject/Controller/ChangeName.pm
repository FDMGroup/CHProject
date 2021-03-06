package CHProject::Controller::ChangeName;
use Mojo::Base 'Mojolicious::Controller';
use Mango;
use Mango::BSON qw/ bson_ts /;

sub changeName{
	my ($self) = @_;

	#If user 'Submits' the form
	if ($self->req->method eq 'POST'){
		$self->render_later;

		#Store user inputs to local variables
		$self->session(
			oldname => $self->param('company_name'),
			id => $self->param('company_id'),
			newname => $self->param('new_name')
		);
		
		my $oldname = $self->param('company_name');
		my $id = $self->param('company_id');
		my $newname = $self->param('new_name');
		
		#Check the database for company existance
		my $doc = $self->db->collection('Companies')->find_one({ _id => $id });
		my $valid = $doc->{'company name'};

		#if the company info entered is valid and a new name is not null, redirect to ConsentToAct
		if($valid eq $oldname && length($newname) gt 0){
			$self->redirect_to("consentToAct");
		}
		#If invalid, try again
		else {
			#TODO - reload with error message
			$self->redirect_to("changeName");
			return;
		}
	}
}

1;
