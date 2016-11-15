use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};
my $username = $ENV{HPEOneView_username};
my $password = $ENV{HPEOneView_password};

BEGIN { use_ok('HPEOneView::Clients::Activity::Alerts') };
BEGIN {use HPEOneView::Clients::Activity::Alerts};
ok(HPEOneView::Clients::Activity::Alerts->new, 'create alerts instance without parameters');
ok(HPEOneView::Clients::Activity::Alerts->new(hostname=>$hostname, userName=>$username, password=>$password), 'create alert instance with credentials');

my $session = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname, userName=>$username, password=>$password);
my $task = HPEOneView::Clients::Activity::Alerts->new(session=>$session->session);


ok($task->get_alerts(), 'get all alerts');
ok($task->get_alert('/rest/alerts/alert_uuid'), 'get specific alert');

done_testing();
