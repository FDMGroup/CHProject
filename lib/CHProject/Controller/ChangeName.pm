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
			oldName=>$self->param('company_name'),
			id => $self->param('company_id'),
			newName => $self->param('new_name')
		);

		my $oldName = $self->param('company_name');
		my $id = $self->param('company_id');
		my $newName = $self->param('new_name');

		#Check the database for company existance
		my $doc = $self->db->collection('Companies')->find_one({ _id => $id });
		my $valid = $doc->{'company name'};

		#if the company info entered is valid, update the document and redirect
		if($valid eq $oldName){
			$self->db->collection('Companies')->update(
				{ _id => $id },
				{ '$set' => { "company name" => $newName} },
			);

			#Add a record of changes made to a separate collection
			#Will contain standard object IDs for the changes as well as 
			#a reference to the company ID for continuity across changes
			$self->db->collection('Changes')->insert(
				{ 'company id' => $id,
				  'Old Name' => $oldName,
				  'Updated Name' => $newName,
				  'Time' => bson_ts(time) }
			);

			$self->redirect_to("summary");
			return;
		}
		#If invalid, try again
		else {
			$self->redirect_to("changeName");
			return;
		}
	}
}

1;

