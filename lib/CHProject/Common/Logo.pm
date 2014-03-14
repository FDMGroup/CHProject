package CHProject::Common::Logo;

sub new {
	my $class = shift;
	my $self = {};

	bless($self, $class);

	$self->{url} = 'economia.icaew.com/News/~/media/Images/Article%20images/Advertising%20images/CompaniesHouseLOGO.ashx';
	return $self;
}

sub convert {
	my $self = shift;
	my $tx = shift;

	$self->{item} = $tx->res->content->headers->{headers}->{location}[0][0];
	return $self
}

sub url {
	return shift->{url};
}

1;
