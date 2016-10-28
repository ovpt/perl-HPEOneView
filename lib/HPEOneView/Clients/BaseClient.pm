package HPEOneView::Clients::BaseClient;

use strict;
use warnings;
use parent 'LWP::UserAgent';
use JSON::Parse 'parse_json';
use HTTP::Headers;
use HTTP::Request;
use HPEOneView::Behaviors::Settings::Version;


sub new {
    my ($class, %args) = @_;
    my $default_ssl_opts = {'verify_hostname'=>0, 'SSL_verify_mode'=>0x00};
    my $default_headers = HTTP::Headers->new('User-Agent' => 'perl-HPEOneView',
                                             'Accept' => 'application/json',
                                             'Content-Type' => 'application/json');
    $args{default_headers} = $default_headers;
    $args{ssl_opts} = defined $args{ssl_opts} ? $args{ssl_opts} : $default_ssl_opts;

    my $self = $class->SUPER::new(%args);
    $$self{def_headers} = $default_headers;
    $$self{auth} = defined $args{auth} ? $args{auth} : '';
    $$self{userName} = defined $args{userName} ? $args{userName} : '';
    $$self{password} = defined $args{password} ? $args{password} : '';
    $$self{authLoginDomain} = defined $args{authLoginDomain} ? $args{authLoginDomain} : 'LOCAL';
    $$self{x_api_version} = defined $args{x_api_version} ? $args{x_api_version} : '';
    $$self{hostname} = defined $args{hostname} ? $args{hostname} : '';
    $$self{root_url} = defined $args{hostname} ? 'https://'.$$self{hostname} : '';
    $$self{log_level} = defined $args{log_level} ? $args{log_level} : 'info';

    return bless($self, $class);
}


sub get {
    my ($self, $url) = @_;
    my $resp = $self->SUPER::get($url);
    $self->out($resp);
    return $resp;
}

sub post {
    my ($self, $url, $body, $header) = @_;
    my @headers;
    if ($header) {
        push @headers, $header->flatten();
    } else {
        @headers = $self->default_headers->flatten();
    }

    my $resp = $self->SUPER::post($url, Content=>$body, @headers);
    $self->out($resp);
    return $resp;
}

sub out {
    my ($self, $resp) = @_;
    my $method = $$resp{_request}{_method};
    my $url = $$resp{_request}{_uri_canonical};
    my $content = $resp->content;
    my $response_code = $resp->code;
    my $response_message = $resp->message;
    my $request_body = $$resp{_request}{_content};
    my $headers = $$resp{_request}{_headers}->as_string; 

    if ($resp->is_success) {
        $self->info($method.' '.$url.' '.$response_code.' '.$response_message);
        $self->debug('headers: '.$headers);
        $self->debug('request: '.$request_body);
        $self->debug('response: '.$content);
    } else {
        $self->error($method.' '.$url.' '.$response_code.' '.$response_message);
        $self->error('headers: '.$headers);
        $self->error('request: '.$request_body);
        $self->error('response: '.$content);
    }
}

sub p {
    my $self = shift;
    my $level = shift;
    my $msg = shift;
    my %identifer = (debug => '*',info => '+',warn => '-',error => '!');
    my @lines = split('\n', $msg);
    foreach (@lines) {
       print "[$identifer{$level}] $_\n";
    }
}

sub debug {
    my $self = shift;
    my $msg = shift;
    $self->p('debug', $msg) if $$self{log_level} =~ /debug/i;
}

sub info {
    my $self = shift;
    my $msg = shift;
    $self->p('info', $msg) if $$self{log_level} =~ /debug|info/i;
}

sub warn {
    my $self = shift;
    my $msg = shift;
    $self->p('warn', $msg) if $$self{log_level} =~ /debug|info|warn/i;
}

sub error {
    my $self = shift;
    my $msg = shift;
    $self->p('error', $msg) if $$self{log_level} =~ /debug|info|warn|error/i;
}


1;
