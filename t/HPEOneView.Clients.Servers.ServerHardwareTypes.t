use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};
my $username = $ENV{HPEOneView_username};
my $password = $ENV{HPEOneView_password};

BEGIN { use_ok('HPEOneView::Clients::Servers::ServerHardwareTypes') };
BEGIN {use HPEOneView::Clients::Servers::ServerHardwareTypes};
ok(HPEOneView::Clients::Servers::ServerHardwareTypes->new, 'create server hardware types instance without parameters');
ok(HPEOneView::Clients::Servers::ServerHardwareTypes->new(hostname=>$hostname, userName=>$username, password=>$password), 'create server hardware types instance with credentials');

my $session = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname, userName=>$username, password=>$password);
my $ss = HPEOneView::Clients::Servers::ServerHardwareTypes->new(session=>$session->session);
ok($ss->get_server_hardware_types(), 'get server hardware types without query');
ok($ss->get_server_hardware_types(start=>0, count=>1), 'get server hardware types start=0,count=1');

done_testing();
