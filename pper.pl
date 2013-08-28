#!/usr/bin/perl -w
use strict;
use Algorithm::Permute;

my ($n, $k) = @ARGV;
die "invalid \$n\n" unless (defined $n and $n !~ /\D/ and $n > 0);

my $p = new Algorithm::Permute([1..$n], 1);

my $count = 0;
while (my @res = $p->next) {
	$count++;
}

$count *= $n - $_ for (1..$k-1);
print $count % 1000000 , "\n";