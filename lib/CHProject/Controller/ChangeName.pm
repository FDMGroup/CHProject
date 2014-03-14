package CHProject::Controller::ChangeName;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::IOLoop;
#use Mango;
#use Mango::BSON qw/ bson_ts /;

sub changeName{
	my ($self) = @_;

	#If user 'Submits' the form
	if ($self->req->method eq 'POST'){
		$self->render_later;

		#Store user inputs to local variables
		$self->session(
			oldname => $self->param('company_name'),
			id => $self->param('company_id'),
			newname => $self->param('new_name')
		);
		
		my $oldName = $self->param('company_name');
		my $id = $self->param('company_id');
		my $newname = $self->param('new_name');
		
		my $delay = Mojo::IOLoop->delay;
		
	$delay->steps(
		#Concurrent requests
		sub {
			my $delay = shift;
			my $end = $delay->begin;

			#Check the database for company existance
			my $doc = $self->db->collection('Companies')->find_one({ _id => $id },
				sub {shift; $end->(0, company_err => shift, company => shift); } 
			);
			my $name = $doc->{'company name'};
		},

		sub {
			my $delay = shift;
			my $arg = {@_};
			
			$self->stash(name => $arg->{name};

			my $logo = new CHProject::Objects::LogoFind;
			my $end1 = $delay->begin;
			$self->ua->get($logo->url, sub { shift; $end1->(0, logo => $logo, image => shift); });
		},

		#Delayed Rendering
		sub {
			my $delay = shift;
			my $arg = {@_};

			$arg->{logo}->convert($arg->{image});
			$self->stash( name => $arg->{name});
			$self->stash( image => $arg->{logo}->url);

			#if the company info entered is valid, redirect
			if($valid eq $oldName){
				$self->redirect_to("consentToAct");
			}
			#If invalid, try again
			else {	
				$self->redirect_to("changeName");
				return;
			}
		}
	);

	}
}

1;
