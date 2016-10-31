package HPEOneView::Clients::Storage::StorageVolumes;

use strict;
use warnings;
use JSON::Create 'create_json';
use JSON::Parse 'parse_json';
use URI;
use HPEOneView::Uris::Storage;
use parent 'HPEOneView::Clients::Security::LoginSessions';


sub get_storage_volumes {
    my ($self, %query) = @_;
    my $_url = URI->new($$self{root_url}.$HPEOneView::Uris::Storage::STORAGE_VOLUMES);
    $_url->query_form(%query);
    return $self->get($_url);
}

sub create_storage_volume {
    my ($self, $body) = @_;
    my $_url = URI->new($$self{root_url}.$HPEOneView::Uris::Storage::STORAGE_VOLUMES);
    return $self->post($_url, $body);
}

1;
