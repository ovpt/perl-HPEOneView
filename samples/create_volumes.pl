#！ /usr/bin/env perl

use strict;
use warnings;

use HPEOneView::Clients::Security::LoginSessions;
use HPEOneView::Clients::Storage::StorageSystems;
use HPEOneView::Clients::Storage::StorageVolumes;
use HPEOneView::Behaviors::Storage::StorageVolumes;


my $hostname = '';
my $username = '';
my $password = '';
# Set this to directory server name if use directory authorization
#my $login_domain = '';


my $login = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname,userName=>$username,password=>$password);
my $ss = HPEOneView::Clients::Storage::StorageSystems->new(session=>$login->session);
my $sv = HPEOneView::Behaviors::Storage::StorageVolumes->new(session=>$login->session);

# Get 2 storage systems
my %storage_systems;
foreach my $start (0..2) {
    my $resp = $ss->get_storage_systems(start=>$start, count=>1);
    my $json = parse_json($resp->content);
    my $threepar = $json->{members}->[0]; 
    my $managed_pools = $threepar->{managedPools};
    foreach (@$managed_pools) {
        push(@{$storage_systems{$threepar->{name}}}, $_->{uri});
    }
}

open(my $fh, '>', 'storage_pools_uris');
foreach my $name (sort keys %storage_systems) {
    foreach my $pool (@{$storage_systems{$name}}) {
        print $fh "$name $pool\n";
    }
}
close $fh;


my @type = qw(Thin Full);
my @shareable = qw(true false);

open($fh, '>', 'failed_to_create_volumes');
foreach my $name (sort keys %storage_systems) {
    foreach my $pool (@{$storage_systems{$name}}) {
        foreach (1..7) {
            my $size = int(rand(20))*1073741824 || 1073741824;
            my $type = $type[rand(10)%2];
            my $shareable = $shareable[rand(10)%2];
            my $suffix = int(rand(1073741824));
            my $vol_name = "vol-$name-$type-$shareable-$size-$suffix";
            my $body = qq({"name":"$vol_name","description":"","templateUri":null,"snapshotPoolUri":"$pool","provisioningParameters":{"storagePoolUri":"$pool","requestedCapacity":"$size","provisionType":"$type","shareable":$shareable}});
            if (! $sv->create_volume($body)) {
                print $fh "$name $pool $body\n";
            }
        }
    }
}
close $fh;
