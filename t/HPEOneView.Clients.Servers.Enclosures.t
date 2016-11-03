use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};
my $username = $ENV{HPEOneView_username};
my $password = $ENV{HPEOneView_password};

BEGIN { use_ok('HPEOneView::Clients::Servers::Enclosures') };
BEGIN {use HPEOneView::Clients::Servers::Enclosures};
ok(HPEOneView::Clients::Servers::Enclosures->new, 'create enclosures instance without parameters');
ok(HPEOneView::Clients::Servers::Enclosures->new(hostname=>$hostname, userName=>$username, password=>$password), 'create enclosures instance with credentials');

my $session = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname, userName=>$username, password=>$password);
my $ss = HPEOneView::Clients::Servers::Enclosures->new(session=>$session->session);
ok($ss->get_enclosures(), 'get enclosures without query');
ok($ss->get_enclosures(start=>0, count=>1), 'get enclosures start=0,count=1');

done_testing();
