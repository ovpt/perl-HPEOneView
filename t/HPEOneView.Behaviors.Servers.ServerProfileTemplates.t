use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};
my $username = $ENV{HPEOneView_username};
my $password = $ENV{HPEOneView_password};

BEGIN { use_ok('HPEOneView::Behaviors::Servers::ServerProfileTemplates') };
BEGIN {use HPEOneView::Behaviors::Servers::ServerProfileTemplates};
ok(HPEOneView::Behaviors::Servers::ServerProfileTemplates->new, 'create server profile templates instance without parameters');
ok(HPEOneView::Behaviors::Servers::ServerProfileTemplates->new(hostname=>$hostname, userName=>$username, password=>$password), 'create server profile templates instance with credentials');

my $session = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname, userName=>$username, password=>$password);
my $ss = HPEOneView::Behaviors::Servers::ServerProfileTemplates->new(session=>$session->session);
ok($ss->get_spt_by_name('test'), 'get server profile templates by name');

done_testing();
