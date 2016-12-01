package HPEOneView::Clients::Networking::EthernetNetworks;

use strict;
use warnings;
use JSON::Create 'create_json';
use JSON::Parse 'parse_json';
use URI;
use HPEOneView::Uris::Networking;
use parent 'HPEOneView::Clients::Security::LoginSessions';


sub get_ethernet_networks {
    my ($self, %query) = @_;
    my $_url = URI->new($$self{root_url}.$HPEOneView::Uris::Networking::ETHERNET_NETWORKS);
    $_url->query_form(%query);
    return $self->get($_url);
}

sub create_ethernet_network {
    my ($self, $body) = @_;
    my $_url = URI->new($$self{root_url}.$HPEOneView::Uris::Networking::ETHERNET_NETWORKS);
    return $self->post($_url, $body);
}

1;
