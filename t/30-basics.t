use strict;
use warnings;
use Test::More tests => 4;

use Ham::DXCC::Lookup qw(lookup_dxcc);

is_deeply(lookup_dxcc('K1ZZ'),  { dxcc => 'United States', iso => 'US' }, 'K1ZZ => US');
is_deeply(lookup_dxcc('G4ABC'), { dxcc => 'England',       iso => 'GB' }, 'G4ABC => GB');
is_deeply(lookup_dxcc('JA1XYZ'),{ dxcc => 'Japan',         iso => 'JP' }, 'JA1XYZ => JP');
is_deeply(lookup_dxcc('XYZ123'),{ dxcc => 'Unknown',       iso => 'ZZ' }, 'Unknown callsign');
