#!/usr/bin/perl -w
use strict;
use Data::Dumper;

print "No file given\n" unless (@ARGV);
open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
my (@data, $min);
while (<$in>) {
	s/[ \r\n]+$//;
	push @data, $_;
	$min = $_ if (!$min or length $_ < length $min);
}
close $in;
my $min_len = length $min;

my $lcs = 'A';
my $lcs_len = length $lcs;
foreach my $i (0..$min_len) {
	foreach my $l ($lcs_len..$min_len) {
		my $substr = substr($min, $i, $l);
		my $match = 1;
		foreach my $row (@data) {
			$match = 0 unless ($row =~ /$substr/);
		}

		if ($match and length $substr > $lcs_len) {
			# print "$substr > $lcs\n";
			$lcs = $substr;
			$lcs_len = length $lcs;
		}
	}
}

print "$lcs\n";
