#!/usr/bin/env perl
use strict;
use warnings;
use LWP::Simple;
use Text::CSV;

# Download the AD1C CTY CSV
my $url = 'https://www.country-files.com/cty/cty.csv';
my $csv_text = get($url) or die "Failed to download cty.csv from $url";

my $in_csv  = Text::CSV->new({binary=>1, auto_diag=>1});
my $out_csv = Text::CSV->new({binary=>1, eol=>"\n"});

open my $in_fh,  '<:encoding(utf8)', \$csv_text;
open my $out_fh, '>:encoding(utf8)', 'ctydat_full.csv';

$out_csv->print($out_fh, [qw(prefix dxcc_name iso cq_zone itu_zone continent latitude longitude)]);
$in_csv->column_names($in_csv->getline($in_fh));

while (my $row = $in_csv->getline_hr($in_fh)) {
    # 'prefix' field may contain multiple comma-separated entries
    my @prefixes = split /,\s*/, $row->{prefix};
    for my $p (@prefixes) {
        next unless length $p;
        # Clean up any modifiers
        $p =~ s/^[\*=\~\<\>\{\}\#\[\]\/\+].*//;
        $p =~ s/[#\[\]\(\)]//g;
        next unless $p =~ /\w/;
        $out_csv->print($out_fh, [
            $p,
            $row->{name} // '',
            $row->{adif} // '',      # ADIF 3-letter code
            $row->{cqzone} // '',
            $row->{ituzone} // '',
            $row->{continent} // '',
            $row->{latitude} // '',
            $row->{longitude} // '',
        ]);
    }
}

close $in_fh;
close $out_fh;
print "Generated ctydat_full.csv with full fields\n";
