package HPEOneView::Clients::Security::LoginSessions;

use strict;
use warnings;
use parent 'HPEOneView::Clients::BaseClient';


my $uri = '/rest/login-sessions';

sub create_session {
    my $self = shift;
    return $self->post();
}

sub reconnect_session {
    
}

sub delete_session {
    
}
1;