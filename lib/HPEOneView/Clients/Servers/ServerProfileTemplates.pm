package HPEOneView::Clients::Servers::ServerProfileTemplates;

use strict;
use warnings;
use JSON::Create 'create_json';
use JSON::Parse 'parse_json';
use URI;
use HPEOneView::Uris::Servers;
use parent 'HPEOneView::Clients::Security::LoginSessions';


sub get_server_profile_templates {
    my ($self, %query) = @_;
    my $_url = URI->new($$self{root_url}.$HPEOneView::Uris::Servers::SERVER_PROFILE_TEMPLATES);
    $_url->query_form(%query);
    return $self->get($_url);
}


sub create_server_profile_template {
    my ($self, $body) = @_;
    my $_url = URI->new($$self{root_url}.$HPEOneView::Uris::Servers::SERVER_PROFILE_TEMPLATES);
    return $self->post($_url, $body);
}

sub update_server_profile_template {
    my ($self, $uri, $body) = @_;
    my $_url = URI->new($$self{root_url}.$uri);
    return $self->put($_url, $body);
}

1;
