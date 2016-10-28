package HPEOneView::Clients::Storage::StorageVolumes;

use strict;
use warnings;
use JSON::Create 'create_json';
use JSON::Parse 'parse_json';
use URI;
use parent 'HPEOneView::Clients::Security::LoginSessions';


my $uri = '/rest/storage-volumes';

sub get_storage_volumes {
    my ($self, %query) = @_;
    my $_url = URI->new($$self{root_url}.$uri);
    $_url->query_form(%query);
    return $self->get($_url);
}


1;