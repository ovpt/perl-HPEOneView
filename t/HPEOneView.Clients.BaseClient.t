use strict;
use warnings;
use Test::More;
use lib '../lib';

BEGIN { use_ok('HPEOneView::Clients::BaseClient') };

BEGIN {use HPEOneView::Clients::BaseClient};
ok(HPEOneView::Clients::BaseClient->new, 'create BaseClient instance without parameters');
ok(HPEOneView::Clients::BaseClient->new(auth=>'auth_token'), 'create BaseClient instance with auth token');
ok(HPEOneView::Clients::BaseClient->new(hostname=>'127.0.0.1'), 'create BaseClient instance with hostname');
ok(HPEOneView::Clients::BaseClient->new(x_api_version=>300), 'create BaseClient instance x_api_version');

done_testing();
