package HPEOneView::Util::Message;

use strict;
use warnings;

sub new {
    my ($class, %args) = @_;
    my $producer = defined $args{producer} ? $args{producer} : lc(ref($class));
    my $level = defined $args{message_level} ? $args{message_level} : '';
    my $self = bless({producer => $producer,
                      level => $level}, $class);
    
    return $self;
}

sub p {
    my $self = shift;
    my $level = shift;
    my $msg = shift;
    my %identifer = (debug => '*',
                     info => '+',
                     warn => '-',
                     error => '!');
    $msg =~ s/\n//g;
    print "[$identifer{$level}] $$self{producer} $msg\n";
}

sub debug {
    my $self = shift;
    my $msg = shift;
    $self->p('debug', $msg) if $$self{level} =~ /debug/i;
}

sub info {
    my $self = shift;
    my $msg = shift;
    $self->p('info', $msg) if $$self{level} =~ /debug|info/i;
}

sub warn {
    my $self = shift;
    my $msg = shift;
    $self->p('warn', $msg) if $$self{level} =~ /debug|info|warn/i;
}

sub error {
    my $self = shift;
    my $msg = shift;
    $self->p('error', $msg) if $$self{level} =~ /debug|info|warn|error/i;
}

1;