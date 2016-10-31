package HPEOneView::Behaviors::Storage::StorageVolumes;

use strict;
use warnings;
use JSON::Parse 'parse_json';
use HTTP::Headers;
use parent 'HPEOneView::Clients::Storage::StorageVolumes';
use HPEOneView::Clients::Storage::StoragePools;
use HPEOneView::Behaviors::Activity::Tasks;


sub create_volume {
    my $self = shift;
    my $resp = $self->create_volume();
    if ($resp->is_success) {
        my $json = parse_json($resp->content);
    }

    # wait for task
}

1;
