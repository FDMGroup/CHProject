package CHProject::Common::DominosLogo;

=head1 NAME

CHProject::Common::DominosLogo

=head1 DESCRIPTION

Grabs Dominos Logo

=cut

use Carp;
use Data::Dumper;

sub new {
	my $class = shift;
	my $self = {};

	bless($self, $class);

	$self->{url} = 'http://tinyurl.com/og2fkb4';
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

