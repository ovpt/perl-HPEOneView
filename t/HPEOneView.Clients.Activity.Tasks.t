use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};
my $username = $ENV{HPEOneView_username};
my $password = $ENV{HPEOneView_password};

BEGIN { use_ok('HPEOneView::Clients::Activity::Tasks') };
BEGIN {use HPEOneView::Clients::Activity::Tasks};
ok(HPEOneView::Clients::Activity::Tasks->new, 'create tasks instance without parameters');
ok(HPEOneView::Clients::Activity::Tasks->new(hostname=>$hostname, userName=>$username, password=>$password), 'create task instance with credentials');

my $session = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname, userName=>$username, password=>$password);
my $task = HPEOneView::Clients::Activity::Tasks->new(session=>$session->session);


ok($task->get_tasks(), 'get all tasks');
ok($task->get_task('/rest/tasks/task_uri'), 'get specific task');

done_testing();
