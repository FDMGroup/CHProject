package CHProject::Controller::Update;
use Mojo::Base 'Mojolicious::Controller';
use Mango;
use Mango::BSON qw\ bson_ts \;

sub update{
	#Locally define session variables
	my $self = shift;
	my $id = $self->session->{id};
	my $oldname = $self->session->{oldname};
	my $newname = $self->session->{newname};

	#Update the Company Document
	$self->db->collection('Companies')->update(
		{ _id => $id },
		{ '$set' => { "company name" => $newname } },
	);

	#Add Change Record
	$self->db->collection('Changes')->insert(
		{ 'company id' => $id,
		  'old name' => $oldname,
		  'updated name' => $newname,
		  'time' => bson_ts(time) }
	);

	#Get company info as stored in the change record, display this data
	my $doc = $self->db->collection('Changes')->find_one(
		{ 'company id' => $id,
		  'updated name' => $newname }
	);

	$self->session(
		changeid => $doc->{'_id'},
		oldname => $doc->{'old name'},
		newname => $doc->{'updated name'},
		id => $id
	);

	$self->redirect_to("summary");
}

1;

