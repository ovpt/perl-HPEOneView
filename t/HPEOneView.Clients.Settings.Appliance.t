use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};

BEGIN { use_ok('HPEOneView::Clients::Settings::Appliance') };
BEGIN {use HPEOneView::Clients::Settings::Appliance};
ok(HPEOneView::Clients::Settings::Appliance->new, 'create appliance instance without parameters');
ok(HPEOneView::Clients::Settings::Appliance->new(hostname=>$hostname), 'create appliance instance with hostname');

my $version = HPEOneView::Clients::Settings::Appliance->new(hostname=>$hostname);
ok($version->get_nodeinfo_status(), 'get appliance node info status');
ok($version->get_nodeinfo_version(), 'get appliance node info version');

done_testing();
