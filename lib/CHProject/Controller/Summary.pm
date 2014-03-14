package CHProject::Controller::Summary;
use Mojo::Base 'Mojolicious::Controller';
use Mango;
use Mango::BSON qw\ bson_ts \;
use Mojo::IOLoop;

sub summary{
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
	
	my $delay = Mojo::IOLoop->delay;
	$delay->steps(
		sub {
			my $delay = shift;
			my $end0 = $delay->begin;
			
			my $feed1 = new CHProject::Common::Logo;
			my $feed2 = new CHProject::Common::BookCover;
			
			my $end1 = $delay->begin;
			$self->ua->get( $feed1->url, sub {
				shift;
				$end1->(0, feed1 => $feed1, logo => shift);
			});

			my $end2 = $delay->begin;
			$self->ua->get( $feed2->url, sub {
				shift;
				$end1->(0, feed2 => $feed2, book => shift);
			});
		},
		sub {
			my $delay = shift;
			my $arg = {@_};

			$arg->{feed1}->convert($arg->{logo});
			$arg->{feed2}->convert($arg->{book});

			$self->stash(logo => $arg->{feed1}->items);
			$self->stash(book => $arg->{feed2}->items);
			
			$self->renderr("summary/summary");
		},
	);
}

1;

