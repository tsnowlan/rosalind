#!/usr/bin/perl -w
use strict;

die "No file given\n" unless (@ARGV);
open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
while (my $line = <$in>) {
	$line =~ s/[ \r\n]+$//;
	my @dna = split //, $line;

	my @farray = (0);
	foreach my $i (1..$#dna) {
		my $j0 = $i - $farray[$i-1];
		foreach my $j ($j0..$i) {
			my $prefix = join '',@dna[0..$i-$j];
			my $substr = join '',@dna[$j..$i];

			if ($prefix eq $substr) {
				$farray[$i] = length $prefix;
				last;
			}
		}
		$farray[$i] ||= 0;
	}
	print "@farray\n";
}
close $in;