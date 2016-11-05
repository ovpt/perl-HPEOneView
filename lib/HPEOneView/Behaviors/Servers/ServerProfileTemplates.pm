package HPEOneView::Behaviors::Servers::ServerProfileTemplates;

use strict;
use warnings;
use JSON::Parse 'parse_json';
use HTTP::Headers;
use parent 'HPEOneView::Clients::Servers::ServerProfileTemplates';
use HPEOneView::Behaviors::Activity::Tasks;


sub create_spt {
    my ($self, $body) = @_;
    $self->info("creating a server profile template");
    my $resp = $self->create_server_profile_template($body);
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

sub get_spt_by_name {
    my ($self, $name) = @_;
    if (! defined $name) {
        $self->error('no server profile template name specified');
        return 0;
    }

    return $self->get_server_profile_templates(filter=>qq("'name'='$name'"));
}

1;
