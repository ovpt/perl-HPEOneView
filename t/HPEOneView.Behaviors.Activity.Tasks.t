use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};
my $username = $ENV{HPEOneView_username};
my $password = $ENV{HPEOneView_password};

BEGIN { use_ok('HPEOneView::Behaviors::Activity::Tasks') };
BEGIN {use HPEOneView::Behaviors::Activity::Tasks};
ok(HPEOneView::Behaviors::Activity::Tasks->new, 'create tasks instance without parameters');
ok(HPEOneView::Behaviors::Activity::Tasks->new(hostname=>$hostname, userName=>$username, password=>$password), 'create task instance with credentials');

my $session = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname, userName=>$username, password=>$password);
my $task = HPEOneView::Behaviors::Activity::Tasks->new(session=>$session->session);


ok($task->wait_for_task('/rest/tasks/task_uri'), 'wait for task');

done_testing();
