package CHProject::Controller::ConsentToAct;
use Mojo::Base 'Mojolicious::Controller';
use Mango;
use Mango::BSON;
use lib 'CHProject';

sub consentToAct{
	my $self = shift;

	if ($self->req->method eq 'POST'){
		$self->render_later;

		#Setting values from user input on webpage

		my $birth = $self->param( 'birth');
		my $phone = $self->param( 'phone' );
		my $passport = $self->param( 'passport' );
		my $nin = $self->param( 'nin' );
		my $maiden = $self->param( 'maiden' );
		my $eye = $self->param( 'eye' );
		my $father = $self->param( 'father' );
		my $id = $self->session->{id};
		my $count = 0;

		# Validating user input details
		
		if (defined($birth) && length($birth) == 3){	
			my $result = $self->db->collection('Companies')->find_one(
				{_id => $id}, {cta => 'true'})->{'cta'}->{'birth'};

			if($result eq $birth){
				$count ++;
			}

			#my $value = 'birth';
			#$count = &findField($id, $value, $count); 
		}

		if (defined($passport) && length($passport) == 3){
			my $result = $self->db->collection('Companies')->find_one(
				{_id => $id}, {cta => 'true'})->{'cta'}->{'passport'};

			if($result eq $passport){
				$count ++;
			}
		}

		if (defined($nin) && length($nin) == 3){
			my $result = $self->db->collection('Companies')->find_one(
				{_id => $id}, {cta => 'true'})->{'cta'}->{'nin'};
			
			if($result eq $nin){
				$count ++;
			}
		}

		if (defined($maiden) && length($maiden) == 3 ){
			my $result = $self->db->collection('Companies')->find_one(
				{_id => $id}, {cta => 'true'})->{'cta'}->{'maiden'};
			
			if($result eq $maiden){
				$count ++;
			}
		}

		if (defined($eye) && length($eye) == 3 ){
			my $result = $self->db->collection('Companies')->find_one(
				{_id => $id}, {cta => 'true'})->{'cta'}->{'eye'};
			
			if($result eq $eye){
				$count ++;
			}
		}

		if (defined($father) && length($father) == 3 ){
			my $result = $self->db->collection('Companies')->find_one(
				{_id => $id}, {cta => 'true'})->{'cta'}->{'father'};
			
			if($result eq $father){
				$count ++;
			}
		}		
		
		# Verifying the user has correctly inputted 3 security questions - if 
		# successful user be able to view summary page.

		if($count == 3){
			$self->redirect_to('summary');
		} else {
			$self->redirect_to('consentToAct');
		}
	}
}

# Unsuccessful attempt to use a callable function to validate in above if statements to
# reduce repetitve nature of code.

#sub findField{
#	my ($id, $value, $count) = @_;	
#	print "$id , $value, $count";
#	my $result = $self->db->collection('companies')->find_one({_id => $id}, 
#	{cta => 'true'})->{'cta'}->{$value};
#	if($result eq $value){
#		$count ++;
#	}
#}

1;
