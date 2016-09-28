package HPEOneView::Clients::Networking::EthernetNetworks;

use strict;
use warnings;
use JSON::Create 'create_json';
use JSON::Parse 'parse_json';
use URI;
use parent 'HPEOneView::Clients::Security::LoginSessions';


my $uri = '/rest/ethernet-networks';

sub get_ethernet_networks {
    my ($self, %query) = @_;
    my $_url = URI->new($$self{root_url}.$uri);
    $_url->query_form(%query);
    return $self->get($_url);
}

sub create_ethernet_network {
    my $self = shift;
}

1;