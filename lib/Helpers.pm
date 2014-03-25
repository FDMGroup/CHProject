package Helpers;
use base 'Mojolicious::Plugin';
use Mango;
use Mango::BSON qw\ bson_ts \;

sub register {
	my ($self, $app) = @_;
	
	#Update the Company Document
	$app->helper( updatename => sub {
		my $self = shift;
		$self->db->collection('Companies')->update(
			{ _id => $self->session->{id} },
			{ '$set' => { 'company name' => $self->session->{newname} } },
		);
	});

	#Add Change Document
	$app->helper( addchange => sub {
		my $self = shift;
		$self->db->collection('Changes')->insert(
			{ 'company id' => $self->session->{id},
			  'old name' => $self->session->{oldname},
			  'updated name' => $self->session->{newname},
			  'time' => bson_ts(time) } 
		);
	});

	#Get change info to display
	$app->helper( findchange => sub {
		my $self = shift;
		my $doc = $self->db->collection('Changes')->find_one(
			{ 'company id' => $self->session->{id},
			  'updated name' => $self->session->{newname} } 
		);
		$self->session(
			changeid => $doc->{'_id'},
			oldname => $doc->{'old name'},
			newname => $doc->{'updated name'}
		);
	});
	
	#Get Logo class
	$app->helpers( getlogo => sub {
		my $self = shift;
		return $self->db->collection('Logos')->find_one(
			{ '_id' => $self->session->{id} })->{'class'};
	});
}

1;
