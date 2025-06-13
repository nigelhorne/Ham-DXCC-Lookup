# NAME

Ham::DXCC::Lookup - Look up DXCC entity and ISO country code from amateur radio callsign

# SYNOPSIS

    use Ham::DXCC::Lookup qw(lookup_dxcc);

    my $info = lookup_dxcc('G4ABC');
    print "DXCC: $info->{dxcc_name}\n";

# DESCRIPTION

This module provides a simple lookup mechanism to return the DXCC entity and ISO 3166-1 alpha-2 country code from a given amateur radio callsign.

# FUNCTIONS

## lookup\_dxcc($callsign)

Returns a hashref with `dxcc` for the given callsign.

# SUPPORT

This module is provided as-is without any warranty.

# AUTHOR

Nigel Horne, `<njh at nigelhorne.com>`

# LICENSE

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.
