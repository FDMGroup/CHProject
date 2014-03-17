package CHProject::Common::EELogo;

=head1 NAME

CHProject::Common::EELogo

=head1 DESCRIPTION

Grab EE logo

=cut

use Carp;
use Data::Dumper;

sub new {
	my $class = shift;
	my $self = {};

	bless($self, $class);

	$self->{url} = 'http://tinyurl.com/owgznzp';
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
