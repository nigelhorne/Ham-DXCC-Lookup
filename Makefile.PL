use strict;
use warnings;
use ExtUtils::MakeMaker;

if(defined($ENV{'GITHUB_ACTION'}) || defined($ENV{'CIRCLECI'}) || defined($ENV{'TRAVIS_PERL_VERSION'}) || defined($ENV{'APPVEYOR'})) {
	# Prevent downloading and installing stuff
	warn 'AUTOMATED_TESTING added for you' if(!defined($ENV{'AUTOMATED_TESTING'}));
	$ENV{'AUTOMATED_TESTING'} = 1;
	$ENV{'NO_NETWORK_TESTING'} = 1;

	if(!-d 'data') {
		mkdir 'data', 0755;
	}
	open(my $out, '>', 'data/ctydat_full.csv');
	print $out "prefix,dxcc_name,iso,cq_zone,itu_zone,continent,latitude,longitude,gmt_offset,primary_prefix\n";
}

my $dist = {
	COMPRESS => 'gzip -9f',	# Compress tarball using gzip
	SUFFIX => 'gz',	# File suffix for tarball
};

if($^O eq 'darwin') {
	$dist->{'TAR'} = 'gtar';
}

WriteMakefile(
    NAME         => 'Ham::DXCC::Lookup',
    VERSION_FROM => 'lib/Ham/DXCC/Lookup.pm', # finds $VERSION
    AUTHOR       => 'Nigel Horne <njh@nigelhorne.com',
    ABSTRACT_FROM => 'lib/Ham/DXCC/Lookup.pm',
    PREREQ_PM    => {
	'Database::Abstraction' => 0,
        'Exporter' => 0,
	'FindBin' => 0,
	'Text::CSV' => 0,
	}, TEST_REQUIRES => {
		'Test::DescribeMe' => 0,
		'Test::Most' => 0,
		'Test::Needs' => 0,
    },
    META_MERGE => {
        resources => {
            repository => 'https://github.com/nigelhorne/ham-dxcc-lookup',
            bugtracker => 'https://github.com/nigelhorne/ham-dxcc-lookup/issues',
            # license    => 'http://dev.perl.org/licenses/',
        },
    },
    MIN_PERL_VERSION => '5.010',
	PL_FILES => (defined($ENV{'AUTOMATED_TESTING'}) ? {} : {'bin/create_db.PL' => 'bin/create_db'}),
    ($ExtUtils::MakeMaker::VERSION >= 6.64
        ? (LICENSE => 'GPL')
        : ()), dist => $dist,
	clean		=> { FILES => 'Ham-DXCC-Lookup-*' },
);
