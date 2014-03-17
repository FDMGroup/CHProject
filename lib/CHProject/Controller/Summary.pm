package CHProject::Controller::Summary;
use Mojo::Base 'Mojolicious::Controller';
use CHProject::Common::Logo;
use CHProject::Common::TescoLogo;
use CHProject::Common::EELogo;
use Mojo::IOLoop;
use Data::Dumper;
use Carp;

sub summary{
	my $self = shift;
	$self->render_later;
	my $id = $self->session->{id};
	my $delay = Mojo::IOLoop->delay;
	
	$delay->steps(
		sub {
			my $delay = shift;

			my $feed1 = new CHProject::Common::Logo;
			my $feed2 = new CHProject::Common::TescoLogo;
			my $feed3 = new CHProject::Common::EELogo;
		
			my $end1 = $delay->begin;
			$self->ua->get($feed1->url, 
				sub { 
					shift; 
					$end1->(0, feed1 => $feed1, logo => shift); 
				});

			my $end2 = $delay->begin;
			$self->ua->get($feed2->url, 
				sub {
					shift;
					$end2->(0, feed2 => $feed2, tescoLogo => shift);
				});
			
			my $end3 = $delay->begin;
			$self->ua->get($feed3->url, 
				sub {
					shift;
					$end3->(0, feed3 => $feed3, eeLogo => shift);
				});
		},

		sub {
			my $delay = shift;
			my $arg = {@_};

			$arg->{feed1}->convert($arg->{logo});
			$arg->{feed2}->convert($arg->{tescoLogo});
			$arg->{feed3}->convert($arg->{eeLogo});

			$self->session(
				logo => $arg->{feed1}->url,
				tescoLogo => $arg->{feed2}->url,
				eeLogo => $arg->{feed3}->url
			);

			if( $id eq '2') {$self->session(companyLogo => $arg->{feed2}->url);}
			if( $id eq '5') {$self->session(companyLogo => $arg->{feed3}->url);}


			$self->renderer;
		},
	);
}


sub renderer {
	my $self = shift;
	$self->render("summary/summary");
}

1;

