package CHProject::Common::TescoLogo;

=head1 NAME

CHProject::Common::TescoLogo

=head1 DESCRIPTION

Grabs Tesco logo

=cut

use Carp;
use Data::Dumper;

sub new {
	my $class = shift;
	my $self = {};

	bless($self, $class);

	$self->{url} = 'http://tinyurl.com/q9cg2rx';
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
