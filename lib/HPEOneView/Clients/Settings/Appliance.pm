package HPEOneView::Clients::Settings::Appliance;

use strict;
use warnings;
use HTTP::Headers;
use parent 'HPEOneView::Clients::BaseClient';


sub get_nodeinfo_status {
    my $self = shift;
    my $uri = $$self{root_url}.'/rest/appliance/nodeinfo/status';
    return $self->get($uri);
}

sub get_nodeinfo_version {
    my $self = shift;
    my $uri = $$self{root_url}.'/rest/appliance/nodeinfo/status';
    return $self->get($uri);
}
1;