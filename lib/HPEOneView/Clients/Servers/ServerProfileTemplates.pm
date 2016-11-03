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


1;
