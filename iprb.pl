#!/usr/bin/perl -w
use strict;
use Data::Dumper;

die "No file given\n" unless (@ARGV);
open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
while ($_ = <$in>) {
	s/[ \r\n]*$//;
	my ($dom, $het, $rec) = split /\s+/;
	my $total_pop = $dom + $het + $rec;

	my $p_dom1 = $dom / $total_pop;
	my $p_het1 = $het / $total_pop;
	my $p_rec1 = $rec / $total_pop;
	my $p_dom2 = $dom / ($total_pop - 1);
	my $p_het2 = $het / ($total_pop - 1);
	my $p_rec2 = $rec / ($total_pop - 1);

	my $p_dd = $p_dom1 * ($dom - 1) / ($total_pop - 1);
	my $p_dh = $p_dom1 * $p_het2;
	my $p_dr = $p_dom1 * $p_rec2;
	my $p_hd = $p_het1 * $p_dom2;
	my $p_hh = $p_het1 * ($het - 1) / ($total_pop - 1);
	my $p_hr = $p_het1 * $p_rec2;
	my $p_rd = $p_rec1 * $p_dom2;
	my $p_rh = $p_rec1 * $p_het2;
	my $p_rr = $p_rec1 * ($rec - 1) / ($total_pop - 1);

	my $p_dom_dx = $p_dd + $p_dh + $p_dr + $p_hd + $p_rd;
	my $p_dom_hx = 0.75 * $p_hh + 0.5 * ($p_hr + $p_rh);
	my $p_dominant = $p_dom_hx + $p_dom_dx;
	print "$p_dominant\n";
}
close $in;