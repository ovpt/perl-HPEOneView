package HPEOneView::Behaviors::Networking::EthernetNetworks;

use strict;
use warnings;
use JSON::Parse 'parse_json';
use HTTP::Headers;
use parent 'HPEOneView::Clients::Networking::EthernetNetworks';
use HPEOneView::Behaviors::Activity::Tasks;


sub create_ethernet_network {
    my ($self, $body) = @_;
    $self->info("creating an ethernet network");
    my $resp = $self->SUPER::create_ethernet_network($body);
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
