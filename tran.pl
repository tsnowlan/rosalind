#!/usr/bin/perl
use strict;
use warnings;
use LWP::Simple;

die "No file given\n" unless (@ARGV);
open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
my @lines;
my $max = 0;
while ($_ = <$in>) {
	next if (/^>/);
	chomp;
	my $nucs = $_;
	while ($_ = <$in>) {
		last if (/^>/);
		chomp;
		$nucs .= $_;
	}
	$max ||= length($nucs) - 1;
	push @lines, [ split //, $nucs ];
}
close $in;

my %type = ( G => 'pur', C => 'pyr', A => 'pur', T => 'pyr' );

my ($transition, $transversion) = (0, 0);
foreach my $i (0..$max) {
	my ($a_nuc, $b_nuc) = ($lines[0]->[$i], $lines[1]->[$i]);
	next if ($a_nuc eq $b_nuc);
	if ($type{$a_nuc} eq $type{$b_nuc}) {
		$transition++;
	} else {
		$transversion++
	}
}
print "transition:   $transition\n";
print "transversion: $transversion\n";
printf "%0.11f\n", $transition / $transversion;