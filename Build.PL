use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'HTML::FormHandler::Render::Hash',
    license             => 'perl',
    dist_author         => q{Michael Nachbaur <mike@nachbaur.com>},
    dist_version_from   => 'lib/HTML/FormHandler/Render/Hash.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'HTML-FormHandler-Render-Hash-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
