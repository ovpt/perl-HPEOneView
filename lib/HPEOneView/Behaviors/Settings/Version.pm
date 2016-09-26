package HPEOneView::Behaviors::Settings::Version;

use strict;
use warnings;
use JSON::Parse 'parse_json';
use HTTP::Headers;
use parent 'HPEOneView::Clients::Settings::Version';


sub get_current_api_version {
    my $self = shift;
    my $resp = $self->get_version();
    my $current_api_version = 0;
    if ($resp->is_success) {
        my $json = parse_json($resp->content);
        $current_api_version = $$json{currentVersion};
    }
    return $current_api_version;
}

1;