package HPEOneView::Behaviors::Storage::StorageVolumes;

use strict;
use warnings;
use JSON::Parse 'parse_json';
use HTTP::Headers;
use parent 'HPEOneView::Clients::Storage::StorageVolumes';
use HPEOneView::Clients::Storage::StoragePools;
use HPEOneView::Behaviors::Activity::Tasks;


use Data::Dumper;


sub create_volume {
    my ($self, $body) = @_;
    $self->info("creating a volume");
    my $resp = $self->create_storage_volume($body);
    if ($resp->is_success) {
        my $task_uri = '';
        if ($resp->content) {
            my $task = parse_json($resp->content);
            $task_uri = $task->{uri};
        } elsif ($resp->header('location')) {
            $task_uri = $resp->header('location');
        }

        my $task_client = HPEOneView::Behaviors::Activity::Tasks->new(session=>$self->session);
        return $task_client->wait_for_task($task_uri);
    }
}

1;
