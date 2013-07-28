#!/usr/bin/perl -w
use strict;

die "No file given\n" unless (@ARGV);
open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
my $dna = <$in>;
my $sub = <$in>;
$dna =~ s/[ \r\n]+$//;
$sub =~ s/[ \r\n]+$//;

my $reg = '('.join(q/).*?(/, split(//, $sub)).')';
my @locs;
if ($dna =~ /$reg/) {
	@locs = @-;
} else {
	print "fuckle"
}

shift @locs;
$_++ for (@locs);
print "@locs\n";