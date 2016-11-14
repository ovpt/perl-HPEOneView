package HPEOneView::Clients::Activity::Tasks;

use strict;
use warnings;
use JSON::Create 'create_json';
use JSON::Parse 'parse_json';
use URI;
use HPEOneView::Uris::Activity;
use parent 'HPEOneView::Clients::Security::LoginSessions';


sub get_tasks {
    my ($self, %query) = @_;
    my $_url = URI->new($$self{root_url}.$HPEOneView::Uris::Activity::TASKS);
    $_url->query_form(%query);
    return $self->get($_url);
}

sub get_task {
    my ($self, $task_uri) = @_;
    my $_url = URI->new($$self{root_url}.$task_uri);
    return $self->get($_url);
}



1;
