package CHProject::Common::Logo;

=head1 NAME

CHProject::Common::Logo;

=head1 DESCRIPTION

Grabs companies house logo

=cut

use Carp;
use Data::Dumper;

sub new {
	my $class = shift;
	my $self = {};

	bless($self, $class);

	$self->{url} = 'http://tinyurl.com/comphouselogo';
	return $self;
}

sub convert {
	my $self = shift;
	my $tx = shift;

	$self->{item} = $tx->res->content->headers->{headers}->{location}[0][0];

	return $self;
}

sub url { return shift->{url}; }

1;
