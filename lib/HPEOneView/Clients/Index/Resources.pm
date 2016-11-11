package HPEOneView::Clients::Index::Resources;

use strict;
use warnings;
use JSON::Create 'create_json';
use JSON::Parse 'parse_json';
use URI;
use HPEOneView::Uris::Index;
use parent 'HPEOneView::Clients::Security::LoginSessions';


sub get_index_resources {
    my ($self, %query) = @_;
    my $_url = URI->new($$self{root_url}.$HPEOneView::Uris::Index::RESOURCES);
    $_url->query_form(%query);
    return $self->get($_url);
}


1;
