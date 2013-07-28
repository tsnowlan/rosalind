#!/usr/bin/perl -w
use strict;

die "No file given\n" unless (@ARGV);
open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
(my $alph = <$in>) =~ s/[ \r\n]+$//;
my @alph = split /\s+/, $alph;
(my $n = <$in>) =~ s/[ \r\n]+$//;
close $in;

my @words = @alph;
foreach my $i (1..$n-1) {
	my @newwords;
	foreach my $w (@words) {
		foreach my $b (@alph) {
			push @newwords, $w.$b;
		}
	}
	@words = @newwords;
}
print join "\n",@words,'';