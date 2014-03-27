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
	$self->updatename(sub { # pass in a callback
        my ($error, $doc) = @_;

        # Render exception page if we get a database error
        return $self->render_exception($error) if $error;

        # Render exception page if no docs are updated
        return $self->render_exception("Failed to update document") unless $doc->{n};

        # Do everything else - we know "updatename" was successful
        $self->addchange;
        $self->findchange;

        #Call the database to get Logo Class
        my $id = $self->session->{id};
        my $class = $self->getlogo;

        #Define array with Companies House logo, add Company Logo if it exists
        my @logos = ('Logo');
        if(defined($class)){ @logos = ('Logo', $class); }

        my $delay = Mojo::IOLoop->delay( sub {
            $self->render('summary/summary');
        });

        #Create the Logo object, nonblocking call to its url, save to the template
        foreach my $logo (@logos) {
            my $object = 'CHProject::Common::' . $logo;
            my $feed = new $object;

            my $end = $delay->begin;
            $self->ua->get($feed->url, sub {
                shift;
                $end->(0, feed => $feed, logo => shift);
            });

            if($logo eq 'Logo'){$self->session(logo => $feed->url);}
            else{ $self->stash(companyLogo=> $feed->url); }
        }
    });
}

1;
