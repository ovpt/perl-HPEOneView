package HPEOneView::Clients::Storage::StorageSystems;

use strict;
use warnings;
use JSON::Create 'create_json';
use JSON::Parse 'parse_json';
use URI;
use HPEOneView::Uris::Storage;
use parent 'HPEOneView::Clients::Security::LoginSessions';


sub get_storage_systems {
    my ($self, %query) = @_;
    my $_url = URI->new($$self{root_url}.$HPEOneView::Uris::Storage::STORAGE_SYSTEMS);
    $_url->query_form(%query);
    return $self->get($_url);
}


1;
