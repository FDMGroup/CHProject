package CHProject::Controller::ConsentToAct;
use Mojo::Base 'Mojolicious::Controller';
#use Mango;
#use Mango::BSON qw/ ;
use lib 'CHProject';
use ConsentToActValidate;

sub consentToAct{
	my ($self) = @_;
	
	if ($self->req->method eq 'POST'){
		$self->render_later;

		$self->session(
			birthplace => $self->param('birthplace'),
			phone => $self->param('phone'),
			passport => $self->param('passport'),
			nin => $self->param('nin'),
			maiden => $self->param('maiden'),
			eye => $self->param('eye'),
			father => $self->param('father')
		);
		
		$count = 0;

		if (defined($self->session('birthplace')) && length($self->session('birthplace') == 3){
			$count ++;
		}

		if (defined($self->session('phone')) && length($self->session('phone') == 3){
			$count ++;
		}

		if (defined($self->session('passport')) && length($self->session('passport')) == 3){
			$count ++;
		}

		if (defined($self->session('nin')) && length($self->session('nin')) == 3){
			$count ++;
		}

		if (defined($self->session('maiden')) && length($self->session('maiden')) == 3 ){
			$count ++;
		}

		if (defined($self->session('eye')) && length($self->session('eye')) == 3 ){
			$count ++;
		}

		if (defined($self->session('father')) && length($self->session('father')) == 3 ){
			$count ++;
		}
		
		
		#$check=consentToActValidate();	

		#$self->helper check =>	sub{ state $check = ConsentToActValidate-> new};

		if($count == 3){
			$self->redirect_to('summary');
		} else {
			$self->redirect_to('consentToAct');
		}
	}

1;
