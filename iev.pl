#!/usr/bin/perl
use strict;
use warnings;

die "No file given\n" unless (@ARGV);
open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
while ($_ = <$in>) {
	chomp;
	my @pairs = (0, split / /);

	my $dx_parents = $pairs[1] + $pairs[2] + $pairs[3];
	my $hh_parents = $pairs[4];
	my $hr_parents = $pairs[5];
	my $rr_parents = $pairs[6];

	my $d_kids = $dx_parents * 2 + $hh_parents * 1.5 + $hr_parents;
	print $d_kids,"\n";
}
close $in;