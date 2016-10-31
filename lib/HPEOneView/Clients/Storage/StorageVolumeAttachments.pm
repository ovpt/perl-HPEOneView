package HPEOneView::Clients::Storage::StorageVolumeAttachments;

use strict;
use warnings;
use JSON::Create 'create_json';
use JSON::Parse 'parse_json';
use URI;
use HPEOneView::Uris::Storage;
use parent 'HPEOneView::Clients::Security::LoginSessions';


sub get_storage_volume_attachments {
    my ($self, %query) = @_;
    my $_url = URI->new($$self{root_url}.$HPEOneView::Uris::Storage::STORAGE_VOLUME_ATTACHMENTS);
    $_url->query_form(%query);
    return $self->get($_url);
}


1;
