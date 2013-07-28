#!/usr/bin/perl -w
use strict;
use Data::Dumper;

print "No file given\n" unless (@ARGV);
open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
my @data = <$in>;
close $in;

my $o_k = 3;
my %samps;

while (my $line = shift @data) {
	$line =~ s/[ \r\n]+$//;
	my $id = substr($line, 1);
	my $dna = '';
	
	do { $dna .= shift @data } while (@data and $data[0] !~ /^>/);
	$dna =~ s/\s//gs;
	$samps{$id} = $dna;
}

foreach my $samp1 (sort keys %samps) {
	foreach my $samp2 (sort keys %samps) {
		next if ($samp1 eq $samp2);
		my $tail = substr($samps{$samp1}, -3 );
		my $head = substr($samps{$samp2}, 0, 3);
		if ($tail eq $head) {
			print "$samp1 $samp2\n";
		}
	}
}