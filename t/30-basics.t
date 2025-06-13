use strict;
use warnings;
use Test::Most tests => 3;

use Ham::DXCC::Lookup qw(lookup_dxcc);

if(!$ENV{'AUTOMATED_TESTING'}) {
	cmp_ok(lookup_dxcc('K1ZZ')->{'dxcc_name'}, 'eq', 'United States', 'K1ZZ country');
	cmp_ok(lookup_dxcc('G4ABC')->{'dxcc_name'}, 'eq', 'England', 'G4ABC country');
	cmp_ok(lookup_dxcc('JA1XYZ')->{'dxcc_name'}, 'eq', 'Japan', 'JA1XYZ country');
}
