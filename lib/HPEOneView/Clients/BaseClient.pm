package HPEOneView::Clients::BaseClient;

use strict;
use warnings;
use parent 'LWP::UserAgent';
use HTTP::Headers;
use HPEOneView::Util::Message;


sub new {
    my ($class, %args) = @_;
    my $self = $class->SUPER::new(%args);
    $$self{def_headers} = HTTP::Headers->new('User-Agent' => 'perl-HPEOneView',
                                             'Accept' => 'application/json',
                                             'Content-Type' => 'application/json');

    $$self{x_api_version} = defined $args{x_api_version} ? $args{x_api_version} : 300;;
    $$self{auth} = defined $args{auth} ? $args{auth} : '';
    $$self{hostname} = defined $args{hostname} ? $args{hostname} : '';
    $$self{protocol} = defined $args{protocol} ? $args{protocol} : 'https';
    $$self{root_url} = defined $args{hostname} ? $$self{protocol}.'://'.$$self{hostname} : '';
    $$self{message_level} = defined $args{message_level} ? $args{message_level} : 'info';
    $$self{msg} = HPEOneView::Util::Message->new(producer => lc(ref($self)),
                                                 message_level => $$self{message_level});
    
    
    return bless($self, $class);
}

sub default_api_version {
    my $self = shift;
    my $version = shift if @_;
    if (defined $version) {
        $$self{x_api_version} = $version;
        $$self{def_headers}{x_api_version} = $version;
    }
}

sub set_auth_token {
    my $self = shift;
    $$self{def_headers}{auth} = shift if @_;
}

sub get {
    my $self = shift;
    my $url = shift;
    my $resp = $self->SUPER::get($url);
    $self->generate_output($resp);
    return $resp;
}

sub generate_output {
    my $self = shift;
    my $resp = shift;
    my $method = $$resp{_request}{_method};
    my $url = $$resp{_request}{_uri_canonical};
    my $content = $resp->content;
    my $response_code = $resp->code;
    my $response_message = $resp->message;
    my $request_body = $$resp{_request}{_content};

    if ($resp->is_success) {
        $$self{msg}->info($method.' '.$url.' '.$response_code.' '.$response_message);
        $$self{msg}->debug('headers: '.$$resp{_request}{_headers}->as_string);
        $$self{msg}->debug('request: '.$request_body);
        $$self{msg}->debug('response: '.$content);
    } else {
        $$self{msg}->error($method.' '.$url.' '.$response_code.' '.$response_message);
        $$self{msg}->error('headers: '.$$resp{_request}{_headers}->as_string);
        $$self{msg}->error('request: '.$request_body);
        $$self{msg}->error('response: '.$content);
    }
}
1;