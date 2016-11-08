package HPEOneView::Clients::Servers::ServerProfileTemplates;

use strict;
use warnings;
use JSON::Parse 'parse_json';
use JSON::Create 'create_json';
use URI;
use HPEOneView::Uris::Servers;
use parent 'HPEOneView::Clients::Security::LoginSessions';


sub get_server_profile_templates {
    my ($self, %query) = @_;
    my $_url = URI->new($$self{root_url}.$HPEOneView::Uris::Servers::SERVER_PROFILE_TEMPLATES);
    $_url->query_form(%query);
    return $self->get($_url);
}

sub get_server_profile_template {
    my ($self, $uri) = @_;
    my $_url = URI->new($$self{root_url}.$uri);
    return $self->get($_url);
}

sub create_server_profile_template {
    my ($self, $body) = @_;
    my $_url = URI->new($$self{root_url}.$HPEOneView::Uris::Servers::SERVER_PROFILE_TEMPLATES);
    return $self->post($_url, $body);
}

sub update_server_profile_template {
    my ($self, $uri, $body) = @_;
    my $_url = URI->new($$self{root_url}.$uri);
    my $json_current_spt = $self->get_server_profile_template($uri);
    my $new_spt = parse_json($body);
    if (defined $json_current_spt->{eTag}) {
        $new_spt->{eTag} = $json_current_spt->{eTag}
    }

    return $self->put($_url, create_json($new_spt));
}

1;
