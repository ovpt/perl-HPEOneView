#！ /usr/bin/env perl

use strict;
use warnings;
use HPEOneView::Clients::Security::LoginSessions;
use HPEOneView::Behaviors::Activity::Tasks;
use HPEOneView::Behaviors::Networking::EthernetNetworks;


my $hostname = '';
my $username = '';
my $password = '';
# Set this to directory server name if use directory authorization
#my $login_domain = '';


my $login = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname,userName=>$username,password=>$password);
my $net = HPEOneView::Behaviors::Networking::EthernetNetworks->new(session=>$login->session);

open(my $fh, '>', 'ethernet_network_uris');
foreach my $start (0..3) {
    my $id = $start + 1;
    my $name = "ethernet-network-$id";
    print $fh $name;

    my $body = qq({"vlanId":"$id","ethernetNetworkType":"Tagged","subnetUri":null,"purpose":"General","name":"$name","smartLink":true,"privateNetwork":false,"connectionTemplateUri":null,"type":"ethernet-networkV300"});
    if (! $net->create_ethernet_network($body)) {
        print $fh " failed\n";
    }
    print $fh "\n";
}

close $fh;
