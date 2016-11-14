package HPEOneView::Clients::Settings::Appliance;

use strict;
use warnings;
use HTTP::Headers;
use HPEOneView::Uris::Appliance;
use parent 'HPEOneView::Clients::BaseClient';


sub get_nodeinfo_status {
    my $self = shift;
    my $uri = $$self{root_url}.$HPEOneView::Uris::Appliance::NODEINFO_STATUS;
    return $self->get($uri);
}

sub get_nodeinfo_version {
    my $self = shift;
    my $uri = $$self{root_url}.$HPEOneView::Uris::Appliance::NODEINFO_VERSION;
    return $self->get($uri);
}
1;
