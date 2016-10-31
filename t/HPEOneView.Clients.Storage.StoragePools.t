use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};
my $username = $ENV{HPEOneView_username};
my $password = $ENV{HPEOneView_password};

BEGIN { use_ok('HPEOneView::Clients::Storage::StoragePools') };
BEGIN {use HPEOneView::Clients::Storage::StoragePools};
ok(HPEOneView::Clients::Storage::StoragePools->new, 'create storage pools instance without parameters');
ok(HPEOneView::Clients::Storage::StoragePools->new(hostname=>$hostname, userName=>$username, password=>$password), 'create storage pools instance with credentials');

my $session = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname, userName=>$username, password=>$password);
my $ss = HPEOneView::Clients::Storage::StoragePools->new(session=>$session->session);
ok($ss->get_storage_pools(), 'get storage pools without query');
ok($ss->get_storage_pools(start=>0, count=>1), 'get storage pools start=0,count=1');

done_testing();
