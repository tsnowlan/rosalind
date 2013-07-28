#!/usr/bin/perl
use strict;
use warnings;
use Math::BigInt;
use Data::Dumper;

open my $in, '<', $ARGV[0] or die $!;
chomp(my $line = <$in>);
my ($n, $m) = split /\s/, $line;
my $k = 2;
my @fibtab = gen_fibtab($n, $m, $k);
# print "$_: $fibtab[$_]\n" for (0..$#fibtab);
print $fibtab[$n-1],"\n";

sub gen_fibtab {
	my ($n, $m, $k) = @_;
	# print "n: $n, m: $m, k: $k\n";
	my @tab;
	for my $i (0..$n) {
		if ($i < $m) {
			if ($i < 2) {
				push @tab, 1;
			} else {
				push @tab, $tab[-1] + $tab[-2];
			}
			print "$i: $tab[$i]\n";
		} else {
			my $j = 0;
			$j += $tab[$_] for ($i-$m..$i-2);
			print "$i: $j (",$i-$m," to ",$i-1,")\n";
			push @tab, $j;
		}
	}
	return @tab;
}
 # $i-$m, i-m):