use strict;
use warnings;
use Test::More;
use lib '../lib';


my $hostname = $ENV{HPEOneView_hostname};
my $username = $ENV{HPEOneView_username};
my $password = $ENV{HPEOneView_password};

BEGIN { use_ok('HPEOneView::Clients::Security::LoginSessions') };
BEGIN {use HPEOneView::Clients::Security::LoginSessions};
ok(HPEOneView::Clients::Security::LoginSessions->new, 'create login sessions instance without parameters');

my $session_client = HPEOneView::Clients::Security::LoginSessions->new();
ok($session_client->init(hostname=>$hostname, userName=>$username, password=>$password), 'init login session with parameters');

my $session = $session_client->session;
ok(HPEOneView::Clients::Security::LoginSessions->new(session=>$session), 'init login session with active session');

ok(HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname, userName=>$username, password=>$password), 'create login sessions instance with credentials');

done_testing();
