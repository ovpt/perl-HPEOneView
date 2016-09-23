use ExtUtils::MakeMaker;

WriteMakefile(
    NAME => 'HPEOneView',
    VERSION_FROM => 'lib/HPEOneView.pm',
    PREREQ_PM => {
        'HTTP::Response' => 6,
        'HTTP::Status' => 6,
        'URI' => "1.10",
        'JSON::Parse' => 0.39,
    },
    ABSTRACT_FROM => 'lib/HPEOneView.pm',
    AUTHOR => 'Wenpeng Ni <wenpeng.ni@gmail.com>',
    #LICENSE           => 'perl',
    #Value must be from legacy list of licenses here
    #http://search.cpan.org/perldoc?Module%3A%3ABuild%3A%3AAPI
);
