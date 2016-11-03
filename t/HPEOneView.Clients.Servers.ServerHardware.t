use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};
my $username = $ENV{HPEOneView_username};
my $password = $ENV{HPEOneView_password};

BEGIN { use_ok('HPEOneView::Clients::Servers::ServerHardware') };
BEGIN {use HPEOneView::Clients::Servers::ServerHardware};
ok(HPEOneView::Clients::Servers::ServerHardware->new, 'create server hardware instance without parameters');
ok(HPEOneView::Clients::Servers::ServerHardware->new(hostname=>$hostname, userName=>$username, password=>$password), 'create server hardware instance with credentials');

my $session = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname, userName=>$username, password=>$password);
my $ss = HPEOneView::Clients::Servers::ServerHardware->new(session=>$session->session);
ok($ss->get_server_hardware(), 'get server hardware without query');
ok($ss->get_server_hardware(start=>0, count=>1), 'get server hardware start=0,count=1');

done_testing();
