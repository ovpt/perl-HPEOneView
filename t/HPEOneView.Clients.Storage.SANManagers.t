use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};
my $username = $ENV{HPEOneView_username};
my $password = $ENV{HPEOneView_password};

BEGIN { use_ok('HPEOneView::Clients::Storage::SANManagers') };
BEGIN {use HPEOneView::Clients::Storage::SANManagers};
ok(HPEOneView::Clients::Storage::SANManagers->new, 'create SAN managers instance without parameters');
ok(HPEOneView::Clients::Storage::SANManagers->new(hostname=>$hostname, userName=>$username, password=>$password), 'create SAN managers instance with credentials');

my $session = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname, userName=>$username, password=>$password);
my $ss = HPEOneView::Clients::Storage::SANManagers->new(session=>$session->session);
ok($ss->get_san_managers(), 'get SAN managers without query');
ok($ss->get_san_managers(start=>0, count=>1), 'get SAN managers start=0,count=1');

done_testing();
