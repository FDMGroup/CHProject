package CHProject::Common::BookCover;

sub new {
	my $class = shift;
	my $self = {};

	bless($self, $class);

	$self->{url} = 'pics.cdn.librarything.com/picsizes/f6/4e/f64ed6f3da98991637275494177445341455542.jpg';
	return $self;
}

sub convert {
	my $self = shift;
	my $tx = shift;

	$self->{item} = $tx->res->content->headers->{headers}->{location}[0][0];

	return $self;
}

sub url {
	return shift->{url};
}

1;
