package HPEOneView::Behaviors::Servers::ServerProfiles;

use strict;
use warnings;
use JSON::Parse 'parse_json';
use HTTP::Headers;
use parent 'HPEOneView::Clients::Servers::ServerProfiles';
use HPEOneView::Behaviors::Activity::Tasks;


sub create_sp {
    my ($self, $body) = @_;
    $self->info("creating a server profile");
    my $resp = $self->create_server_profile($body);
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
