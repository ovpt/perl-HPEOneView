package HPEOneView::Clients::Activity::Alerts;

use strict;
use warnings;
use JSON::Create 'create_json';
use JSON::Parse 'parse_json';
use URI;
use HPEOneView::Uris::Activity;
use parent 'HPEOneView::Clients::Security::LoginSessions';


sub get_alerts {
    my ($self, %query) = @_;
    my $_url = URI->new($$self{root_url}.$HPEOneView::Uris::Activity::ALERTS);
    $_url->query_form(%query);
    return $self->get($_url);
}

sub get_alert {
    my ($self, $alert_uri) = @_;
    my $_url = URI->new($$self{root_url}.$alert_uri);
    return $self->get($_url);
}



1;
