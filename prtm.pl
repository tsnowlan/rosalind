#!/usr/bin/perl -w
use strict;

my %mass = map { chomp; split /\s+/ } <DATA>;

print "No file given\n" unless (@ARGV);
open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
while (my $line = <$in>) {
	$line =~ s/[ \r\n]$//;
	my $sum = 18.01528;
	$sum += $mass{$_} for (split //, $line);
	printf ("%0.3f\n", $sum);
}
close $in;

__DATA__
A   71.03711
C   103.00919
D   115.02694
E   129.04259
F   147.06841
G   57.02146
H   137.05891
I   113.08406
K   128.09496
L   113.08406
M   131.04049
N   114.04293
P   97.05276
Q   128.05858
R   156.10111
S   87.03203
T   101.04768
V   99.06841
W   186.07931
Y   163.06333