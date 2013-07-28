#!/usr/bin/perl -w
use strict;
use List::Util qw(shuffle);

my $n = $ARGV[0];
my $max = fact($n);
print "$max\n";
my @arr = (1 .. $n);
my %sol;
while ( scalar keys %sol < $max) {
	my $str = join ' ', shuffle(@arr);
	$sol{$str}++;
}
print "$_\n" for (sort keys %sol);

sub fact {
	my $z = shift;
	return 0 unless ($z);
	return 1 if ($z == 1);
	return $z * fact($z-1);
}