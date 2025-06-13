#!/usr/bin/env perl
use strict;
use warnings;
use Text::CSV;

my $file = 'data/cty.dat';

open my $cty, '<', $file;

my $csv = Text::CSV->new({binary => 1, eol => "\n"});

open my $out, '>:encoding(utf8)', 'ctydat_full.csv' or die $!;

# Header (added gmt_offset and dxcc_number)
$csv->print($out, [qw(prefix dxcc_name iso cq_zone itu_zone continent latitude longitude gmt_offset dxcc_number)]);

for my $line (split /\n/, $cty) {
    next unless length $line >= 70;  # basic sanity check

    # Unpack fields based on fixed width from AD1C docs:
    # Name(26), DXCC # (4), CQ Zone(3), ITU Zone(3), Latitude(6), Longitude(7),
    # Prefixes (variable at end)
    my ($name, $dxcc_num, $cqzone, $ituzone, $lat, $lon, $prefixes) = unpack('A26 A4 A3 A3 A6 A7 A*', $line);

    $name     =~ s/\s+$//;
    $dxcc_num =~ s/\s+$//;
    $cqzone   =~ s/\s+$//;
    $ituzone  =~ s/\s+$//;
    $lat      =~ s/\s+$//;
    $lon      =~ s/\s+$//;
    $prefixes =~ s/\s+$//;

    # iso and gmt_offset not available in CTY.DAT, so empty or you add a map later
    my $iso = '';
    my $gmt_offset = '';

    # Prefixes can be comma or semicolon separated, often with modifiers (* = ...)
    my @prefix_list = split /[,;]/, $prefixes;

    for my $p (@prefix_list) {
        # Clean modifiers, brackets, etc.
        $p =~ s/^[\*=\~\<\>\{\}\#\[\]\/\+]+//;
        $p =~ s/[\#\[\]\(\)]//g;
        next unless $p =~ /\w/;

        $csv->print($out, [
            $p,
            $name,
            $iso,
            $cqzone,
            $ituzone,
            '',       # continent, not in CTY.DAT
            $lat,
            $lon,
            $gmt_offset,
            $dxcc_num,
        ]);
    }
}

close $out;
print "Generated ctydat_full.csv with DXCC number and GMT offset fields\n";
