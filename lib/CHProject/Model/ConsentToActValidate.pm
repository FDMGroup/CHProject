package CHProject;
use Mojo::Base 'Mojolicious';
#use Mango;
#use Mango::BSON qw/ ;

sub consentToActValidate{
			
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
