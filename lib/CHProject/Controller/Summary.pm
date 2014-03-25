package CHProject::Controller::Summary;
use Mojo::Base 'Mojolicious::Controller';
use CHProject::Common::Logo;
use CHProject::Common::TescoLogo;
use CHProject::Common::EELogo;
use CHProject::Common::DominosLogo;
use Mojo::IOLoop;
use Data::Dumper;
use Carp;

sub summary{
	#Delay render until called, get value of ID and create delay
	my $self = shift;
	$self->render_later;

	#Database Helpers - Update the name, add a change log and call that change
	$self->updatename;
	$self->addchange;
	$self->findchange;

	my $id = $self->session->{id};
	my @logos = ('Logo', 'TescoLogo', 'EELogo', 'DominosLogo');

	my $delay = Mojo::IOLoop->delay( sub {
		$self->render('summary/summary');
	});

	foreach my $logo (@logos) {
		my $object = 'CHProject::Common::' . $logo;
		my $feed = new $object;

		my $end = $delay->begin;
		$self->ua->get($feed->url, sub {
			shift;
			$end->(0, feed => $feed, logo => shift);
		});

		if($logo eq 'Logo'){$self->stash(logo => $feed->url);}
		if($id eq '1' && $logo eq 'DominosLogo'){$self->stash(companyLogo => $feed->url);}
		if($id eq '2' && $logo eq 'TescoLogo'){$self->stash(companyLogo => $feed->url);}
		if($id eq '5' && $logo eq 'EELogo'){$self->stash(companyLogo=> $feed->url);}
	}
}

1;
