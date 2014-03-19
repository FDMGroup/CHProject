package CHProject::Controller::ConsentToAct;
use Mojo::Base 'Mojolicious::Controller';
use Mango;
use Mango::BSON;
use lib 'CHProject';

sub consentToAct{
	my ($self) = shift;

	if ($self->req->method eq 'POST'){
		$self->render_later;
	
		#Setting values from user input on webpage as hash
		my %fields = (
			'birth', $self->param('birth'),
			'phone', $self->param('phone'),
			'passport', $self->param('passport'),
			'nin', $self->param('nin'),
			'maiden', $self->param('maiden'),
			'eye', $self->param('eye'),
			'father', $self->param('father')
		);

		my @keys = keys %fields;
		my $id = $self->session->{id};
		my $count = 0;

		#Validating user input details
		for (my $i = 0; $i < 7; $i++){
			if (defined($fields{$keys[$i]}) && length($fields{$keys[$i]}) == 3){
				my $result = $self->db->collection('Companies')->find_one(
					{ _id => $id}, {cta => 'true'})->{'cta'}->{$keys[$i]};
				
				#Calling subroutine &check to validate user input to value stored in database '$result'							
				$count = &check($result, $fields{$keys[$i]}, $count);
			}
		}
		
		#Verifying the user has correctly inputted 3 security questions - if
		#successful user will be redirected to summary page		
		if($count == 3){
			$self->redirect_to('update');
		} else {
			#TODO Error message on redirect
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
