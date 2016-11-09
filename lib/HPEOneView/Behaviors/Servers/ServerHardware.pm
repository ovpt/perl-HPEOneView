package HPEOneView::Behaviors::Servers::ServerHardware;

use strict;
use warnings;
use JSON::Parse 'parse_json';
use HTTP::Headers;
use parent 'HPEOneView::Clients::Servers::ServerHardware';
use HPEOneView::Behaviors::Activity::Tasks;


sub get_sh_without_profile {
    my ($self, %filter) = @_;
    $self->info("get server hardware without profile");
    $filter{filter} = qq("'state'='NoProfileApplied'");
    my $resp = $self->get_server_hardware(%filter);
}

1;
