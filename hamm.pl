#!/usr/bin/perl -w
use strict;

open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
while (my $line_a = <$in>) {
	my $line_b = <$in>;
	$line_a =~ s/[\r\n]$//g;
	$line_b =~ s/[\r\n]$//g;
	my @la = split //, $line_a;
	my @lb = split //, $line_b;
	print "la is ", scalar @la,", lb is ", scalar @lb,"\n";

	my $hamm = 0;
	foreach (0..$#la) {
		if ($la[$_] ne $lb[$_]) {
			$hamm++;
			# print "$la[$_] != $lb[$_]\n";
		}
	}

	print "$line_a\n$line_b\n$hamm\n\n";
}
close $in;