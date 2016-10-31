use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};
my $username = $ENV{HPEOneView_username};
my $password = $ENV{HPEOneView_password};

BEGIN { use_ok('HPEOneView::Clients::Storage::StorageVolumes') };
BEGIN {use HPEOneView::Clients::Storage::StorageVolumes};
ok(HPEOneView::Clients::Storage::StorageVolumes->new, 'create storage volumes instance without parameters');
ok(HPEOneView::Clients::Storage::StorageVolumes->new(hostname=>$hostname, userName=>$username, password=>$password), 'create storage volumes instance with credentials');

my $session = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname, userName=>$username, password=>$password);
my $storage_volumes = HPEOneView::Clients::Storage::StorageVolumes->new(session=>$session->session);
ok($storage_volumes->get_storage_volumes(), 'get storage volumes without query');
ok($storage_volumes->get_storage_volumes(start=>0, count=>1), 'get storage volumes start=0,count=1');

done_testing();
