package HPEOneView::Clients::BaseClient;

use strict;
use warnings;
use parent 'LWP::UserAgent';
use JSON::Parse 'parse_json';
use HTTP::Headers;
use HTTP::Request;
use HPEOneView::Util::Message;
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
    $$self{message_level} = defined $args{message_level} ? $args{message_level} : 'info';
    $$self{msg} = HPEOneView::Util::Message->new(producer => $self->get_package_short_name(),
                                                 message_level => $$self{message_level});
    return bless($self, $class);
}


sub get_package_short_name {
    my $self = shift;
    my @modules = split('::', ref($self));
    my @short_names;
    foreach (0..$#modules) {
        if ($_ == $#modules) {
            push @short_names, $modules[$_];
        } else {
            push @short_names, substr($modules[$_],0,1);
        }
    }
    return join('::', @short_names);
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
        $$self{msg}->info($method.' '.$url.' '.$response_code.' '.$response_message);
        $$self{msg}->debug('headers: '.$headers);
        $$self{msg}->debug('request: '.$request_body);
        $$self{msg}->debug('response: '.$content);
    } else {
        $$self{msg}->error($method.' '.$url.' '.$response_code.' '.$response_message);
        $$self{msg}->error('headers: '.$headers);
        $$self{msg}->error('request: '.$request_body);
        $$self{msg}->error('response: '.$content);
    }
}
1;
