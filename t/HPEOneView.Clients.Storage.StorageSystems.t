use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};
my $username = $ENV{HPEOneView_username};
my $password = $ENV{HPEOneView_password};

BEGIN { use_ok('HPEOneView::Clients::Storage::StorageSystems') };
BEGIN {use HPEOneView::Clients::Storage::StorageSystems};
ok(HPEOneView::Clients::Storage::StorageSystems->new, 'create storage systems instance without parameters');
ok(HPEOneView::Clients::Storage::StorageSystems->new(hostname=>$hostname, userName=>$username, password=>$password), 'create storage systems instance with credentials');

my $session = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname, userName=>$username, password=>$password);
my $ss = HPEOneView::Clients::Storage::StorageSystems->new(session=>$session->session);
ok($ss->get_storage_systems(), 'get storage systems without query');
ok($ss->get_storage_systems(start=>0, count=>1), 'get storage systems start=0,count=1');

done_testing();
