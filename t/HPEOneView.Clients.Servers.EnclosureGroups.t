use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};
my $username = $ENV{HPEOneView_username};
my $password = $ENV{HPEOneView_password};

BEGIN { use_ok('HPEOneView::Clients::Servers::EnclosureGroups') };
BEGIN {use HPEOneView::Clients::Servers::EnclosureGroups};
ok(HPEOneView::Clients::Servers::EnclosureGroups->new, 'create enclosure groups instance without parameters');
ok(HPEOneView::Clients::Servers::EnclosureGroups->new(hostname=>$hostname, userName=>$username, password=>$password), 'create enclosure groups instance with credentials');

my $session = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname, userName=>$username, password=>$password);
my $ss = HPEOneView::Clients::Servers::EnclosureGroups->new(session=>$session->session);
ok($ss->get_enclosure_groups(), 'get enclosure groups without query');
ok($ss->get_enclosure_groups(start=>0, count=>1), 'get enclosure groups start=0,count=1');

done_testing();
