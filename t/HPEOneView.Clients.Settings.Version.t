use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};

BEGIN { use_ok('HPEOneView::Clients::Settings::Version') };
BEGIN {use HPEOneView::Clients::Settings::Version};
ok(HPEOneView::Clients::Settings::Version->new, 'create version instance without parameters');
ok(HPEOneView::Clients::Settings::Version->new(hostname=>$hostname), 'create version instance with hostname');

my $version = HPEOneView::Clients::Settings::Version->new(hostname=>$hostname);
ok($version->get_version(), 'get current api version');

done_testing();
