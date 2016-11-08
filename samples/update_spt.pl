#！/usr/bin/env perl

use strict;
use warnings;
use JSON::Create 'create_json';
use JSON::Parse 'parse_json';
use HPEOneView::Clients::Security::LoginSessions;
use HPEOneView::Behaviors::Servers::ServerProfileTemplates;

my $hostname = '';
my $username = '';
my $password = '';
# Set this to directory server name if use directory authorization
#my $login_domain = '';

my $login = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname,userName=>$username,password=>$password);
my $spt = HPEOneView::Behaviors::Servers::ServerProfileTemplates->new(session=>$login->session);

open(my $fh, '>', 'spt_uris');
foreach my $start (1..2) {
    my $spt_name = "spt-samples-$start";
    my $resp_target_spt = $spt->get_spt_by_name($spt_name); 
    my $target_spt = parse_json($resp_target_spt->content);
    my $new_spt = $target_spt->{members}->[0];
    # set firmware install type to FirmwareOnly
    $new_spt->{firmware}->{firmwareInstallType} = 'FirmwareOnly';
    my $spt_uri = $new_spt->{uri};
    print $fh "$new_spt->{uri} ";
    if (! $spt->update_spt($spt_uri, create_json($new_spt))) {
        print $fh 'failed';
    }
    print $fh "\n";
}

close $fh;

