use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};
my $username = $ENV{HPEOneView_username};
my $password = $ENV{HPEOneView_password};

BEGIN { use_ok('HPEOneView::Clients::Storage::StorageVolumeAttachments') };
BEGIN {use HPEOneView::Clients::Storage::StorageVolumeAttachments};
ok(HPEOneView::Clients::Storage::StorageVolumeAttachments->new, 'create storage volume attachments instance without parameters');
ok(HPEOneView::Clients::Storage::StorageVolumeAttachments->new(hostname=>$hostname, userName=>$username, password=>$password), 'create storage volume attachments instance with credentials');

my $session = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname, userName=>$username, password=>$password);
my $ss = HPEOneView::Clients::Storage::StorageVolumeAttachments->new(session=>$session->session);
ok($ss->get_storage_volume_attachments(), 'get storage volume attachments without query');
ok($ss->get_storage_volume_attachments(start=>0, count=>1), 'get storage volume attachments start=0,count=1');

done_testing();
