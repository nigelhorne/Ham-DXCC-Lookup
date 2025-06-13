package Ham::DXCC::Lookup;

use strict;
use warnings;

use Exporter 'import';
use Database::Abstraction;
use Ham::DXCC::Lookup::DB::ctydat_full;

BEGIN {
	Database::Abstraction::init({ directory => 'data' });
};

my $db = Ham::DXCC::Lookup::DB::ctydat_full->new();
my @prefixes;

our @EXPORT_OK = qw(lookup_dxcc);
our $VERSION = '0.01';

=head1 NAME

Ham::DXCC::Lookup - Look up DXCC entity and ISO country code from amateur radio callsign

=head1 SYNOPSIS

    use Ham::DXCC::Lookup qw(lookup_dxcc);

    my $info = lookup_dxcc('G4ABC');
    print "DXCC: $info->{dxcc_name}\n";

=head1 DESCRIPTION

This module provides a simple lookup mechanism to return the DXCC entity and ISO 3166-1 alpha-2 country code from a given amateur radio callsign.

=head1 FUNCTIONS

=head2 lookup_dxcc($callsign)

Returns a hashref with C<dxcc> for the given callsign.

=cut

sub lookup_dxcc
{
	my $callsign = shift;

	if(my $rc = $db->fetchrow_hashref({ prefix => "=$callsign" })) {
		return $rc;
	}
	if(scalar(@prefixes) == 0) {
		@prefixes = $db->prefix();
	}

	for my $prefix (sort { length($b) <=> length($a) } @prefixes) {
		if(index($callsign, $prefix) == 0) {
			return $db->fetchrow_hashref({ prefix => $prefix });
		}
	}
	return {};
}

1;

__END__

=head1 SUPPORT

This module is provided as-is without any warranty.

=head1 AUTHOR

Nigel Horne, C<< <njh at nigelhorne.com> >>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut
