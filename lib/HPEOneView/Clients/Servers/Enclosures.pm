package HPEOneView::Clients::Servers::Enclosures;

use strict;
use warnings;
use JSON::Create 'create_json';
use JSON::Parse 'parse_json';
use URI;
use HPEOneView::Uris::Servers;
use parent 'HPEOneView::Clients::Security::LoginSessions';


sub get_enclosures {
    my ($self, %query) = @_;
    my $_url = URI->new($$self{root_url}.$HPEOneView::Uris::Servers::ENCLOSURES);
    $_url->query_form(%query);
    return $self->get($_url);
}


1;
