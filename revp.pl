#!/usr/bin/perl -w
use strict;

die "No file given\n" unless (@ARGV);
open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
while (my $line = <$in>) {
	$line =~ s/[ \r\n]+$//;
	my $i = 0;
	my $max = length $line;

	while ($i < $max) {
		foreach my $l (4..8) {
			my $sub = substr $line, $i, $l;
			last if (length $sub < $l);
			print $i+1," $l\n" if ($sub eq rc($sub));
		}
		$i++;
	}
}
close $in;

sub rc {
	my $dna = shift;
	$dna =~ tr/ACGT/TGCA/;
	$dna = reverse $dna;
	return $dna;
}