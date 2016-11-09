package HPEOneView::Behaviors::Activity::Tasks;

use strict;
use warnings;
use JSON::Create 'create_json';
use JSON::Parse 'parse_json';
use URI;
use parent 'HPEOneView::Clients::Activity::Tasks';


sub wait_for_task {
    my ($self, $task_uri, $timeout, $interval) = @_;
    my $_url = URI->new($$self{root_url}.$task_uri);

    # wait for task
    $self->info("waiting for task $task_uri");
    $timeout = $timeout || 900;
    $interval = $interval || 5;
    my $start_timestamp = time;
    my $task = '';
    while (time-$start_timestamp<$timeout) {
        my $resp = $self->get($_url);
        $task = parse_json($resp->content);
        if ($task->{percentComplete} == 100) {
            $self->info("percentComplete 100%");
            last;
        } else {
            $self->debug("percentComplete $task->{percentComplete}%".'%');
            sleep $interval;
        }
    }

    if ($task->{taskState} eq 'Completed') {
        $self->info("taskState $task->{taskState}");
        return 1;
    } else {
        $self->error("taskState $task->{taskState} taskStatus $task->{taskStatus}");
        return 0;
    }
}


1;
