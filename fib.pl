#!/usr/bin/perl
use strict;
use warnings;
use Math::BigInt;
use Data::Dumper;

open my $in, '<', $ARGV[0] or die $!;
chomp(my $line = <$in>);
my ($n, $k) = split /\s/, $line;
# print "n:\t$n\n";
# print "k:\t$k\n";
# print "n!:\t",factorial($n),"\n";
# print "(n-k)!\t", factorial($n - $k),"\n";
# print "k!\t",factorial($k),"\n";
# my $fib = factorial($n) / (factorial($k) * factorial($n - $k));
# print $fib,"\n";
my @fibtab = gen_fibtab($n, $k);
# print "$_: $fibtab[$_]\n" for (0..$#fibtab);
print $fibtab[-2],"\n";

sub factorial {
	return Math::BigInt->new(shift)->bfac();
}

sub gen_fibtab {
	my ($n, $k) = @_;
	my @tab;
	$tab[$_] = $_ < 2 ? 1 : $tab[$_-1] + $tab[$_-2]*$k for (0..$n);
	return @tab;
}