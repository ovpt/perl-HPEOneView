package HPEOneView::Clients::Servers::ServerHardware;

use strict;
use warnings;
use JSON::Create 'create_json';
use JSON::Parse 'parse_json';
use URI;
use HPEOneView::Uris::Servers;
use parent 'HPEOneView::Clients::Security::LoginSessions';


sub get_server_hardware {
    my ($self, %query) = @_;
    my $_url = URI->new($$self{root_url}.$HPEOneView::Uris::Servers::SERVER_HARDWARE);
    $_url->query_form(%query);
    return $self->get($_url);
}

sub create_server_hardware {
    my ($self, $body) = @_;
    my $_url = URI->new($$self{root_url}.$HPEOneView::Uris::Servers::SERVER_HARDWARE);
    return $self->post($_url, $body);
}


1;
