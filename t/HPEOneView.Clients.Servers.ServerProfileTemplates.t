use strict;
use warnings;
use Test::More;
use lib '../lib';

my $hostname = $ENV{HPEOneView_hostname};
my $username = $ENV{HPEOneView_username};
my $password = $ENV{HPEOneView_password};

BEGIN { use_ok('HPEOneView::Clients::Servers::ServerProfileTemplates') };
BEGIN {use HPEOneView::Clients::Servers::ServerProfileTemplates};
ok(HPEOneView::Clients::Servers::ServerProfileTemplates->new, 'create server profile templates instance without parameters');
ok(HPEOneView::Clients::Servers::ServerProfileTemplates->new(hostname=>$hostname, userName=>$username, password=>$password), 'create server profile templates instance with credentials');

my $session = HPEOneView::Clients::Security::LoginSessions->new(hostname=>$hostname, userName=>$username, password=>$password);
my $ss = HPEOneView::Clients::Servers::ServerProfileTemplates->new(session=>$session->session);
ok($ss->get_server_profile_templates(), 'get server profile templates without query');
ok($ss->get_server_profile_templates(start=>0, count=>1), 'get server profile templates start=0,count=1');

done_testing();
