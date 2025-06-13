package Ham::DXCC::Lookup;
use strict;
use warnings;
use Exporter 'import';
use Carp;
use Text::CSV;
use Readonly;

Readonly my $CSV_FILE => __FILE__ =~ s{Ham/DXCC/Lookup\.pm}{../data/ctydat_full.csv}r;

our @EXPORT_OK = qw(lookup_dxcc);
our $VERSION = '0.04';

my %by_prefix;
{
    open my $fh, '<:encoding(utf8)', $CSV_FILE or croak "Can't open $CSV_FILE: $!";
    my $csv = Text::CSV->new({binary=>1, auto_diag=>1});
    my $hdr = $csv->getline($fh);
    $csv->column_names(@$hdr);
    while (my $row = $csv->getline_hr($fh)) {
        my $pre = uc $row->{prefix};
        $by_prefix{$pre} = {
            dxcc      => $row->{dxcc_name},
            iso       => $row->{iso} || '',
            cq_zone   => $row->{cq_zone} || '',
            itu_zone  => $row->{itu_zone} || '',
            continent => $row->{continent} || '',
            lat       => $row->{latitude} || '',
            lon       => $row->{longitude} || '',
            gmt_offset => $row->{gmt_offset} || '',
            dxcc_number => $row->{dxcc_number} || '',
        };
    }
}

sub lookup_dxcc {
    my ($callsign) = @_;
    croak "No callsign provided" unless $callsign;
    $callsign = uc $callsign;
    for my $pre (sort { length($b) <=> length($a) } keys %by_prefix) {
        return $by_prefix{$pre} if index($callsign, $pre) == 0;
    }
    return {
        dxcc       => 'Unknown',
        iso        => '',
        cq_zone    => '',
        itu_zone   => '',
        continent  => '',
        lat        => '',
        lon        => '',
        gmt_offset => '',
        dxcc_number => '',
    };
}

1;

__END__

=head1 NAME

Ham::DXCC::Lookup - Look up DXCC entity and ISO country code from amateur radio callsign

=head1 SYNOPSIS

    use Ham::DXCC::Lookup qw(lookup_dxcc);

    my $info = lookup_dxcc('G4ABC');
    print "DXCC: $info->{dxcc}, ISO: $info->{iso}\n";

=head1 DESCRIPTION

This module provides a simple lookup mechanism to return the DXCC entity and ISO 3166-1 alpha-2 country code from a given amateur radio callsign.

=head1 FUNCTIONS

=head2 lookup_dxcc($callsign)

Returns a hashref with C<dxcc> and C<iso> for the given callsign.

=head1 AUTHOR

Nigel Horne

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut
