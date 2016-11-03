use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};
my $username = $ENV{HPEOneView_username};
my $password = $ENV{HPEOneView_password};

BEGIN { use_ok('HPEOneView::Clients::Servers::ServerProfiles') };
BEGIN {use HPEOneView::Clients::Servers::ServerProfiles};
ok(HPEOneView::Clients::Servers::ServerProfiles->new, 'create server profiles instance without parameters');
ok(HPEOneView::Clients::Servers::ServerProfiles->new(hostname=>$hostname, userName=>$username, password=>$password), 'create server profiles instance with credentials');

my $session = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname, userName=>$username, password=>$password);
my $ss = HPEOneView::Clients::Servers::ServerProfiles->new(session=>$session->session);
ok($ss->get_server_profiles(), 'get server profiles without query');
ok($ss->get_server_profiles(start=>0, count=>1), 'get server profiles start=0,count=1');

done_testing();
