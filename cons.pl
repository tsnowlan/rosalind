#!/usr/bin/perl -w
use strict;
use List::Util qw(max);

open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
my @dna;
while (<$in>) {
	s/[ \r\n]+$//;
	push @dna, [split //];
}
close $in;

my (@cons, @profile);
foreach my $pos (0..$#{$dna[0]}) {
	$profile[$pos]->{$_} = 0 for (qw(A C G T));

	foreach my $samp (@dna) {
		$profile[$pos]->{$samp->[$pos]}++;
	}

	$cons[$pos] = max_val($profile[$pos]);
}

print join('', @cons),"\n";
foreach my $nuc (qw(A C G T)) {
	my $str = "$nuc:";
	foreach my $pos (0...$#profile) {
		$str .= " $profile[$pos]->{$nuc}";
	}
	print "$str\n";
}

sub max_val {
	my $pos = shift;
	my %rev = reverse %$pos;
	my $max = max keys %rev;
	return $rev{$max};
}