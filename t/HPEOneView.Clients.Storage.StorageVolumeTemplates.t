use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};
my $username = $ENV{HPEOneView_username};
my $password = $ENV{HPEOneView_password};

BEGIN { use_ok('HPEOneView::Clients::Storage::StorageVolumeTemplates') };
BEGIN {use HPEOneView::Clients::Storage::StorageVolumeTemplates};
ok(HPEOneView::Clients::Storage::StorageVolumeTemplates->new, 'create storage volume templates instance without parameters');
ok(HPEOneView::Clients::Storage::StorageVolumeTemplates->new(hostname=>$hostname, userName=>$username, password=>$password), 'create storage volume templates instance with credentials');

my $session = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname, userName=>$username, password=>$password);
my $ss = HPEOneView::Clients::Storage::StorageVolumeTemplates->new(session=>$session->session);
ok($ss->get_storage_volume_templates(), 'get storage volume templates without query');
ok($ss->get_storage_volume_templates(start=>0, count=>1), 'get storage volume templates start=0,count=1');

done_testing();
