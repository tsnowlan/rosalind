#!/usr/bin/perl -w
use strict;

open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
while (my $line = <$in>) {
	my $substr = <$in>;
	$line =~ s/[\r\n]$//;
	$substr =~ s/[\r\n]$//;
	my $line_len = length $line;
	my $subs_len = length $substr;

	my $offset = 0;
	my @locs;
	while ($offset < $line_len) {
		my $res = index($line, $substr, $offset);
		if ($res >= $offset) {
			push @locs, $res+1;
			$offset = $res + 1;
		} else {
			last;
		}
	}
	print "Found $substr ",scalar @locs," times at:\n";
	print join(' ', @locs),"\n";
}
close $in;