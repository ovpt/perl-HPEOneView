package HPEOneView;

use strict;
use warnings;
use HPEOneView::Clients::Security::LoginSessions ();

require Exporter;

our $VERSION = '0.01';
our @ISA = qw(Exporter);
our %EXPORT_TAGS = ('all' => [qw()]);
our @EXPORT_OK = (@{$EXPORT_TAGS{'all'}});
our @EXPORT = qw();

sub new {
    my $login_sessions = HPEOneView::Clients::Security::LoginSessions->new;
    
}



1;
