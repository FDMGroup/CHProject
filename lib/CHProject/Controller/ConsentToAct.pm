package CHProject::Controller::ConsentToAct;
use Mojo::Base 'Mojolicious::Controller';
use Mango;
use Mango::BSON;
use lib 'CHProject';

sub consentToAct{
	my ($self) = shift;

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
		
		my $birthplace = $self->session('birthplace');
		my $phone = $self->session('phone');
		my $passport = $self->session('passport');
		my $nin = $self->session('nin');
		my $maiden = $self->session('maiden');
		my $eye = $self->session('eye');
		my $father = $self->session('father');
		my $id = $self->session->{id};
		my $count = 0;

		print $id;

		if (defined($birthplace) && length($birthplace) == 3){
			my $result = $self->db->collection('Companies')->find_one({_id => $id}, {cta => 'true'})->{'cta'}->{'birth'};
						
			if($result eq $birthplace){
				$count ++;
				print $count;
			}
		}

		if (defined($phone) && length($phone) == 3){
			my $result = $self->db->collection('Companies')->find_one({_id => $id}, {cta => 'true'})->{'cta'}->{'birth'};
			
			if($result eq $birthplace){
				$count ++;
			}
		}

		if (defined($passport) && length($passport) == 3){
			my $result = $self->db->collection('Companies')->find_one({_id => $id}, {cta => 'true'})->{'cta'}->{'passport'};
			
			if($result eq $passport){
				$count ++;
			}
		}

		if (defined($nin) && length($nin) == 3){
			my $result = $self->db->collection('Companies')->find_one({_id => $id}, {cta => 'true'})->{'cta'}->{'nin'};
			
			if($result eq $nin){
				$count ++;
			}
		}

		if (defined($maiden) && length($maiden) == 3 ){
			my $result = $self->db->collection('Companies')->find_one({_id => $id}, {cta => 'true'})->{'cta'}->{'maiden'};
			
			if($result eq $maiden){
				$count ++;
			}
		}

		if (defined($eye) && length($eye) == 3 ){
			my $result = $self->db->collection('Companies')->find_one({_id => $id}, {cta => 'true'})->{'cta'}->{'eye'};
			
			if($result eq $eye){
				$count ++;
			}
		}

		if (defined($father) && length($father) == 3 ){
			my $result = $self->db->collection('Companies')->find_one({_id => $id}, {cta => 'true'})->{'cta'}->{'father'};
			
			if($result eq $father){
				$count ++;
			}
		}
		
		
		#$check=consentToActValidate();	

		#$self->helper check =>	sub{ state $check = ConsentToActValidate-> new};

		print $count;		
		
		if($count == 3){
			$self->redirect_to('update');
		} else {
			$self->redirect_to('consentToAct');
		}
	}
}

sub findField{
	
}
1;
