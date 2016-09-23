package HPEOneView::Clients::Settings::Version;

use strict;
use warnings;
use HTTP::Headers;
use parent 'HPEOneView::Clients::BaseClient';


sub get_version {
    my $self = shift;
    my $uri = $$self{root_url}.'/rest/version';
    return $self->get($uri);
}


1;