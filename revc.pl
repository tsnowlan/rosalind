#!/usr/bin/perl -w
use strict;

open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
while (my $line = <$in>) {
	chomp $line;
	my $rev = join('', reverse( split( '', $line ) ) );
	$rev =~ tr/ACGT/TGCA/;
	print "$rev\n";
}