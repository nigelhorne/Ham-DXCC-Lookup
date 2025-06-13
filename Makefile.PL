use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Ham::DXCC::Lookup',
    VERSION_FROM => 'lib/Ham/DXCC/Lookup.pm', # finds $VERSION
    AUTHOR       => 'Nigel Horne <njh@bandsman.co.uk',
    ABSTRACT     => 'Look up DXCC and ISO country information for amateur radio call signs',
    PREREQ_PM    => {
        'Text::CSV'   => 1.32,
        'Carp'        => 0,
        'Readonly'    => 0,
        'Exporter'    => 0,
    },
    TEST_REQUIRES => {
        'Test::More' => 0.98,
    },
    META_MERGE => {
        resources => {
            repository => 'https://github.com/nigelhorne/ham-dxcc-lookup',
            bugtracker => 'https://github.com/nigelhorne/ham-dxcc-lookup/issues',
            # license    => 'http://dev.perl.org/licenses/',
        },
    },
    MIN_PERL_VERSION => '5.010',
    ($ExtUtils::MakeMaker::VERSION >= 6.64
        ? (LICENSE => 'GPL')
        : ()),
);

