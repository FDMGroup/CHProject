package CHProject::Controller::ConsentToAct;
use Mojo::Base 'Mojolicious::Controller';
use Mango;
use Mango::BSON;
use lib 'CHProject';

sub consentToAct{
	my ($self) = shift;

	if ($self->req->method eq 'POST'){
		$self->render_later;
	
		#Setting values from user input on webpage

		my $birth = $self->param('birth');
		my $phone = $self->param('phone');
		my $passport = $self->param('passport');
		my $nin = $self->param('nin');
		my $maiden = $self->param('maiden');
		my $eye = $self->param('eye');
		my $father = $self->param('father');
		my $id = $self->session->{id};
		my $count = 0;

		#Validating user input details

		if (defined($birth) && length($birth) == 3){
			my $result = $self->db->collection('Companies')->find_one({_id => $id}, {cta => 'true'})->{'cta'}->{'birth'};
							
			$count = &check($result, $birth, $count);
		}

		if (defined($phone) && length($phone) == 3){
			my $result = $self->db->collection('Companies')->find_one({_id => $id}, {cta => 'true'})->{'cta'}->{'phone'};
			
			$count = &check($result, $phone, $count);
		}

		if (defined($passport) && length($passport) == 3){
			my $result = $self->db->collection('Companies')->find_one({_id => $id}, {cta => 'true'})->{'cta'}->{'passport'};
			
			$count = &check($result, $passport, $count);
		}

		if (defined($nin) && length($nin) == 3){
			my $result = $self->db->collection('Companies')->find_one({_id => $id}, {cta => 'true'})->{'cta'}->{'nin'};
			
			$count = &check($result, $nin, $count);
		}

		if (defined($maiden) && length($maiden) == 3 ){
			my $result = $self->db->collection('Companies')->find_one({_id => $id}, {cta => 'true'})->{'cta'}->{'maiden'};
			
			$count = &check($result, $maiden, $count);
		}

		if (defined($eye) && length($eye) == 3 ){
			my $result = $self->db->collection('Companies')->find_one({_id => $id}, {cta => 'true'})->{'cta'}->{'eye'};
			
			$count = &check($result, $eye, $count);
		}

		if (defined($father) && length($father) == 3 ){
			my $result = $self->db->collection('Companies')->find_one({_id => $id}, {cta => 'true'})->{'cta'}->{'father'};
			
			$count = &check($result, $father, $count);
		}

		#Verifying the user has correctly inputted 3 security questions - if
		#successful user will be redirected to summary page		
		
		if($count == 3){
			$self->redirect_to('update');
		} else {
			$self->redirect_to('consentToAct');
		}
	}
}

sub check{
	if($_[0] eq $_[1]){
		$_[2] ++;
	}
	return $_[2];
}
1;
