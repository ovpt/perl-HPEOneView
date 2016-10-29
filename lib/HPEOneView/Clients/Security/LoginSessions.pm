package HPEOneView::Clients::Security::LoginSessions;

use strict;
use warnings;
use JSON::Create 'create_json';
use JSON::Parse 'parse_json';
use HPEOneView::Behaviors::Settings::Version;
use parent 'HPEOneView::Clients::BaseClient';


my $uri = '/rest/login-sessions';

sub new {
    my ($class, %args) = @_;
    my $self = $class->SUPER::new(%args);
    if (defined $args{session}) {
        $$self{hostname} = $args{session}{hostname};
        $$self{userName} = $args{session}{userName};
        $$self{password} = $args{session}{password};
        $$self{authLoginDomain} = $args{session}{authLoginDomain};
        $$self{x_api_version} = $args{session}{x_api_version};
        $$self{auth} = $args{session}{auth};
        $$self{root_url} = 'https://'.$$self{hostname} if ! $$self{root_url};
        $self->default_header('x-api-version'=>$$self{x_api_version});
        $self->default_header(auth=>$$self{auth});   
    }

    if (defined $args{hostname} && defined $args{userName} && defined $args{password}) {
        $self->init(%args);
    }


    return bless($self, $class);
}

sub init {
    my ($self, %args) = @_;
    $$self{hostname} = $args{hostname} if (defined $args{hostname});
    $$self{userName} = $args{userName} if (defined $args{userName});
    $$self{password} = $args{password} if (defined $args{password});
    $$self{authLoginDomain} = $args{authLoginDomain} if (defined $args{authLoginDomain});
    $$self{root_url} = 'https://'.$$self{hostname} if ! $$self{root_url};

    # init x_api_version
    if (defined $args{x_api_version}) {
        $$self{x_api_version} = $args{x_api_version};
    } elsif ($$self{hostname}) {
        my $v = HPEOneView::Behaviors::Settings::Version->new(hostname=>$$self{hostname});
        $$self{x_api_version} = $v->get_current_api_version;
    }

    $self->default_header('x-api-version'=>$$self{x_api_version});
    
    # init auth token
    if (defined $args{auth}) {
        $$self{auth} = $args{auth};
    } elsif (! $$self{auth}) {

        my %body = (userName => $$self{userName},
                    password => $$self{password},
                    authLoginDomain => $$self{authLoginDomain});

        my $resp = $self->create_session(%body);
        my $json = parse_json($resp->content);
        $$self{auth} = $$json{sessionID};
    }

    $self->default_header(auth=>$$self{auth});   
    return $$self{auth};
}

sub create_session {
    my ($self, %args) = @_;
    my $url = $$self{root_url}.$uri;
    my %body = (userName=>'', password=>'', authLoginDomain=>'LOCAL');
    $body{userName} = $args{userName} if defined $args{userName};
    $body{password} = $args{password} if defined $args{password};
    $body{authLoginDomain} = $args{authLoginDomain} if defined $args{authLoginDomain};
    return $self->post($url, create_json(\%body));
}

sub auth {
    my $self = shift;
    return $$self{auth};
}

sub session {
    my $self = shift;
    my %session = (hostname => $$self{hostname},
                   userName => $$self{userName},
                   password => $$self{password},
                   authLoginDomain => $$self{authLoginDomain},
                   x_api_version => $$self{x_api_version},
                   auth => $self->auth);
    return \%session;
}

sub reconnect_session {
    
}

sub delete_session {
    
}
1;
