# Generated from Makefile.PL using makefilepl2cpanfile

requires 'perl', '5.010';

requires 'DBD::CSV';
requires 'Database::Abstraction';
requires 'Exporter';
requires 'FindBin';
requires 'Text::CSV';
requires 'Text::xSV::Slurp';

on 'test' => sub {
	requires 'Test::DescribeMe';
	requires 'Test::Most';
	requires 'Test::Needs';
};
on 'develop' => sub {
	requires 'Devel::Cover';
	requires 'Perl::Critic';
	requires 'Test::Pod';
	requires 'Test::Pod::Coverage';
};
