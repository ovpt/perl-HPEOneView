package HPEOneView::Clients::Security::LoginSessions;

use strict;
use warnings;
use JSON::Create 'create_json';
use parent 'HPEOneView::Clients::BaseClient';


my $uri = '/rest/login-sessions';

sub create_session {
    my ($self, %args) = @_;
    my $url = $$self{root_url}.$uri;
    my %body = (userName=>'', password=>'', authLoginDomain=>'LOCAL');
    $body{userName} = $args{userName} if defined $args{userName};
    $body{password} = $args{password} if defined $args{password};
    $body{authLoginDomain} = $args{authLoginDomain} if defined $args{authLoginDomain};
    return $self->post($url, create_json(\%body));
}

sub reconnect_session {
    
}

sub delete_session {
    
}
1;
