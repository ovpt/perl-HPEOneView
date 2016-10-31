package HPEOneView::Behaviors::Activity::Tasks;

use strict;
use warnings;
use JSON::Create 'create_json';
use JSON::Parse 'parse_json';
use URI;
use parent 'HPEOneView::Clients::Activity::Tasks';


sub wait_for_task {
    my ($self, $task_uri) = @_;
    my $_url = URI->new($$self{root_url}.$task_uri);
    return $self->get($_url);
}


1;
